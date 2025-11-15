import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:traffix/screens/user/models/paychallan.dart';

/// 🎨 Consistent palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class PayChallanScreen extends ConsumerStatefulWidget {
  const PayChallanScreen({super.key});

  @override
  ConsumerState<PayChallanScreen> createState() => _PayChallanScreenState();
}

class _PayChallanScreenState extends ConsumerState<PayChallanScreen> {
  late TextEditingController vehicleNumberController;
  late TextEditingController chassisController;
  late TextEditingController challanController;

  @override
  void initState() {
    super.initState();
    vehicleNumberController = TextEditingController(
      text: ref.read(vehicleNumberProvider),
    );
    chassisController = TextEditingController(
      text: ref.read(chassisLast4Provider),
    );
    challanController = TextEditingController(
      text: ref.read(challanNumberProvider),
    );
  }

  @override
  void dispose() {
    vehicleNumberController.dispose();
    chassisController.dispose();
    challanController.dispose();
    super.dispose();
  }

  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        content: Text(message, style: const TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> handlePayment() async {
    final supabase = Supabase.instance.client;
    final searchBy = ref.read(searchByProvider);
    final vehicleNum = vehicleNumberController.text.trim().toUpperCase();
    final chassis = chassisController.text.trim().toUpperCase();
    final challanId = challanController.text.trim().toUpperCase();

    try {
      Map<String, dynamic>? challan;

      if (searchBy == SearchBy.vehicle) {
        if (vehicleNum.isEmpty || chassis.length != 4) {
          showSnackbar(
            "Please enter valid vehicle number and last 4 digits of chassis.",
            isError: true,
          );
          return;
        }

        final vehicleRes = await supabase
            .from('vehicles')
            .select('id')
            .eq('vehicle_number', vehicleNum)
            .eq('chassis_number', chassis)
            .maybeSingle();

        if (vehicleRes == null) {
          showSnackbar("❌ Vehicle not found. Check inputs.", isError: true);
          return;
        }

        final challanRes = await supabase
            .from('challans')
            .select()
            .eq('vehicle_id', vehicleRes['id'])
            .eq('status', 'unpaid')
            .order('issued_on', ascending: false)
            .limit(1)
            .maybeSingle();

        if (challanRes == null) {
          showSnackbar(
            "✅ Vehicle found, but no unpaid challans.",
            isError: true,
          );
          return;
        }
        challan = challanRes;
      } else {
        if (challanId.isEmpty) {
          showSnackbar("Please enter a valid challan ID.", isError: true);
          return;
        }

        final challanRes = await supabase
            .from('challans')
            .select()
            .eq('id', challanId)
            .eq('status', 'unpaid')
            .maybeSingle();

        if (challanRes == null) {
          showSnackbar("❌ Invalid or already paid challan ID.", isError: true);
          return;
        }

        challan = challanRes;
      }

      await supabase
          .from('challans')
          .update({'status': 'paid'})
          .eq('id', challan['id']);

      await generateReceipt(challan);

      showSnackbar('✅ Payment successful! Receipt downloaded.');
    } catch (e) {
      showSnackbar('⚠️ Something went wrong: ${e.toString()}', isError: true);
    }
  }

  Future<void> generateReceipt(Map<String, dynamic> challan) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "E-Challan Receipt",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text("Challan ID: ${challan['id']}"),
              pw.Text("Amount Paid: ₹${challan['amount']}"),
              pw.Text("Reason: ${challan['reason']}"),
              pw.Text("Status: Paid"),
              pw.Text("Issued On: ${challan['issued_on']}"),
              pw.SizedBox(height: 20),
              pw.Text("Thank you for your payment."),
            ],
          ),
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final searchBy = ref.watch(searchByProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
        title: const Text(
          'Pay E-Challan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<SearchBy>(
                    activeColor: kPrimary,
                    title: const Text(
                      'Vehicle no',
                      style: TextStyle(color: kTextPrimary),
                    ),
                    value: SearchBy.vehicle,
                    groupValue: searchBy,
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(searchByProvider.notifier).state = val;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<SearchBy>(
                    activeColor: kPrimary,
                    title: const Text(
                      'Challan no',
                      style: TextStyle(color: kTextPrimary),
                    ),
                    value: SearchBy.challan,
                    groupValue: searchBy,
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(searchByProvider.notifier).state = val;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (searchBy == SearchBy.vehicle) ...[
              TextField(
                controller: vehicleNumberController,
                decoration: _inputDecoration('Vehicle Number'),
                onChanged: (val) {
                  final uppercase = val.toUpperCase();
                  vehicleNumberController.value = vehicleNumberController.value
                      .copyWith(
                        text: uppercase,
                        selection: TextSelection.collapsed(
                          offset: uppercase.length,
                        ),
                      );
                  ref.read(vehicleNumberProvider.notifier).state = uppercase;
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: chassisController,
                decoration: _inputDecoration('Last 4 digits of Chassis'),
                keyboardType: TextInputType.number,
                maxLength: 4,
                onChanged: (val) {
                  final uppercase = val.toUpperCase();
                  chassisController.value = chassisController.value.copyWith(
                    text: uppercase,
                    selection: TextSelection.collapsed(
                      offset: uppercase.length,
                    ),
                  );
                  ref.read(chassisLast4Provider.notifier).state = uppercase;
                },
              ),
            ] else ...[
              TextField(
                controller: challanController,
                decoration: _inputDecoration('Challan ID'),
                onChanged: (val) {
                  final uppercase = val.toUpperCase();
                  challanController.value = challanController.value.copyWith(
                    text: uppercase,
                    selection: TextSelection.collapsed(
                      offset: uppercase.length,
                    ),
                  );
                  ref.read(challanNumberProvider.notifier).state = uppercase;
                },
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'PAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kTextPrimary),
      filled: true,
      fillColor: kCardBackground,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kTextSecondary),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kPrimary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

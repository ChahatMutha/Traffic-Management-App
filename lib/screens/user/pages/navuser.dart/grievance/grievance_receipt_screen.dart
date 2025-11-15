import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

const titleBold = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);
const labelText = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: kTextSecondary,
);
const bodyText = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: kTextSecondary,
);

final supabase = Supabase.instance.client;

final grievanceReceiptProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final userId = supabase.auth.currentUser!.id;
  final response = await supabase
      .from('grievance_receipt')
      .select()
      .eq('uuid', userId)
      .order('created_at', ascending: false);
  return response;
});

class GrievanceReceiptScreen extends ConsumerStatefulWidget {
  const GrievanceReceiptScreen({super.key});

  @override
  ConsumerState<GrievanceReceiptScreen> createState() =>
      _GrievanceReceiptScreenState();
}

class _GrievanceReceiptScreenState
    extends ConsumerState<GrievanceReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  int _selectedTab = 0; // 0 = form, 1 = submitted

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final newGrievance = {'uuid': supabase.auth.currentUser!.id, ..._formData};
    await supabase.from('grievance_receipt').insert(newGrievance);

    _formKey.currentState!.reset();
    ref.invalidate(grievanceReceiptProvider);
    setState(() => _selectedTab = 1); // Switch to submitted tab after submit

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Grievance Receipt submitted."),
        backgroundColor: kPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildForm() {
    const fields = [
      'receipt_no',
      'amount',
      'challan_no',
      'vehicle_no',
      'mobile_no',
      'wrong_vehicle_no',
      'correct_vehicle_no',
      'chassis_last4',
      'email',
      'reason',
      'remarks',
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: kCardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Receipt Grievance Form", style: titleBold),
                const SizedBox(height: 12),
                for (final field in fields)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      style: bodyText,
                      decoration: InputDecoration(
                        labelText: field.replaceAll('_', ' ').toUpperCase(),
                        labelStyle: labelText,
                        filled: true,
                        fillColor: kBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSaved: (val) => _formData[field] = val ?? '',
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.send),
                  label: const Text("Submit Grievance"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: Center(
          child: Text("No grievance receipts submitted yet.", style: bodyText),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Card(
          color: kCardBackground,
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(
              "Receipt No: ${item['receipt_no']}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount: ₹${item['amount']}", style: bodyText),
                  Text("Vehicle: ${item['vehicle_no']}", style: bodyText),
                  Text(
                    "Wrong Vehicle: ${item['wrong_vehicle_no']}",
                    style: bodyText,
                  ),
                  Text(
                    "Correct Vehicle: ${item['correct_vehicle_no']}",
                    style: bodyText,
                  ),
                  Text("Reason: ${item['reason']}", style: bodyText),
                  Text("Remarks: ${item['remarks']}", style: bodyText),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final grievanceList = ref.watch(grievanceReceiptProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "Grievance Receipt",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleButtons(
                  isSelected: [_selectedTab == 0],
                  onPressed: (_) => setState(() => _selectedTab = 0),
                  borderRadius: BorderRadius.circular(12),
                  selectedColor: Colors.white,
                  fillColor: kPrimary,
                  color: kTextSecondary,
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 160,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Submit Grievance"),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                ToggleButtons(
                  isSelected: [_selectedTab == 1],
                  onPressed: (_) => setState(() => _selectedTab = 1),
                  borderRadius: BorderRadius.circular(12),
                  selectedColor: Colors.white,
                  fillColor: kPrimary,
                  color: kTextSecondary,
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 160,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Submitted Receipts"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: _selectedTab == 0
                  ? _buildForm()
                  : grievanceList.when(
                      data: _buildList,
                      loading: () => const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Center(
                          child: CircularProgressIndicator(color: kPrimary),
                        ),
                      ),
                      error: (err, _) => Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(
                          child: Text(
                            "Error: $err",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

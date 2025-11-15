import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// 🎨 Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// 🖋 Typography
const titleBold = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);

const cardTitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);

const cardSubtitle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kTextSecondary,
);

const bodyText = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: kTextSecondary,
);

const labelText = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: kTextSecondary,
);

final supabase = Supabase.instance.client;

final grievanceListProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final userId = supabase.auth.currentUser!.id;
  final response = await supabase
      .from('grievance_challan')
      .select()
      .eq('uuid', userId)
      .order('created_at', ascending: false);
  return response;
});

class GrievanceChallanScreen extends ConsumerStatefulWidget {
  const GrievanceChallanScreen({super.key});

  @override
  ConsumerState<GrievanceChallanScreen> createState() =>
      _GrievanceChallanScreenState();
}

class _GrievanceChallanScreenState
    extends ConsumerState<GrievanceChallanScreen> {
  bool showForm = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final newGrievance = {'uuid': supabase.auth.currentUser!.id, ..._formData};

    await supabase.from('grievance_challan').insert(newGrievance);
    setState(() => showForm = false);
    ref.invalidate(grievanceListProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Grievance Challan submitted."),
        backgroundColor: kPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildToggleBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            isSelected: [showForm],
            onPressed: (index) => setState(() => showForm = true),
            borderRadius: BorderRadius.circular(10),
            selectedColor: Colors.white,
            color: kTextPrimary,
            fillColor: kPrimary,
            constraints: const BoxConstraints(minHeight: 40, minWidth: 150),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("Submit Grievance"),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ToggleButtons(
            isSelected: [!showForm],
            onPressed: (index) => setState(() => showForm = false),
            borderRadius: BorderRadius.circular(10),
            selectedColor: Colors.white,
            color: kTextPrimary,
            fillColor: kPrimary,
            constraints: const BoxConstraints(minHeight: 40, minWidth: 150),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("My Submissions"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      child: Card(
        color: kCardBackground,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Grievance Details", style: titleBold),
                const SizedBox(height: 12),
                for (final field in [
                  'challan_no',
                  'vehicle_no',
                  'mobile_no',
                  'chassis_last4',
                  'email',
                  'reason',
                  'remarks',
                ])
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
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
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
          child: Text("No grievances submitted yet.", style: bodyText),
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            title: Text("Challan No: ${item['challan_no']}", style: cardTitle),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle: ${item['vehicle_no']}", style: cardSubtitle),
                  Text("Mobile: ${item['mobile_no']}", style: cardSubtitle),
                  Text("Reason: ${item['reason']}", style: cardSubtitle),
                  Text("Remarks: ${item['remarks']}", style: cardSubtitle),
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
    final grievanceList = ref.watch(grievanceListProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "Grievance Challan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildToggleBar(),
            if (showForm) _buildForm(),
            if (!showForm)
              grievanceList.when(
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
          ],
        ),
      ),
    );
  }
}

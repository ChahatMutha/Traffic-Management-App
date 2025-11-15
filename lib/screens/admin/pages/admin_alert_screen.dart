import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// ==== COLORS ====
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ==== MODEL ====
class AlertData {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime alertTime;

  AlertData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.alertTime,
  });

  factory AlertData.fromMap(Map<String, dynamic> map) {
    return AlertData(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      location: map['location'],
      alertTime: DateTime.parse(map['alert_time']),
    );
  }
}

/// ==== STATE ====
final alertListProvider = FutureProvider<List<AlertData>>((ref) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("Not logged in");

  final res = await supabase
      .from('traffic_alerts')
      .select()
      .eq('created_by', user.id)
      .order('alert_time', ascending: false);

  return res.map((e) => AlertData.fromMap(e)).toList();
});

class AlertFormNotifier extends StateNotifier<AsyncValue<void>> {
  AlertFormNotifier() : super(const AsyncData(null));

  Future<void> submitAlert(AlertData data) async {
    state = const AsyncLoading();
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("Not logged in");

      await supabase.from('traffic_alerts').insert({
        'title': data.title,
        'description': data.description,
        'location': data.location,
        'alert_time': data.alertTime.toIso8601String(),
        'created_by': user.id,
      });

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteAlert(String id) async {
    final supabase = Supabase.instance.client;
    await supabase.from('traffic_alerts').delete().eq('id', id);
  }
}

final alertFormProvider =
    StateNotifierProvider<AlertFormNotifier, AsyncValue<void>>(
      (ref) => AlertFormNotifier(),
    );

/// ==== UI ====

class AdminAlertScreen extends ConsumerStatefulWidget {
  const AdminAlertScreen({super.key});

  @override
  ConsumerState<AdminAlertScreen> createState() => _AdminAlertScreenState();
}

class _AdminAlertScreenState extends ConsumerState<AdminAlertScreen> {
  bool showForm = false;

  final _formKey = GlobalKey<FormState>();
  String _title = 'Traffic Jam';
  String _description = '';
  String _location = '';
  DateTime? _alertTime;

  final List<String> titles = ['Traffic Jam', 'Accident', 'Violation'];

  void _resetForm() {
    _formKey.currentState?.reset();
    _title = 'Traffic Jam';
    _description = '';
    _location = '';
    _alertTime = null;
  }

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _alertTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final alerts = ref.watch(alertListProvider);
    final formState = ref.watch(alertFormProvider);
    final formNotifier = ref.read(alertFormProvider.notifier);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        title: const Text("Admin Alerts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/admin/home');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(showForm ? Icons.close : Icons.add, color: Colors.white),
            onPressed: () => setState(() => showForm = !showForm),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: showForm
            ? SingleChildScrollView(
                child: Card(
                  color: kCardBackground,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormField<String>(
                            value: _title,
                            decoration: const InputDecoration(
                              labelText: 'Alert Type',
                              border: OutlineInputBorder(),
                            ),
                            items: titles
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) => setState(() => _title = val!),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) => _description = val,
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (val) => _location = val,
                            validator: (val) =>
                                val == null || val.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text(
                              _alertTime == null
                                  ? 'Pick Alert Date & Time'
                                  : DateFormat(
                                      'yyyy-MM-dd – hh:mm a',
                                    ).format(_alertTime!),
                            ),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: _pickDateTime,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.check),
                            label: formState.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Submit Alert"),
                            onPressed: formState.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate() &&
                                        _alertTime != null) {
                                      final alert = AlertData(
                                        id: '',
                                        title: _title,
                                        description: _description,
                                        location: _location,
                                        alertTime: _alertTime!,
                                      );

                                      await formNotifier.submitAlert(alert);
                                      ref.invalidate(alertListProvider);

                                      setState(() {
                                        showForm = false;
                                        _resetForm();
                                      });

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Alert Created!"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please complete the form.",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : alerts.when(
                data: (list) => list.isEmpty
                    ? const Center(child: Text("No alerts created yet."))
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final alert = list[index];
                          return Card(
                            color: kCardBackground,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                alert.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kTextPrimary,
                                ),
                              ),
                              subtitle: Text(
                                "${alert.description}\nLocation: ${alert.location}\nTime: ${DateFormat('yyyy-MM-dd – hh:mm a').format(alert.alertTime)}",
                                style: const TextStyle(color: kTextSecondary),
                              ),
                              isThreeLine: true,
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () async {
                                  await formNotifier.deleteAlert(alert.id);
                                  ref.invalidate(alertListProvider);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) =>
                    Center(child: Text("Error loading alerts: $err")),
              ),
      ),
    );
  }
}

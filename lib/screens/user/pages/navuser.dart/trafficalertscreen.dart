import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

// === Custom Colors and TextStyles ===
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

const titleBold = TextStyle(
  fontSize: 18,
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

// === Stream Provider for Live Traffic Alerts ===
final trafficAlertsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
      final supabase = Supabase.instance.client;
      return supabase
          .from('traffic_alerts')
          .stream(primaryKey: ['id'])
          .order('alert_time', ascending: false);
    });

// === Main Screen for Displaying Traffic Alerts ===
class UserTrafficAlertScreen extends ConsumerWidget {
  const UserTrafficAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsyncValue = ref.watch(trafficAlertsProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "Traffic Alerts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
      ),
      body: alertsAsyncValue.when(
        data: (alerts) {
          if (alerts.isEmpty) {
            return const Center(
              child: Text("No traffic alerts at the moment.", style: bodyText),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              final title = alert['title'] ?? '';
              final description = alert['description'] ?? '';
              final location = alert['location'] ?? '';
              final alertTimeStr = alert['alert_time'];
              final alertTime =
                  DateTime.tryParse(alertTimeStr ?? '') ?? DateTime.now();
              final formattedTime = DateFormat(
                'MMM dd, yyyy – hh:mm a',
              ).format(alertTime);

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: kCardBackground,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Blue strip
                    Container(
                      width: 6,
                      height: 140,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                    ),
                    // Card content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: titleBold),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              style: bodyText,
                              softWrap: true,
                              maxLines: null,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    location,
                                    style: labelText.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(formattedTime, style: labelText),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: kPrimary)),
        error: (error, _) => Center(
          child: Text(
            'Error loading alerts: $error',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

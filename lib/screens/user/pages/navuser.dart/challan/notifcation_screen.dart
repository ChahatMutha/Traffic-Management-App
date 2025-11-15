import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traffix/screens/user/models/notification_controller.dart';

// Color palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool showUnreadOnly = false;

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => showUnreadOnly = true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: showUnreadOnly ? kPrimary : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Unread',
                          style: TextStyle(
                            color: showUnreadOnly ? Colors.white : kTextPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => showUnreadOnly = false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !showUnreadOnly ? kPrimary : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: !showUnreadOnly
                                ? Colors.white
                                : kTextPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: notifications.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: TextStyle(color: kTextSecondary),
                ),
              ),
              data: (list) {
                final filtered = showUnreadOnly
                    ? list.where((n) => !n.isRead).toList()
                    : list;

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notifications.',
                      style: TextStyle(color: kTextSecondary),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(notificationProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final notif = filtered[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kCardBackground,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          leading: Icon(
                            notif.isRead
                                ? Icons.notifications_none
                                : Icons.notifications_active,
                            color: notif.isRead ? kTextSecondary : kPrimary,
                          ),
                          title: Text(
                            notif.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextPrimary,
                            ),
                          ),
                          subtitle: Text(
                            notif.body,
                            style: const TextStyle(color: kTextSecondary),
                          ),
                          trailing: Text(
                            '${notif.createdAt.hour}:${notif.createdAt.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: kTextSecondary,
                            ),
                          ),
                          onTap: () {
                            notifier.markAsRead(notif.id);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppNotification {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      isRead: map['is_read'] ?? false,
      createdAt: DateTime.parse(map['created_at']).toLocal(),
    );
  }
}

class NotificationNotifier
    extends StateNotifier<AsyncValue<List<AppNotification>>> {
  NotificationNotifier() : super(const AsyncLoading()) {
    _loadNotifications();
    _listenRealtime();
  }

  Future<void> _loadNotifications() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      state = const AsyncData([]);
      return;
    }

    try {
      final data = await supabase
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final list = (data as List)
          .map((row) => AppNotification.fromMap(row))
          .toList();

      state = AsyncData(list);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void _listenRealtime() {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    final channel = supabase.channel('notifications-stream');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'notifications',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: userId,
      ),
      callback: (payload) {
        final newNotif = AppNotification.fromMap(payload.newRecord);
        state = state.whenData((old) => [newNotif, ...old]);
      },
    );

    channel.subscribe();
  }

  Future<void> markAsRead(String id) async {
    try {
      await supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', id);

      state = state.whenData((list) {
        return list.map((n) {
          if (n.id == id) {
            return AppNotification(
              id: n.id,
              title: n.title,
              body: n.body,
              isRead: true,
              createdAt: n.createdAt,
            );
          }
          return n;
        }).toList();
      });
    } catch (_) {}
  }
}

final notificationProvider =
    StateNotifierProvider<
      NotificationNotifier,
      AsyncValue<List<AppNotification>>
    >((ref) => NotificationNotifier());

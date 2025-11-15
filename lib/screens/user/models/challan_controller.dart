import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ChallanNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ChallanNotifier() : super(const AsyncLoading()) {
    loadChallans();
  }

  Future<void> loadChallans() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      state = const AsyncData({});
      return;
    }

    try {
      // ✅ Fetch only VERIFIED vehicles for challan display
      final vehicles = await supabase
          .from('vehicles')
          .select('id, vehicle_number')
          .eq('owner_id', userId)
          .eq('is_verified', true); // 🔥 Filter only admin-approved vehicles

      final vehicleChallanCounts = <String, dynamic>{};

      for (final vehicle in vehicles) {
        final vehicleId = vehicle['id'];

        final challans = await supabase
            .from('challans')
            .select('status')
            .eq('vehicle_id', vehicleId);

        final paid = challans.where((c) => c['status'] == 'paid').length;
        final unpaid = challans.where((c) => c['status'] == 'unpaid').length;

        vehicleChallanCounts[vehicleId] = {
          'vehicle_number': vehicle['vehicle_number'],
          'paid': paid,
          'unpaid': unpaid,
        };
      }

      state = AsyncData(vehicleChallanCounts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final challanProvider =
    StateNotifierProvider<ChallanNotifier, AsyncValue<Map<String, dynamic>>>(
      (ref) => ChallanNotifier(),
    );

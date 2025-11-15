import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

enum ChallanFilter { all, paid, unpaid }

class ChallanDetailNotifier extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final String vehicleId;
  ChallanFilter filter = ChallanFilter.unpaid;

  ChallanDetailNotifier(this.vehicleId) : super(const AsyncLoading()) {
    loadChallans();
  }

  Future<void> loadChallans() async {
    try {
      var query = supabase
          .from('challans')
          .select('*')
          .eq('vehicle_id', vehicleId);

      if (filter != ChallanFilter.all) {
        query = query.eq('status', filter.name);
      }

      final result = await query.order('issued_on', ascending: false);
      state = AsyncData(List<Map<String, dynamic>>.from(result));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void setFilter(ChallanFilter newFilter) {
    filter = newFilter;
    loadChallans();
  }
}

final challanDetailProvider = StateNotifierProvider.family<
    ChallanDetailNotifier,
    AsyncValue<List<Map<String, dynamic>>>,
    String>((ref, vehicleId) {
  return ChallanDetailNotifier(vehicleId);
});
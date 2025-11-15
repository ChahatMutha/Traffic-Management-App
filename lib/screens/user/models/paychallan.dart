import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchBy { vehicle, challan }

final searchByProvider = StateProvider<SearchBy>((ref) => SearchBy.vehicle);
final vehicleNumberProvider = StateProvider<String>((ref) => '');
final chassisLast4Provider = StateProvider<String>((ref) => '');
final challanNumberProvider = StateProvider<String>((ref) => '');
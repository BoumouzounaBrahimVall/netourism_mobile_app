import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedHobbiesProvider = StateProvider<List<String>>((ref) => []);
final selectedPreferencesProvider = StateProvider<List<String>>((ref) => []);

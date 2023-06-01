import 'package:hooks_riverpod/hooks_riverpod.dart';

final addressProvider = StateProvider<String>((ref) {
  return '';
});
final addressProvider2 = StateProvider<List<String>>((ref) {
  return ['Select Destination', '',''];
});

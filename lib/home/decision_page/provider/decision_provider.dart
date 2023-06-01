import 'package:hooks_riverpod/hooks_riverpod.dart';

final decisionProvider = StateProvider<String>((ref) {
  return 'student';
});
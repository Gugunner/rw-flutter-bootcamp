import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputProvider {
  static final instance = InputProvider();

  final emailProvider = StateProvider<String?>((ref) => '');
  final passwordProvider = StateProvider<String?>((ref) => '');
  final submitProvider = StateProvider<bool>((ref) => false);

  final emailStateProvider =
      StateProvider<InputErrorState>((ref) => InputErrorState.idle);

  final passwordStateProvider =
      StateProvider<InputErrorState>((ref) => InputErrorState.idle);

  final showPasswordProvider = StateProvider<bool>((ref) => false);

}

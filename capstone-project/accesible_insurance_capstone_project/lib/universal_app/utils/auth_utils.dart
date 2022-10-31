import 'dart:math';

import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_up/ui/sign_up_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/universal_constants.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/string_extensions.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/regex.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

void checkForm(InputType type, WidgetRef ref) {
  final inputProviderInstance = InputProvider.instance;
  final email = ref.read(inputProviderInstance.emailProvider.state).state;
  final password = ref.read(inputProviderInstance.passwordProvider.state).state;
  var state = InputErrorState.idle;
  if (type == InputType.password) {
    if (password!.isEmpty) {
      state = InputErrorState.emptyPassword;
    } else if (!RegExp(Regex.password).hasMatch(password)) {
      state = InputErrorState.invalidPassword;
    } else if (password.length < UniversalConstants.passwordLength) {
      state = InputErrorState.passwordLength;
    }
    ref.read(inputProviderInstance.passwordStateProvider.notifier).state =
        state;
  } else if (type == InputType.email) {
    if (email!.isEmpty) {
      state = InputErrorState.emptyEmail;
    } else if (email.isNotNullOrEmpty) {
      if (!RegExp(Regex.email).hasMatch(email)) {
        state = InputErrorState.invalidEmail;
      }
    }
    ref.read(inputProviderInstance.emailStateProvider.notifier).state = state;
  }
}

void cleanInputProviders(WidgetRef ref) {
  final inputProviderInstance = InputProvider.instance;
  ref.read(inputProviderInstance.emailStateProvider.notifier).state =
      InputErrorState.idle;
  ref.read(inputProviderInstance.passwordStateProvider.state).state =
      InputErrorState.idle;
  ref.read(checkRulesProvider.notifier).state = false;
  ref.read(inputProviderInstance.emailProvider.notifier).state = null;
  ref.read(inputProviderInstance.passwordProvider.notifier).state = null;
}

//TODO: Delete when the store is added
MasterPolicyModel demoMasterPolicy() {
  final nowDate = DateTime.now();
  final dateFormat = DateFormat('yyyy.MM.dd');
  final activeSince = nowDate;
  final expires = nowDate.add(const Duration(days: 365));
  const location = LocationModel(
    city: 'Mexico City',
    state: 'Mexico City',
    country: 'Mexico',
  );
  final roomDeScription = RoomDescription(
    bedroom: Random().nextInt(5) + 1,
    bathroom: Random().nextInt(4) + 1,
  );
  const status = PolicyStatus.active;
  final length = PolicyType.values.length;
  final randomTypeIndex = Random().nextInt(length - 1);
  final type =
      PolicyType.values.firstWhere((pt) => pt.index == randomTypeIndex);
  final policyId = 'PROP-001${dateFormat.format(nowDate)}.000.001';
  return MasterPolicyModel(
    policyId: policyId,
    type: type,
    currentSI: 0,
    status: status,
    name: policyId,
    location: location,
    roomDescription: roomDeScription,
    activeSince: activeSince,
    expires: expires,
  );
}

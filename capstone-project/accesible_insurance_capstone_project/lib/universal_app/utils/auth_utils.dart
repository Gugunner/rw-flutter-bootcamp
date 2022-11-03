import 'dart:math';

import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_up/ui/sign_up_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
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
MasterPolicyModel demoMasterPolicy(WidgetRef ref) {
  final nowDate = DateTime.now();
  final dateFormat = DateFormat('yyyy.MM.dd');
  final activeSince = nowDate;
  final expires = nowDate.add(const Duration(days: 365));

  const status = PolicyStatus.active;
  final length = PolicyType.values.length;
  final randomTypeIndex = Random().nextInt(length - 1);
  final type =
      PolicyType.values.firstWhere((pt) => pt.index == randomTypeIndex);

  final user =
      ref.read(AppProvider.instance.userProvider.notifier).auth.currentUser;
  var randomIN = Random().nextInt(1000000000) + 1;
  var randomPreIN = Random().nextInt(10);
  final insured = InsuredModel(
    insuredId: 'INS-001${dateFormat.format(nowDate)}.0000.0001',
    name: user?.displayName ?? '',
    lastName: 'Mendez',
    identificationNumber: 'G${randomPreIN}MX$randomIN',
  );
  final randomPremiumPaid =
      double.parse((Random().nextDouble() * 4.99 + 1.99).toStringAsFixed(2));
  final randomSumInsured =
      double.parse((randomPremiumPaid * 140).toStringAsFixed(2));
  if (type == PolicyType.property) {
    final policyId = 'PROP-001${dateFormat.format(nowDate)}.000.001';
    final location = LocationModel(
      city: getCity(),
      state: getState(),
      country: 'Mexico',
    );
    final roomDeScription = RoomDescription(
      bedroom: Random().nextInt(5) + 1,
      bathroom: Random().nextInt(4) + 1,
    );
    return MasterPolicyModel(
      policyId: policyId,
      type: type,
      insured: insured,
      currentSI: randomSumInsured,
      status: status,
      name: policyId,
      location: location,
      roomDescription: roomDeScription,
      activeSince: activeSince,
      expires: expires,
    );
  }
  randomIN = Random().nextInt(1000000000) + 1;
  randomPreIN = Random().nextInt(10);
  final beneficiary = BeneficiaryModel(
    name: getName(),
    lastName: getLastName(),
    identificationNumber: 'G${randomPreIN}MX$randomIN',
    age: Random().nextInt(54) + 18,
  );
  final policyId = 'LIFE-001${dateFormat.format(nowDate)}.000.001';
  return MasterPolicyModel(
    policyId: policyId,
    type: type,
    insured: insured,
    currentSI: randomSumInsured,
    status: status,
    name: policyId,
    activeSince: activeSince,
    expires: expires,
    beneficiary: beneficiary,
  );
}

String getName() {
  const names = [
    'Marco',
    'Jack',
    'Lizbeth',
    'Maria',
    'David',
    'Louis',
    'Jan',
    'Jhon',
    'Renata',
    'Diana',
    'Patrick',
    'George',
    'Kim',
    'Sakura',
    'Chaewon',
    'Hinyun',
    'Ippo',
    'Francis'
  ];
  return names[Random().nextInt(names.length)];
}

String getLastName() {
  const lastNames = [
    'Mendez',
    'Baker',
    'Guinand',
    'Francois',
    'Honda',
    'Thompson',
    'Soprano',
    'Escobar',
    'Marquez',
    'Sanchez',
    'Madrid',
    'Rup',
    'Makanouchi',
    'Jaqcues',
    'Franco',
    'Perez'
  ];
  return lastNames[Random().nextInt(lastNames.length)];
}

String getCity() {
  const cities = [
    'Guadalajara',
    'San Luis Potosi',
    'Jalcomulco',
    'Ciudad Victoria',
    'Aguascalientes',
    'Queretaro',
    'Monterrey',
    'Mexico City',
    'Puerto Vallarta',
    'Puerto Escondido',
    'Chiapas',
    'Cancun',
    'Acapulco',
    'Cuernavaca',
    'Matamoros',
    'Zacatecas',
    'Oaxaca',
    'Mexico State'
  ];
  return cities[Random().nextInt(cities.length)];
}

String getState() {
  const states = [
    'Veracruz',
    'Quintana Roo',
    'Jalisco',
    'Nuevo Leon',
    'Sonora',
    'Baja California Sur',
    'Baja California Norte',
    'Oaxaca',
    'Tamaulipas',
    'Sinaloa',
    'Chihuahua',
    'San Luis Potosi',
    'Puebla',
    'Guerrero',
    'Tijuana',
    'Mexico City',
    'Mexico State',
  ];
  return states[Random().nextInt(states.length)];
}


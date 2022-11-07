
import 'dart:math';

import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

InsuredModel demoInsured(
  WidgetRef ref, {
  required DateTime nowDate,
  required DateFormat dateFormat,
}) {
  final user =
      ref.read(AppProvider.instance.userProvider.notifier).auth.currentUser;
  final randomIN = Random().nextInt(1000000000) + 1;
  final randomPreIN = Random().nextInt(10);
  return InsuredModel(
    insuredId: 'INS-001${dateFormat.format(nowDate)}.0000.0001',
    name: user?.displayName ?? '',
    lastName: 'Mendez',
    identificationNumber: 'G${randomPreIN}MX$randomIN',
  );
}

MasterPolicyModel createDemoPolicy(WidgetRef ref, {required PolicyType type}) {
  final nowDate = DateTime.now();
  final dateFormat = DateFormat('yyyy.MM.dd');
  final expires = nowDate.add(
    const Duration(days: 365),
  );
  //TODO: Read user from provider state and not DI
  final insured = demoInsured(ref, nowDate: nowDate, dateFormat: dateFormat);
  if (type == PolicyType.property) {
    return createPropertyPolicy(
      ref,
      nowDate: nowDate,
      dateFormat: dateFormat,
      expires: expires,
      insured: insured,
    );
  }
  return createLifePolicy(
    ref,
    nowDate: nowDate,
    dateFormat: dateFormat,
    expires: expires,
    insured: insured,
  );
}

MasterPolicyModel createPropertyPolicy(
  WidgetRef ref, {
  required DateTime nowDate,
  required DateFormat dateFormat,
  required DateTime expires,
  required InsuredModel insured,
}) {
  final randomPremiumPaid = double.parse(
    (Random().nextDouble() * 7.99 + 1).toStringAsFixed(2),
  );
  final randomSumInsured = double.parse(
    (randomPremiumPaid * 320).toStringAsFixed(2),
  );
  final policyId = 'PROP-001.${dateFormat.format(nowDate)}.000.001';
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
    type: PolicyType.property,
    insured: insured,
    currentSI: randomSumInsured,
    currentPremium: randomPremiumPaid,
    status: PolicyStatus.active,
    name: policyId,
    location: location,
    roomDescription: roomDeScription,
    activeSince: nowDate,
    expires: expires,
  );
}

MasterPolicyModel createLifePolicy(
  WidgetRef ref, {
  required DateTime nowDate,
  required DateFormat dateFormat,
  required DateTime expires,
  required InsuredModel insured,
}) {
  final randomPremiumPaid = double.parse(
    (Random().nextDouble() * 7.99 + 1).toStringAsFixed(2),
  );
  final randomSumInsured = double.parse(
    (randomPremiumPaid * 320).toStringAsFixed(2),
  );
  final randomIN = Random().nextInt(1000000000) + 1;
  final randomPreIN = Random().nextInt(10);
  final beneficiary = BeneficiaryModel(
    name: getName(),
    lastName: getLastName(),
    identificationNumber: 'G${randomPreIN}MX$randomIN',
    age: Random().nextInt(54) + 18,
  );
  final policyId = 'LIFE-001.${dateFormat.format(nowDate)}.000.001';
  return MasterPolicyModel(
    policyId: policyId,
    type: PolicyType.life,
    insured: insured,
    currentSI: randomSumInsured,
    currentPremium: randomPremiumPaid,
    status: PolicyStatus.active,
    name: policyId,
    activeSince: nowDate,
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
import 'package:cloud_firestore/cloud_firestore.dart';

enum PolicyStatus {
  inactive,
  active,
  pending,
  canceled,
  unknown,
}

enum PolicyType {
  property,
  life,
  unknown,
}

class MasterPolicyModel {
  const MasterPolicyModel({
    required this.policyId,
    required this.type,
    required this.currentSI,
    required this.insured,
    required this.name,
    this.status = PolicyStatus.pending,
    this.location,
    this.roomDescription,
    this.index,
    this.activeSince,
    this.expires,
    this.documentId,
    this.userPicture,
    this.age,
    this.beneficiary,
  });

  final String policyId;
  final num currentSI;
  final InsuredModel insured;
  final PolicyType type;
  final String? documentId;
  final String? userPicture;
  final DateTime? activeSince;
  final DateTime? expires;
  final String name;
  final PolicyStatus? status;
  final LocationModel? location;
  final RoomDescription? roomDescription;
  final BeneficiaryModel? beneficiary;
  final int? index;

  final BeneficiaryModel? age;

  static PolicyType getType(String type) => PolicyType.values
      .firstWhere((v) => v.name == type, orElse: () => PolicyType.unknown);

  static PolicyStatus getStatus(String status) => PolicyStatus.values
      .firstWhere((v) => v.name == status, orElse: () => PolicyStatus.unknown);

  static DateTime? toDate(int? millisecondsSinceEpoch) {
    return millisecondsSinceEpoch != null
        ? DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        : null;
  }

  factory MasterPolicyModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      int index) {
    final data = snapshot.data();
    return MasterPolicyModel(
      policyId: data?['policyId'] as String,
      name: data?['name'] as String,
      currentSI: data?['currentSI'] as num,
      insured: InsuredModel.fromMap(data?['insured']),
      status: getStatus(data?['status']),
      type: getType(data?['type']),
      location: data?['location'] != null
          ? LocationModel.fromMap(data!['location'])
          : null,
      roomDescription: data?['roomDescription'] != null
          ? RoomDescription.fromMap(data!['roomDescription'])
          : null,
      beneficiary: data?['beneficiary'] != null
          ? BeneficiaryModel.fromMap(data!['beneficiary'])
          : null,
      index: index,
      documentId: snapshot.id,
      expires: toDate(data?['expires']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'policyId': policyId,
      'name': name,
      'currentSI': currentSI,
      'insured': insured.toMap(),
      'status': status?.name ?? PolicyStatus.pending.name,
      'type': type.name,
      'location': location?.toMap(),
      'roomDescription': roomDescription?.toMap(),
      'beneficiary': beneficiary?.toMap(),
      'activeSince': activeSince?.millisecondsSinceEpoch,
      'expires': expires?.millisecondsSinceEpoch,
    };
  }

  //TODO: Add copyWith for mutable states
  //TODO: Replace with freezed package usage
  MasterPolicyModel copyWith({
    String? policyId,
    String? documentId,
    InsuredModel? insured,
    DateTime? activeSince,
    DateTime? expires,
    String? name,
    num? currentSI,
    PolicyStatus? status,
    PolicyType? type,
    LocationModel? location,
    RoomDescription? roomDescription,
    BeneficiaryModel? beneficiary,
    int? index,
  }) =>
      MasterPolicyModel(
        policyId: policyId ?? this.policyId,
        documentId: documentId ?? this.documentId,
        insured: insured ?? this.insured,
        activeSince: activeSince ?? this.activeSince,
        expires: expires ?? this.expires,
        name: name ?? this.name,
        currentSI: currentSI ?? this.currentSI,
        status: status ?? this.status,
        type: type ?? this.type,
        location: location ?? this.location,
        roomDescription: roomDescription ?? this.roomDescription,
        beneficiary: beneficiary ?? this.beneficiary,
      );
}

class InsuredModel {
  const InsuredModel({
    required this.insuredId,
    required this.name,
    required this.lastName,
    required this.identificationNumber,
  });

  final String insuredId;
  final String name;
  final String lastName;
  final String identificationNumber;

  factory InsuredModel.fromMap(Map<String, dynamic> data) {
    return InsuredModel(
      insuredId: data['insuredId'] as String,
      name: data['name'] as String,
      lastName: data['lastName'] as String,
      identificationNumber: data['identificationNumber'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'insuredId': insuredId,
        'name': name,
        'lastName': lastName,
        'identificationNumber': identificationNumber,
      };
}

class BeneficiaryModel {
  const BeneficiaryModel({
    required this.name,
    required this.lastName,
    required this.identificationNumber,
    required this.age,
  });

  final String name;
  final String lastName;
  final String identificationNumber;
  final int age;

  factory BeneficiaryModel.fromMap(Map<String, dynamic> data) {
    return BeneficiaryModel(
      name: data['name'] as String,
      lastName: data['lastName'] as String,
      identificationNumber: data['identificationNumber'] as String,
      age: data['age'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'lastName': lastName,
        'identificationNumber': identificationNumber,
        'age': age,
      };
}

class LocationModel {
  const LocationModel({
    this.city,
    this.state,
    this.country,
  });

  final String? city;
  final String? state;
  final String? country;

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    return LocationModel(
      city: data['city'] as String?,
      state: data['state'] as String?,
      country: data['country'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'city': city,
        'state': state,
        'country': country,
      };

  //TODO: Add copyWith for mutable states

}

class RoomDescription {
  const RoomDescription({
    this.bedroom,
    this.bathroom,
  });

  final num? bedroom;
  final num? bathroom;

  factory RoomDescription.fromMap(Map<String, dynamic> data) {
    return RoomDescription(
      bedroom: data['bedroom'] as num?,
      bathroom: data['bathroom'] as num?,
    );
  }

  Map<String, dynamic> toMap() => {
        'bedroom': bedroom,
        'bathroom': bathroom,
      };

  //TODO: Add copyWith for mutable states

}

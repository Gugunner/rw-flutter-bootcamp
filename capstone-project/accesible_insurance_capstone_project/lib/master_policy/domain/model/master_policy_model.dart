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
    this.name,
    required this.currentSI,
    this.status = PolicyStatus.pending,
    required this.type,
    this.location,
    this.roomDescription,
  });

  final String policyId;
  final String? name;
  final num currentSI;
  final PolicyStatus? status;
  final PolicyType type;
  final LocationModel? location;
  final RoomDescription? roomDescription;

  static PolicyType getType(String type) => PolicyType.values
      .firstWhere((v) => v.name == type, orElse: () => PolicyType.unknown);

  static PolicyStatus getStatus(String status) => PolicyStatus.values
      .firstWhere((v) => v.name == status, orElse: () => PolicyStatus.unknown);

  factory MasterPolicyModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return MasterPolicyModel(
      policyId: data?['policyId'] as String,
      name: data?['name'] as String?,
      currentSI: data?['currentSI'] as num,
      // ignore: unnecessary_cast
      status: getStatus(data?['status']) as PolicyStatus?,
      // ignore: unnecessary_cast
      type: getType(data?['type']) as PolicyType,
      location: data?['location'] != null
          ? LocationModel.fromMap(data!['location'])
          : null,
      roomDescription: data?['roomDescription'] != null
          ? RoomDescription.fromMap(data!['roomDescription'])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'policyId': policyId,
      'name': name,
      'currentSI': currentSI,
      'status': status?.name ?? PolicyStatus.pending.name,
      'type': type,
    };
  }

  //TODO: Add copyWith for mutable states

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

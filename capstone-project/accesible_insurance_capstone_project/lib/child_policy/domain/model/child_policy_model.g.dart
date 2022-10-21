// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildPolicyModel _$ChildPolicyModelFromJson(Map<String, dynamic> json) =>
    ChildPolicyModel(
      childPolicyId: json['childPolicyId'] as int,
      masterPolicyId: json['masterPolicyId'] as String,
      premiumPaid: (json['premiumPaid'] as num).toDouble(),
      sumInsured: (json['sumInsured'] as num).toDouble(),
      activeSinceDate: toDateTime(json['activeSinceDate'] as String),
      expirationDate: toDateTime(json['expirationDate'] as String),
    );

Map<String, dynamic> _$ChildPolicyModelToJson(ChildPolicyModel instance) =>
    <String, dynamic>{
      'childPolicyId': instance.childPolicyId,
      'masterPolicyId': instance.masterPolicyId,
      'premiumPaid': instance.premiumPaid,
      'sumInsured': instance.sumInsured,
      'activeSinceDate': toIsoString(instance.activeSinceDate),
      'expirationDate': toIsoString(instance.expirationDate),
    };

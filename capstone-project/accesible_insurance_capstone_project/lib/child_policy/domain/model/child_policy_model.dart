import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
part 'child_policy_model.g.dart';

@JsonSerializable()
class ChildPolicyModel extends Equatable {
  const ChildPolicyModel({
    required this.childPolicyId,
    required this.masterPolicyId,
    required this.premiumPaid,
    required this.sumInsured,
    required this.activeSinceDate,
    required this.expirationDate,
  });

  final int childPolicyId;
  final String masterPolicyId;
  final double premiumPaid;
  final double sumInsured;
  @JsonKey(
    fromJson: toDateTime,
    toJson: toIsoString,
  )
  final DateTime activeSinceDate;
  @JsonKey(
    fromJson: toDateTime,
    toJson: toIsoString,
  )
  final DateTime expirationDate;

  factory ChildPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$ChildPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChildPolicyModelToJson(this);

  @override
  List<Object?> get props => [
        childPolicyId,
        masterPolicyId,
        premiumPaid,
        sumInsured,
        activeSinceDate,
        expirationDate,
      ];

  ChildPolicyModel copyWith({
    int? childPolicyId,
    String? masterPolicyId,
    double? premiumPaid,
    double? sumInsured,
    DateTime? activeSinceDate,
    DateTime? expirationDate,
  }) =>
      ChildPolicyModel(
        childPolicyId: childPolicyId ?? this.childPolicyId,
        masterPolicyId: masterPolicyId ?? this.masterPolicyId,
        premiumPaid: premiumPaid ?? this.premiumPaid,
        sumInsured: sumInsured ?? this.sumInsured,
        activeSinceDate: activeSinceDate ?? this.activeSinceDate,
        expirationDate: expirationDate ?? this.expirationDate,
      );
}

DateTime toDateTime(String date) => DateTime.parse(date);

String toIsoString(DateTime date) => date.toIso8601String();

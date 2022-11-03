import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SumInsured extends ConsumerWidget {
  const SumInsured({
    Key? key,
    required this.masterPolicy,
  }) : super(key: key);

  final MasterPolicyModel masterPolicy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Sum Insured',
          style: TextStyle(
            fontSize: 9,
          ),
        ),
        SizedBox(
          height: context.height * 0.007,
        ),
        Text(
          '\$${masterPolicy.currentSI.toDouble().toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

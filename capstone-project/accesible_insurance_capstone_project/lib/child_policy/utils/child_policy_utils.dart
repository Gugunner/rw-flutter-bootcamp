import 'dart:math';

import 'package:accesible_insurance_capstone_project/child_policies/domain/provider/child_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Creates a new Child Policy based on the premium paid and the sum insured
//calculated
void onCreateNewChildPolicy(WidgetRef ref, String masterPolicyId) {
  //TODO: Move logic after loader for purchase
  //TODO: Change random Check to a real premium calculation
  final randomPremiumPaid =
      double.parse((Random().nextDouble() * 20.99 + 3.99).toStringAsFixed(2));
  //TODO: Change random Check to a real SI calculation
  final randomSumInsured =
      double.parse((randomPremiumPaid * 140).toStringAsFixed(2));
  final nowDate = DateTime.now();
  final nextDate = nowDate.add(const Duration(days: 365));
  final childPolicy = ChildPolicyModel(
    masterPolicyId: masterPolicyId,
    premiumPaid: randomPremiumPaid,
    sumInsured: randomSumInsured,
    activeSinceDate: DateTime.now(),
    expirationDate: DateTime(nextDate.year, nextDate.month, nextDate.day),
  );
  ref.read(
      childPoliciesProviderInstance.childPolicyInsertProvider(childPolicy));
}

//Shows a dialog to confirm the delete of a child policy
Future<bool> onDeleteChildPolicy(
  WidgetRef ref, {
  required BuildContext context,
  required ChildPolicyModel childPolicy,
}) async {
  final shouldDelete = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: Card(
          child: Container(
            height: context.height * 0.25,
            width: context.width * 0.5,
            padding: EdgeInsets.symmetric(
              vertical: context.height * 0.02,
              horizontal: context.width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: Move text to English copies
                Text(
                  'Do you really want to delete the child policy '
                  '${childPolicy.masterPolicyId}-${childPolicy.childPolicyId}',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      //TODO: Move text to English copies
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      //TODO: Move text to English copies
                      child: const Text('Delete'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  //Only calls the provider to delete the child policy if the
  //dialog if the user confirms and there is an id.
  if (shouldDelete && childPolicy.childPolicyId != null) {
    ref.read(childPoliciesProviderInstance
        .childPolicyDeleteProvider(childPolicy.childPolicyId!));
  }
  return shouldDelete;
}

//Shows a dialog to confirm the update of a child policy
Future<void> onUpdate(
  WidgetRef ref, {
  required BuildContext context,
  required ChildPolicyModel childPolicy,
}) async {
  final newPremiumPaid = childPolicy.premiumPaid + 1.00;
  final newSumInsured = double.parse((newPremiumPaid * 140).toStringAsFixed(2));
  final shouldUpdate = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Center(
        child: Card(
          child: Container(
            height: context.height * 0.25,
            width: context.width * 0.5,
            padding: EdgeInsets.symmetric(
              vertical: context.height * 0.02,
              horizontal: context.width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Apply this changes to the child policy '
                  '${childPolicy.masterPolicyId}-${childPolicy.childPolicyId}?',
                  textAlign: TextAlign.center,
                ),
                //TODO: Move text to English copies
                Text('New premium: \$$newPremiumPaid'),
                Text('New SI: \$$newSumInsured'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      //TODO: Move text to English copies
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      //TODO: Move text to English copies
                      child: const Text('Update'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  //Only calls the provider to update the child policy if the
  //user confirms
  if (shouldUpdate) {
    ref.read(
      childPoliciesProviderInstance.childPolicyUpdateProvider(
        childPolicy.copyWith(
          premiumPaid: newPremiumPaid,
          sumInsured: newSumInsured,
        ),
      ),
    );
  }
}

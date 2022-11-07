import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/child_policy/utils/child_policy_utils.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Contains all the information of the ChildPolicyCard show
//inside a ListView
class ChildPolicyCard extends ConsumerWidget {
  const ChildPolicyCard({
    super.key,
    required this.childPolicy,
    required this.masterPolicy,
  });

  final ChildPolicyModel childPolicy;
  final MasterPolicyModel masterPolicy;

  String get masterPolicyId => childPolicy.masterPolicyId;

  int get id => childPolicy.childPolicyId ?? -99;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //The id shown to the user composed of the parent and child ids
    final displayId = '${childPolicy.masterPolicyId}-'
        '${childPolicy.childPolicyId}';
    //TODO: Add check if expiration date is before now date
    final isActive = childPolicy.activeSinceDate != null;
    return Card(
      child: Stack(
        children: [
          Container(
            width: context.width,
            height: context.height * 0.18,
            decoration: BoxDecoration(
              color: Colors.white38,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          //An icon to distinguished each child policy
          Positioned(
            top: context.height * 0.055,
            left: context.width * 0.02,
            child: Icon(
              Icons.policy,
              color: Theme.of(context).primaryColor,
              size: context.height * 0.03,
            ),
          ),
          Positioned(
            top: context.height * 0.05,
            left: context.width * 0.08,
            child: Text(
              displayId,
            ),
          ),
          Positioned(
            top: context.height * 0.075,
            left: context.width * 0.08,
            //TODO: Move text to English copies
            child: Text(
              '${isActive ? 'Active' : 'Inactive'}',
              //TODO: Change style to read from Theme
              style: TextStyle(
                //TODO: Move color to AppColors and call from Theme.of
                color: isActive ? Colors.green : Colors.red,
              ),
            ),
          ),
          //Shows the premium paid for the child policy
          Positioned(
            top: context.height * 0.1,
            left: context.width * 0.08,
            //TODO: Move text to English copies
            child: Text(
              'Premium: \$${childPolicy.premiumPaid}',
            ),
          ),
          //Show the sum insured added by this child policy
          Positioned(
            top: context.height * 0.12,
            left: context.width * 0.08,
            //TODO: Move text to English copies
            child: Text(
              'SI: \$${childPolicy.sumInsured}',
            ),
          ),
          //A trash icon to show the user how to delete the child policy
          Positioned(
            top: context.height * 0.00,
            right: context.width * 0.02,
            child: IconButton(
              onPressed: () => childPolicy.childPolicyId != null
                  ? onDeleteChildPolicy(
                      ref,
                      context: context,
                      childPolicy: childPolicy,
                      masterPolicy: masterPolicy,
                    )
                  : null,
              iconSize: context.height * 0.03,
              icon: const Icon(
                Icons.delete_forever,
                //TODO: Move color to AppColors and call from Theme.of
                color: Color(0xffdb5858),
              ),
            ),
          ),
          //Show the user how to update the policy premium
          Positioned(
            top: context.height * 0.00,
            right: context.width * 0.08,
            child: IconButton(
              onPressed: () => onUpdate(
                ref,
                context: context,
                childPolicy: childPolicy,
                masterPolicy: masterPolicy,
              ),
              iconSize: context.height * 0.03,
              icon: const Icon(
                Icons.currency_exchange,
                //TODO: Move color to AppColors and call from Theme.of
                color: Colors.green,
              ),
            ),
          ),
          //The active since date
          Positioned(
            bottom: context.height * 0.01,
            right: context.width * 0.01,
            child: Text(
              //TODO: Change DateFormat and style
              //TODO: Move text to English copies
              'Active since: '
              '${childPolicy.activeSinceDate ?? '-'}',
            ),
          )
        ],
      ),
    );
  }
}

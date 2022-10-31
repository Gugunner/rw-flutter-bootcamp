import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/child_policy/ui/widgets/child_policy_card.dart';
import 'package:accesible_insurance_capstone_project/child_policy/utils/child_policy_utils.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Wraps a ChildPolicyCard in a dismissable widget
class DismissableChildPolicy extends ConsumerWidget {
  const DismissableChildPolicy({
    super.key,
    required this.childPolicy,
  });

  final ChildPolicyModel childPolicy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayId = '${childPolicy.masterPolicyId}-'
        '${childPolicy.childPolicyId}';
    //TODO: Add check if expiration date is before now date
    final isActive = childPolicy.activeSinceDate != null;
    return Dismissible(
      key: ValueKey(displayId),
      confirmDismiss: ((direction) async => childPolicy.childPolicyId != null
          ? onDeleteChildPolicy(ref, context: context, childPolicy: childPolicy)
          : Future.value(
              false,
            )),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.all(context.width * 0.02),
        decoration: const BoxDecoration(
          //TODO: Move color to AppColors and call from Theme.of
          color: Color(0xffdb5858),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_sweep_rounded,
            color: Colors.white,
            size: context.height * 0.035,
          ),
        ),
      ),
      child: ChildPolicyCard(childPolicy: childPolicy),
    );
  }
}



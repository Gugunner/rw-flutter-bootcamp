import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterPolicyScreen extends ConsumerWidget {
  const MasterPolicyScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterPolicy = ref
        .watch(MasterPoliciesProvider.instance.selectedMasterPolicy.state)
        .state;
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: 'master-policy $index',
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: masterPolicy != null
              ? MasterPolicyCard(
                  masterPolicy: masterPolicy,
                  isScreen: true,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

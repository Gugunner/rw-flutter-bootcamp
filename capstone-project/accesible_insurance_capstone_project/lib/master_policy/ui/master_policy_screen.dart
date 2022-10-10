import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterPolicyScreen extends ConsumerWidget {
  const MasterPolicyScreen({
    Key? key,
    required this.index,
    required this.masterPolicy,
  }) : super(key: key);

  final int index;
  final MasterPolicyModel masterPolicy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Hero(
          tag: 'master-policy $index',
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: MasterPolicyCard(masterPolicy: masterPolicy, isScreen: true),
          ),
        ),
      ),
    );
  }
}

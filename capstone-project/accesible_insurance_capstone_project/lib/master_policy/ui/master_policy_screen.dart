import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_card.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterPolicyScreen extends ConsumerWidget {
  const MasterPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: const MasterPolicyCard(isScreen: true),
        ),
      ),
    );
  }
}

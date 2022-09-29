import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.red,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(
          //       context,
          //       PageRouteBuilder(
          //         transitionDuration: const Duration(milliseconds: 800),
          //         pageBuilder: (context, animation1, animation2) {
          //           return const MasterPolicyListScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
          ),
      body: SafeArea(
        child: Hero(
          tag: 'master-policy $index',
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: const MasterPolicyCard(isScreen: true),
          ),
        ),
      ),
    );
  }
}

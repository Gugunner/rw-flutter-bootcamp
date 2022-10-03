import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class MasterPolicyStatus extends StatelessWidget {
  const MasterPolicyStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  final PolicyStatus status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.162,
      child: Row(
        children: [
          Container(
            width: context.width * 0.025,
            height: context.height * 0.014,
            decoration: const BoxDecoration(
              //TODO: Change color according to status
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              status.name.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}

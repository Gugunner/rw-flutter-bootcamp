import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/animated_child_policy_zone.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/expiration_days.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/insurance_main_information.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/insurance_type.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/master_policy_status.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/widgets/sum_insured.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterPolicyCard extends StatelessWidget {
  const MasterPolicyCard({
    Key? key,
    required this.masterPolicy,
    this.isScreen = false,
  }) : super(key: key);

  final bool isScreen;
  final MasterPolicyModel masterPolicy;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Stack(
        children: [
          Container(
            width: context.width,
            //Implementation to scale card when used as part of the screen
            height: context.height * (!isScreen ? 0.267 : 1),
            decoration: decoration,
          ),
          Positioned(
            top: context.height * 0.028,
            right: context.width * 0.025,
            child: MasterPolicyStatus(
              status: masterPolicy.status!,
            ),
          ),
          Container(
            width: context.width,
            height: isScreen ? context.height : context.height * 0.267,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: context.height * 0.183,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          context.width * 0.05,
                          context.height * 0.028,
                          0,
                          0,
                        ),
                        width: context.width * 0.187,
                        height: context.height * 0.161,
                        padding: EdgeInsets.zero,
                        child: InsuranceType(
                          type: masterPolicy.type,
                        ),
                      ),
                      const InsuranceMainInformation(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    context.width * 0.05,
                    0,
                    context.width * 0.05,
                    context.width * 0.025,
                  ),
                  width: context.width,
                  child: SumInsured(
                    currentSI: masterPolicy.currentSI,
                  ),
                ),
              ],
            ),
          ),
          if (isScreen) ...[
            AnimatedChildPolicyZone(
              index: masterPolicy.index,
            ),
            Positioned(
              right: context.width * 0.025,
              bottom: context.height * 0.028,
              child: ExpirationDays(
                isScreen: isScreen,
              ),
            )
          ],
        ],
      ),
    );
  }
}

extension MasterPolicyCardDecoration on MasterPolicyCard {
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: Colors.transparent));
}



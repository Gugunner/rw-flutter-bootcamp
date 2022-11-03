import 'package:accesible_insurance_capstone_project/child_policies/domain/provider/child_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/child_policy/ui/widgets/dimissable_child_policy.dart';
import 'package:accesible_insurance_capstone_project/child_policy/utils/child_policy_utils.dart';
import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChildPoliciesZone extends ConsumerStatefulWidget {
  const ChildPoliciesZone({
    super.key,
    required this.masterPolicy,
  });

  final MasterPolicyModel masterPolicy;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChildPoliciesZoneState();
}

class _ChildPoliciesZoneState extends ConsumerState<ChildPoliciesZone> {
  double totalSumInsured = 0;

  @override
  void initState() {
    totalSumInsured = masterPolicy.currentSI.toDouble();
    super.initState();
  }

  MasterPolicyModel get masterPolicy => widget.masterPolicy;

  @override
  Widget build(BuildContext context) {
    final childPolicies = ref.watch(childPoliciesProviderInstance
        .childPoliciesSelectStreamer(masterPolicy.policyId));

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        context.width * 0.025,
        context.height * 0.025,
        context.width * 0.025,
        0,
      ),
      child: childPolicies.when(
        data: (childPolicies) {
          var masterPolicySI = 0.00;
          var premiumPolicy = 0.00;
          if (childPolicies.isNotEmpty) {
            masterPolicySI = childPolicies
                .map((chp) => chp.sumInsured)
                .reduce((current, next) => current + next);
            premiumPolicy = childPolicies
                .map((chp) => chp.premiumPaid)
                .reduce((current, next) => current + next);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Move text to English copies
              const Text('Child Policies'),
              Text('Current Master Policy SI: '
                  '\$${masterPolicySI.toStringAsFixed(2)}'),
              Text('Current Master Policy Premium: '
                  '\$${premiumPolicy.toStringAsFixed(2)}'),
              SizedBox(
                height: context.height * 0.025,
              ),
              //If the user has no child policies the the user is alerted
              if (childPolicies.isEmpty) ...[
                Center(
                  child: SizedBox(
                    width: context.width,
                    child: const Text(
                      //TODO: Move text to English copies
                      'You have no child policies',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                //If the user has child policies they are shown
                //as well as a simple select to choose minimum premium paid
                //child policies limit
              ] else if (childPolicies.isNotEmpty) ...[
                SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.width * 0.02,
                      ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          width: context.width * 0.28,
                          child: DropdownButtonFormField<double>(
                            icon: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: 2.0,
                              child: Icon(
                                Icons.monetization_on,
                                size: context.width * 0.03,
                                //TODO: Move color to AppColors and call from
                                // Theme.of
                                color: Colors.green,
                              ),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                    .read(childPoliciesProviderInstance
                                        .minimumPremiumPaid.notifier)
                                    .state = value;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: context.height * 0.02,
                                left: 0,
                              ),
                              helperMaxLines: 2,
                              //TODO: Move text to English copies
                              helperText: 'Choose a minimum premium',
                            ),
                            items: obtainItems(childPolicies),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height * 0.025,
                ),
                SizedBox(
                  height: context.height * 0.48,
                  child: ListView.builder(
                    itemBuilder: (listViewContext, index) {
                      final childPolicy = childPolicies[index];
                      return DismissableChildPolicy(
                        childPolicy: childPolicy,
                        masterPolicy: masterPolicy,
                      );
                    },
                    itemCount: childPolicies.length,
                  ),
                )
              ],
              //The user can create a new child policy by clicking
              //the following button
              Center(
                child: SizedBox(
                  width: context.width,
                  height: context.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      onCreateNewChildPolicy(ref, masterPolicy, masterPolicySI);
                    },
                    child: Text(
                      //TODO: Move text to English copies
                      'Acquire new child policy',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          //TODO: Move color to AppColors and call from Theme.of
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: ((error, stackTrace) {
          return const Center(
            //TODO: Move text to English copies
            child: Text('No child policies found'),
          );
        }),
        loading: () => const Center(
          child: SizedBox(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

//An extension to keep a cleaner code and logic for the drop down items
extension _ChildPoliciesZoneDropdownMenuItem on _ChildPoliciesZoneState {
  //TODO: Read all values of child policies from ref
  // not only the ones on the widget
  List<DropdownMenuItem<double>> obtainItems(
      List<ChildPolicyModel> childPolicies) {
    final premiumsPaid = childPolicies
        .map((chp) => chp.premiumPaid.floorToDouble())
        .toSet()
        .toList();
    premiumsPaid.insert(0, 0.0);
    return premiumsPaid.map((p) {
      final text = p == 0 ? 'none' : '\$$p';
      return DropdownMenuItem<double>(value: p, child: Text(text));
    }).toList();
  }
}

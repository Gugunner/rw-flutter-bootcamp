import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/shimmer/loading_shader_shimmer.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsuranceMainInformation extends StatelessWidget {
  const InsuranceMainInformation({
    Key? key,
    required this.masterPolicy,
  }) : super(key: key);

  final MasterPolicyModel masterPolicy;

  String get location {
    final location = masterPolicy.location;
    if (location != null) {
      return 'Location: ${location.city}, ${location.state}, '
          '${location.country}';
    }
    return '';
  }

  String get roomDescription {
    final roomDescription = masterPolicy.roomDescription;
    if (roomDescription != null) {
      return 'Rooms: ${roomDescription.bedroom} bedrooms, '
          '${roomDescription.bathroom} bathrooms';
    }
    return '';
  }

  String get beneficiaryName {
    final beneficiary = masterPolicy.beneficiary;
    if (beneficiary != null) {
      return 'Name: ${beneficiary.name} ${beneficiary.lastName}';
    }
    return '';
  }

  String get beneficiaryAge {
    final beneficiary = masterPolicy.beneficiary;
    if (beneficiary != null) {
      return 'Age: ${beneficiary.age}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(context.width * 0.037, 0, 0, 0),
          width: context.width * 0.525,
          height: context.height * 0.063,
          padding: EdgeInsets.zero,
          child: EditablePolicyName(
            masterPolicy: masterPolicy,
          ),
        ),
        Container(
          width: context.width * 0.525,
          margin: EdgeInsets.fromLTRB(context.width * 0.037, 0, 0, 0),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (masterPolicy.type == PolicyType.property) ...[
                Text(
                  'SECURITY',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: context.height * 0.011,
                ),
                Text(
                  location,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  roomDescription,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ] else ...[
                Text(
                  'BENEFICIARY',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: context.height * 0.011,
                ),
                Text(
                  beneficiaryName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  beneficiaryAge,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
              SizedBox(
                height: context.height * 0.011,
              ),
              Text(
                'INSURED',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: context.height * 0.005,
              ),
              Text(
                'In: ${masterPolicy.insured.identificationNumber}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Name: ${masterPolicy.insured.name} '
                '${masterPolicy.insured.lastName}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class EditablePolicyName extends ConsumerStatefulWidget {
  const EditablePolicyName({
    super.key,
    required this.masterPolicy,
  });

  final MasterPolicyModel masterPolicy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditablePolicyNameState();
}

class _EditablePolicyNameState extends ConsumerState<EditablePolicyName> {
  bool isEditing = false;
  bool isUpdating = false;
  String newName = '';

  void _onUpdatingName() {
    ref.read(
      masterPoliciesProviderInstance.updateMasterPolicyProvider(
        widget.masterPolicy.copyWith(
          name: newName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //TODO: Add shimmer to loader
        LoadingShaderShimmer(
          isLoading: isUpdating,
          child: Container(
            margin: EdgeInsets.only(
              top: context.height * 0.028,
            ),
            width: context.width * 0.454,
            height: context.height,
            child: Row(
              children: [
                if (isEditing)
                  Expanded(
                      child: TextFormField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        newName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: widget.masterPolicy.name,
                    ),
                  ))
                else
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.masterPolicy.name ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.2),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.009,
          right: -context.width * 0.019,
          child: IconButton(
            onPressed: () {
              setState(() {
                //TODO: Add regex for naming convention
                if (isEditing && newName.isNotEmpty && !isUpdating) {
                  // isUpdating = true;
                  _onUpdatingName();
                }
                isEditing = !isEditing;
              });
            },
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
            iconSize: context.height * 0.028,
          ),
        ),
      ],
    );
  }
}

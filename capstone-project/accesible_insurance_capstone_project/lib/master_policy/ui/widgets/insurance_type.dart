import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProvider = AppProvider.instance;

class InsuranceType extends ConsumerWidget {
  const InsuranceType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final PolicyType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(appProvider.themeProvider.state).state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              type == PolicyType.property ? property : life,
              width: context.height * 0.09,
              height: context.height * 0.09,
              color: Theme.of(context).primaryColor.withOpacity(
                    0.3,
                  ),
              colorBlendMode: BlendMode.srcATop,
              errorBuilder: (context, obj, stackTrace) => SizedBox(
                child: Placeholder(
                  color: themeState == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: context.width * 0.187,
          height: context.height * 0.028,
          margin: EdgeInsets.only(top: context.height * 0.014),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Colors.grey),
            color:
                type == PolicyType.property ? Colors.green : Colors.pinkAccent,
          ),
          child: Center(
            child: Text(
              type.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

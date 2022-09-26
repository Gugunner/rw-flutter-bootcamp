import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appProvider = AppProvider.instance;

class InsuranceType extends ConsumerWidget {
  const InsuranceType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(appProvider.themeProvider.state).state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: context.height * 0.09,
          height: context.height * 0.09,
          child: Placeholder(
            color: themeState == ThemeMode.dark ? Colors.white : Colors.black,
          ),
        ),
        Container(
          width: context.width * 0.187,
          height: context.height * 0.028,
          margin: EdgeInsets.only(top: context.height * 0.014),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey)),
          child: Center(
            child: Text(
              'Property',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        )
      ],
    );
  }
}

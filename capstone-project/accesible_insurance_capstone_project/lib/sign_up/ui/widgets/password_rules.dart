import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/universal_constants.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class PasswordRules extends ConsumerWidget {
  const PasswordRules({
    super.key,
    this.check = false,
    this.password,
  });

  final bool check;
  final String? password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.width * 0.863,
      height: context.height * 0.217,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('How to create your password?'),
            ],
          ),
          SizedBox(
            height: context.height * 0.023,
          ),
          for (var index = 0;
              index < UniversalConstants.passwordRules.length;
              index++)
            PasswordRule(
              rule: UniversalConstants.passwordRules[index],
              regexp: Regex.passwordRegexRules[index],
              password: password,
              check: check,
            ),
        ],
      ),
    );
  }
}

class PasswordRule extends ConsumerWidget {
  const PasswordRule({
    super.key,
    required this.regexp,
    this.rule = 'There is no rule',
    this.check = false,
    this.password,
  });

  final String rule;
  final String regexp;
  final bool check;
  final String? password;

  Color? checkColor(
    BuildContext context, {
    required String regexp,
  }) {
    if (password == null || password!.isEmpty) {
      return Colors.black;
    }
    if (check) {
      return RegExp(regexp).hasMatch(password ?? '')
          ? AppColors.correctColor
          : Theme.of(context).errorColor;
    }
    return RegExp(regexp).hasMatch(password ?? '')
        ? AppColors.correctColor
        : Colors.black;
  }

  IconData get checkIcon {
    if (password == null || password!.isEmpty) {
      return Icons.circle_outlined;
    }
    return RegExp(regexp).hasMatch(password ?? '') ? Icons.check : Icons.close;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = checkColor(
      context,
      regexp: regexp,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rule,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
              ),
        ),
        Icon(
          checkIcon,
          color: color,
        )
      ],
    );
  }
}


import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputProviderInstance = InputProvider.instance;

class PasswordInput extends ConsumerWidget {
  const PasswordInput({
    Key? key,
    this.onSaved,
    this.enabled,
  }) : super(key: key);

  final Function(String?)? onSaved;
  final bool? enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordNotifier =
        ref.watch(inputProviderInstance.passwordProvider.notifier);
    return Container(
      width: context.width * 0.625,
      margin: EdgeInsets.only(top: context.height * 0.028),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: context.height * 0.021),
            child: TextFormField(
              enabled: enabled,
              decoration: decoration(context, ref),
              onChanged: (String? value) {
                passwordNotifier.state = value;
              },
              onSaved: onSaved,
              obscureText: ref
                  .watch(inputProviderInstance.showPasswordProvider.state)
                  .state,
            ),
          ),
          Positioned(
            top: 0,
            child: Text(
              'Password',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: obtainStatusColor(context, ref),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Decoration for the [PasswordInput]
extension _PasswordInputDecoration on PasswordInput {
  Color obtainStatusColor(BuildContext context, WidgetRef ref) =>
      ref.watch(inputProviderInstance.passwordStateProvider.state).state !=
              InputErrorState.idle
          ? Theme.of(context).errorColor
          : Theme.of(context).textTheme.bodyText1!.color!;

  InputDecoration decoration(BuildContext context, WidgetRef ref) {
    final showPassword =
        ref.watch(inputProviderInstance.showPasswordProvider.state).state;
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      hintText: "password",
      border: OutlineInputBorder(
          borderSide: BorderSide(
        width: 1,
        color: obtainStatusColor(context, ref),
      )),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
        width: 1,
        color: obtainStatusColor(context, ref),
      )),
      prefix: const SizedBox(width: 15),
      errorText: ref
          .watch(inputProviderInstance.passwordStateProvider.state)
          .state
          .errorText,
      suffixIcon: GestureDetector(
          onTap: () {
            ref.read(inputProviderInstance.showPasswordProvider.state).state =
                !showPassword;
            // showPasswordNotifier.state = showPasswordNotifier.state;
          },
          child: Icon(
            showPassword == true
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: obtainStatusColor(context, ref),
          )),
    );
  }
}

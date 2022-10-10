import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputProviderInstance = InputProvider.instance;

///An email input that can be used wherever the email is needed.
///The email value is handled by the [onChanged] property of the
///[TextFormField].
class EmailInput extends ConsumerWidget {
  const EmailInput({
    Key? key,
    this.onSaved,
    this.enabled,
  }) : super(key: key);

  //The state handler for the email [String]
  final Function(String?)? onSaved;
  final bool? enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailNotifier =
        ref.watch(inputProviderInstance.emailProvider.notifier);
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.028),
      width: context.width * 0.625,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: context.height * 0.021),
            child: TextFormField(
              enabled: enabled,
              textAlignVertical: TextAlignVertical.center,
              decoration: decoration(context, ref),
              onChanged: (String? value) {
                emailNotifier.state = value;
              },
              onSaved: onSaved,
            ),
          ),
          Positioned(
            top: 0,
            child: Text(
              'Email',
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

///Decoration for the [EmailInput]
extension _EmailInputDecoration on EmailInput {
  Color obtainStatusColor(BuildContext context, WidgetRef ref) =>
      ref.watch(inputProviderInstance.emailStateProvider.state).state !=
              InputErrorState.idle
          ? Theme.of(context).errorColor
          : Theme.of(context).textTheme.bodyText1!.color!;

  InputDecoration decoration(BuildContext context, WidgetRef ref) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: 'email address',
        hintStyle: const TextStyle(),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: Colors.grey,
        )),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: obtainStatusColor(context, ref),
        )),
        errorText: ref
            .watch(inputProviderInstance.emailStateProvider.state)
            .state
            .errorText,
        prefixIcon: Icon(
          Icons.email_outlined,
          color: obtainStatusColor(context, ref),
        ),
      );
}

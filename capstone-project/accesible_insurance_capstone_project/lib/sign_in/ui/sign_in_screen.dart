import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/email_input.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/password_input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/model/user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/logo.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/universal_constants.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/regex.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInFormKey = GlobalKey<FormState>();

final inputProviderInstance = InputProvider.instance;

final appProviderInstance = AppProvider.instance;

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  void onSignIn({
    required WidgetRef ref,
  }) async {
    final emailInputState =
        ref.read(inputProviderInstance.emailStateProvider.state).state;
    final passwordInputState =
        ref.read(inputProviderInstance.passwordStateProvider.state).state;
    final email = ref.read(inputProviderInstance.emailProvider.state).state;
    final password =
        ref.read(inputProviderInstance.passwordProvider.state).state;
    ref.read(inputProviderInstance.submitProvider.state).state = true;
    if (signInFormKey.currentState != null) {
      signInFormKey.currentState!.save();
      if (passwordInputState == InputErrorState.idle &&
          emailInputState == InputErrorState.idle) {
        if (signInFormKey.currentState!.validate()) {
          ref.watch(appProviderInstance
              .signInProvider(UserModel(password: password!, email: email!)));
          ref.read(inputProviderInstance.submitProvider.state).state = false;
        }
      }
    }
  }

  void checkForm(InputType type, WidgetRef ref) {
    final email = ref.read(inputProviderInstance.emailProvider.state).state;
    final password =
        ref.read(inputProviderInstance.passwordProvider.state).state;
    InputErrorState state = InputErrorState.idle;
    if (type == InputType.password) {
      if (password!.isEmpty) {
        state = InputErrorState.emptyPassword;
      } else if (!RegExp(Regex.password).hasMatch(password!)) {
        state = InputErrorState.invalidPassword;
      } else if (password!.length < UniversalConstants.passwordLength) {
        state = InputErrorState.passwordLength;
      }
      ref.watch(inputProviderInstance.passwordStateProvider.state).state =
          state;
    } else if (type == InputType.email) {
      if (email!.isEmpty) {
        state = InputErrorState.emptyEmail;
      } else if (email!.isNotNullOrEmpty) {
        if (!RegExp(Regex.email).hasMatch(email!)) {
          state = InputErrorState.invalidEmail;
        }
      }
      ref.watch(inputProviderInstance.emailStateProvider.state).state = state;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submit = ref.watch(inputProviderInstance.submitProvider.state).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Form(
            key: signInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(),
                EmailInput(
                  enabled: !submit,
                  onSaved: (_) => checkForm(InputType.email, ref),
                ),
                PasswordInput(
                  enabled: !submit,
                  onSaved: (_) => checkForm(InputType.password, ref),
                ),
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.028),
                  child: TextButton(
                    onPressed: () {
                      debugPrint('Forgot Password');
                    },
                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ),
                Container(
                  width: context.width * 0.5625,
                  height: context.height * 0.07,
                  margin: EdgeInsets.only(top: context.height * 0.028),
                  child: ElevatedButton(
                    onPressed: !submit ? () => onSignIn(ref: ref) : null,
                    child: const Text(
                      'SIGN IN',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.028),
                  child: TextButton(
                    onPressed: () {
                      //TODO: Implement real logic
                      debugPrint('Join now');
                    },
                    child: const Text(
                      'Don\'t have an account?\n Join now.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

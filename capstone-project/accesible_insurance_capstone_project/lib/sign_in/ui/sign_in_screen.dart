import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/email_input.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/password_input.dart';
import 'package:accesible_insurance_capstone_project/sign_in/utils/constants/widget_keys.dart';
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

  //Calls everything needed to sign the user in
  void onSignIn({
    required WidgetRef ref,
  }) async {
    //Checks if the Form widget attached to this key is in the tree
    if (signInFormKey.currentState != null) {
      //Calls any onSave method of a FormField
      signInFormKey.currentState!.save();
      //Retrieves curren InpurErrorState for the email input
      final emailInputState =
          ref.read(inputProviderInstance.emailStateProvider.state).state;
      //Retrieves curren InpurErrorState for the password input
      final passwordInputState =
          ref.read(inputProviderInstance.passwordStateProvider.state).state;
      //Retrieves current email value for the email input
      final email = ref.read(inputProviderInstance.emailProvider.state).state;
      //Retrieves current password value for the password input
      final password =
          ref.read(inputProviderInstance.passwordProvider.state).state;
      ///Disables working inputs to avoid the user from making any other 
      ///interaction with the submit flag
      ref.read(inputProviderInstance.submitProvider.state).state = true;
      ///Checks if there is no input validation error and the form can 
      ///be validated
      if (passwordInputState == InputErrorState.idle &&
          emailInputState == InputErrorState.idle) {
        if (signInFormKey.currentState!.validate()) {
          //Calls the signInProvider with a family argument of UserModel
          ref.read(appProviderInstance
              .signInProvider(UserModel(password: password!, email: email!)));
        }
      }
    }
    ///Releases the inputs so the user can continue interacting with the screen,
    ///only works if the form could not be sent
    ref.read(inputProviderInstance.submitProvider.state).state = false;
  }

  void checkForm(InputType type, WidgetRef ref) {
    final email = ref.read(inputProviderInstance.emailProvider.state).state;
    final password =
        ref.read(inputProviderInstance.passwordProvider.state).state;
    var state = InputErrorState.idle;
    if (type == InputType.password) {
      if (password!.isEmpty) {
        state = InputErrorState.emptyPassword;
      } else if (!RegExp(Regex.password).hasMatch(password)) {
        state = InputErrorState.invalidPassword;
      } else if (password.length < UniversalConstants.passwordLength) {
        state = InputErrorState.passwordLength;
      }
      ref.read(inputProviderInstance.passwordStateProvider.notifier).state =
          state;
    } else if (type == InputType.email) {
      if (email!.isEmpty) {
        state = InputErrorState.emptyEmail;
      } else if (email.isNotNullOrEmpty) {
        if (!RegExp(Regex.email).hasMatch(email)) {
          state = InputErrorState.invalidEmail;
        }
      }
      ref.read(inputProviderInstance.emailStateProvider.notifier).state = state;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submit = ref.watch(inputProviderInstance.submitProvider.state).state;
    return Scaffold(
      key: SigninWidgetKeys.screenKey,
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
                //Sign in button
                Container(
                  width: context.width * 0.5625,
                  height: context.height * 0.07,
                  margin: EdgeInsets.only(top: context.height * 0.028),
                  child: ElevatedButton(
                    key: SigninWidgetKeys.signinButtonKey,
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

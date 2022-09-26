import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/email_input.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/password_input.dart';
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

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  void onSignIn() {
    if (signInFormKey.currentState != null) {
      signInFormKey.currentState!.save();
      final passwordInputState =
          ref.read(inputProviderInstance.passwordStateProvider.state).state;
      final emaiInputState =
          ref.read(inputProviderInstance.emailStateProvider.state).state;
      if (passwordInputState == InputErrorState.idle &&
          emaiInputState == InputErrorState.idle) {
        if (signInFormKey.currentState!.validate()) {
          //TODO: Implement sign in
          signInFormKey.currentState!.reset();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const MasterPolicyListScreen();
          }));
        }
      }
    }
  }

  void checkForm(InputType type) {
    InputErrorState state = InputErrorState.idle;
    if (type == InputType.password) {
      final passwordState =
          ref.read(inputProviderInstance.passwordProvider.state).state;
      if (passwordState!.isEmpty) {
        state = InputErrorState.emptyPassword;
      } else if (!RegExp(Regex.password).hasMatch(passwordState)) {
        state = InputErrorState.invalidPassword;
      } else if (passwordState.length < UniversalConstants.passwordLength) {
        state = InputErrorState.passwordLength;
      }
      ref.watch(inputProviderInstance.passwordStateProvider.state).state =
          state;
    } else if (type == InputType.email) {
      final emailState =
          ref.read(inputProviderInstance.emailProvider.state).state;
      if (emailState!.isEmpty) {
        state = InputErrorState.emptyEmail;
      } else if (emailState.isNotNullOrEmpty) {
        if (!RegExp(Regex.email).hasMatch(emailState)) {
          state = InputErrorState.invalidEmail;
        }
      }
      ref.watch(inputProviderInstance.emailStateProvider.state).state = state;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onSaved: (_) => checkForm(InputType.email),
                ),
                PasswordInput(
                  onSaved: (_) => checkForm(InputType.password),
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
                    onPressed: onSignIn,
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

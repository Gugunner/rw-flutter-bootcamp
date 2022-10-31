import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/animated_sign_in_logo.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/email_input.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/widgets/password_input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/model/user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/auth_utils.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'widgets/password_rules.dart';

final checkRulesProvider = StateProvider((ref) => false);

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

final signUpFormKey = GlobalKey<FormState>();

final inputProviderInstance = InputProvider.instance;

final appProviderInstance = AppProvider.instance;

class _SignUpScreenState extends ConsumerState<SignUpScreen> {

  void onSignUp({
    required WidgetRef ref,
  }) async {
    //Checks if the Form widget attached to this key is in the tree
    if (signUpFormKey.currentState != null) {
      //Calls any onSave method of a FormField
      signUpFormKey.currentState!.save();
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

      ref.read(checkRulesProvider.notifier).state = true;

      ///Checks if there is no input validation error and the form can
      ///be validated
      if (passwordInputState == InputErrorState.idle &&
          emailInputState == InputErrorState.idle) {
        if (signUpFormKey.currentState!.validate()) {
          //Calls the signInProvider with a family argument of UserModel
          ref.read(
            appProviderInstance.signUpProvider(
              UserModel(
                password: password!,
                email: email!,
              ),
            ),
          );
        }
      }
    }

    ///Releases the inputs so the user can continue interacting with the screen,
    ///only works if the form could not be sent
    ref.read(inputProviderInstance.submitProvider.state).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final submit = ref.watch(InputProvider.instance.submitProvider.state).state;
    final signIn = ref.watch(AppProvider.instance.signIn.state).state;
    final password =
        ref.watch(InputProvider.instance.passwordProvider.state).state;
    final check = ref.watch(checkRulesProvider.state).state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
              Container(
                width: context.width,
                height: context.height,
                padding: EdgeInsets.fromLTRB(
                  context.width * 0.068,
                  context.height * 0.116,
                  context.width * 0.068,
                  context.height * 0.025,
                ),
                child: Form(
                  key: signUpFormKey,
                  child: Column(
                    children: [
                      if (!signIn)
                      ...[Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Create your account now and start mixing '
                              'insurance with lifestyle'),
                        ],
                      ),
                      SizedBox(
                        height: context.height * 0.046,
                      ),
                      PasswordRules(
                        check: check,
                        password: password,
                      ),
                      EmailInput(
                        enabled: !submit,
                        onSaved: (_) => checkForm(
                          InputType.email,
                          ref,
                        ),
                      ),
                      PasswordInput(
                        enabled: !submit,
                        onSaved: (_) => checkForm(
                          InputType.password,
                          ref,
                        ),
                      ),
                      Container(
                        width: context.width * 0.5625,
                        height: context.height * 0.07,
                        margin: EdgeInsets.only(top: context.height * 0.098),
                        child: ElevatedButton(
                          onPressed: !submit ? () => onSignUp(ref: ref) : null,
                          child: Text(
                            EnglishCopies.signup.toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: context.height * 0.028),
                          child: TextButton(
                            onPressed: () {
                              cleanInputProviders(ref);
                              final route = AppRoutes.signin.route;
                              context.go(route);
                              ref.read(routeProvider.notifier).state = route;
                            },
                            child: const Text(
                              EnglishCopies.haveAccount,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )],
                    ],
                  ),
                ),
              ),
            if (signIn) const AnimatedSignInLogo(),
          ],
        ),
      ),
    );
  }
}

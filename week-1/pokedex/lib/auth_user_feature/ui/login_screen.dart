import 'package:flutter/material.dart';
import 'package:pokedex/auth_user_feature/ui/widgets/email_input.dart';
import 'package:pokedex/auth_user_feature/ui/widgets/login_button.dart';
import 'package:pokedex/auth_user_feature/ui/widgets/password_input.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
    required this.login,
  }) : super(key: key);

  final VoidCallback login;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = false;
  final _formKey = GlobalKey<FormState>();
  bool submit = false;

  void _visibility() {
    setState(() {
      visible = !visible;
    });
  }

  void _login() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        widget.login();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: screenWidth * 0.5875,
                  height: screenHeight * 0.1444,
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.1056,
                    left: screenWidth * 0.0937,
                    right: screenWidth * 0.0937,
                  ),
                  child: Image.asset(
                    'assets/pokemon_logo.png',
                    width: screenWidth * 0.5875,
                    height: screenHeight * 0.1444,
                  )),
              Container(
                height: screenHeight * 0.3353,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.0669,
                  left: screenWidth * 0.03975,
                  right: screenWidth * 0.03975,
                ),
                padding: EdgeInsets.all(screenWidth * 0.0781),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const EmailInput(),
                    PasswordInput(
                      visible: visible,
                      visibility: _visibility,
                    )
                  ],
                ),
              ),
              LoginButton(login: _login),
              const RegisterTextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterTextButton extends StatelessWidget {
  const RegisterTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.044),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'I want to be a trainer!\n',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Register here',
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                    onEnter: (event) {
                      debugPrint('enter');
                    })
              ])),
    );
  }
}

import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.login,
  }) : super(key: key);

  final VoidCallback? login;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.2875,
      margin: EdgeInsets.only(top: screenHeight * 0.0352),
      child: ElevatedButton(
          onPressed: login,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.orange;
                }
                return Colors.orange;
              }),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(screenWidth * 0.015))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(
                child: Text(
                  'Train On!',
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(
                Icons.catching_pokemon_outlined,
                size: screenWidth * 0.0625,
              )
            ],
          )),
    );
  }
}
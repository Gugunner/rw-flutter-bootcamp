import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    this.visible = false,
    this.visibility,
    this.submit = false,
  }) : super(key: key);

  final bool visible;
  final VoidCallback? visibility;
  final bool submit;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final visibleIcon =
        visible ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    return SizedBox(
      height: screenHeight * 0.1016,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a valid password';
                  }
                  //TODO: Add password rules
                  return null;
                },
                obscureText: !visible,
                keyboardType: TextInputType.visiblePassword,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.0246,
                ),
                cursorColor: Colors.orange,
                scrollPadding: const EdgeInsets.all(0),
                decoration: InputDecoration(
                    hintText: 'Your password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: screenWidth * 0.0625,
                      color: Colors.orange,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: visibility,
                      child: Icon(
                        visibleIcon,
                        size: screenWidth * 0.0625,
                        color: Colors.orange,
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.0, color: Colors.orange)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0, color: Colors.orange.withOpacity(0.6))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.0, color: Colors.orange)),
                    contentPadding: const EdgeInsets.all(0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

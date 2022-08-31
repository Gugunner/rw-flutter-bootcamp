import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    this.submit = false,
  }) : super(key: key);

  final bool submit;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.1016,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a valid email';
                  }
                  //TODO: Add email regex
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.0246,
                  color: Colors.black,
                ),
                cursorColor: Colors.orange,
                scrollPadding: const EdgeInsets.all(0),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Your email',
                    focusColor: Colors.orange.withOpacity(0.5),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: screenWidth * 0.0625,
                      color: Colors.orange,
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
          )
        ],
      ),
    );
  }
}

import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

//TODO: Add real [Image.asset] implementation
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * 0.1408,
        bottom: context.height * 0.049,
      ),
      width: context.width * 0.562,
      height: context.height * 0.14,
      child: Placeholder(),
    );
  }
}

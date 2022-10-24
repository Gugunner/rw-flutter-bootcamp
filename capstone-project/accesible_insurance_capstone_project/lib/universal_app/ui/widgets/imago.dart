import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Imago extends StatelessWidget {
  const Imago({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.height * 0.15,
      height: context.height * 0.15,
      child: SvgPicture.asset(
        logo,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const Placeholder(),
      ),
    );
  }
}

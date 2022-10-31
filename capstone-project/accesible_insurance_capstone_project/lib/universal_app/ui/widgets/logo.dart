import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/imago.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/assets.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/universal_constants.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.imagotype = false,
    this.width,
    this.height,
  }) : super(key: key);

  final bool imagotype;
  final double? width;
  final double? height;

//TODO: Add real [Image.asset] implementation
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: context.height * 0.046,
        bottom: context.height * 0.025,
      ),
      width: width ?? context.width * 0.562,
      height: height ?? context.height * 0.24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            flex: 2,
            child: Imago(),
          ),
          if (!imagotype)
            Flexible(
              flex: 1,
              child: Text(
                EnglishCopies.logoName,
                style: TextStyle(
                  fontFamily: UniversalConstants.chonburyFontFamily,
                  letterSpacing: 2.5,
                  color: Theme.of(context).primaryColor,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      offset: const Offset(0.5, 0.5),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

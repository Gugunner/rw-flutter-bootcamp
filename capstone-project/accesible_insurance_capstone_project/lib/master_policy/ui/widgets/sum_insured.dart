import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class SumInsured extends StatelessWidget {
  const SumInsured({
    Key? key,
    required this.currentSI,
  }) : super(key: key);

  final num currentSI;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Sum Insured',
          style: TextStyle(
            fontSize: 9,
          ),
        ),
        SizedBox(
          height: context.height * 0.007,
        ),
        Text(
          '\$${currentSI.toDouble()}',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

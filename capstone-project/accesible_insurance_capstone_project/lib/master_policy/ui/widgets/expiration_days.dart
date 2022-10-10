import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ExpirationDays extends StatelessWidget {
  const ExpirationDays({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.15,
      child: Text(
        'Expires in \n284 days',
        maxLines: 2,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

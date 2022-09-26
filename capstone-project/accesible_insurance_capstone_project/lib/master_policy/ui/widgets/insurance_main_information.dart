import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class InsuranceMainInformation extends StatelessWidget {
  const InsuranceMainInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
              context.width * 0.037, context.height * 0.028, 0, 0),
          width: context.width * 0.525,
          height: context.height * 0.063,
          padding: EdgeInsets.zero,
          child: Text(
            'Mama\'s home in Jalisco',
            maxLines: 2,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: context.width * 0.525,
          margin: EdgeInsets.fromLTRB(context.width * 0.037, 0, 0, 0),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: Huentitan, Jalisco, Mexico',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Rooms: 2 bedrooms, 1 bathroom',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        )
      ],
    );
  }
}

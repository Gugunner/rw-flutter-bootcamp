import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ExpirationDays extends StatelessWidget {
  const ExpirationDays({
    Key? key,
    this.isScreen = false,
    required this.expiredDate,
  }) : super(key: key);

  final bool isScreen;
  final DateTime? expiredDate;

  String get remainingDays {
    final today = DateTime.now();
    if (expiredDate != null) {
      final diffDate = expiredDate!.difference(today);
      final days = diffDate.inDays;
      return '$days days';
    }
    return '-';
  }

  //284 days
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.15,
      child: RichText(
        text: TextSpan(
            text: 'Expires in \n',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
            children: <TextSpan>[TextSpan(text: remainingDays)]),
        maxLines: 2,
      ),
    );
  }
}

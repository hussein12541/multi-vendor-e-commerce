import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_styles.dart';
import '../../../../../generated/l10n.dart';

class ForgotPassword extends StatelessWidget {
  final void Function() onTap;
  const ForgotPassword({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            S.of(context).forgotPassword,
            style: AppStyles.semiBold16(context).copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}

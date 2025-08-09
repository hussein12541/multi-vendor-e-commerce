import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_styles.dart';
import '../../../../../generated/l10n.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            S.of(context).or,
            style: AppStyles.semiBold16(context).copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

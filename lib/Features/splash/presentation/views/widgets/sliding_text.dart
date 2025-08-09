import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_styles.dart';
import '../../../../../generated/l10n.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).colorScheme.secondary);

    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            S.of(context).splashWord,
            style: AppStyles.semiBold20(context).copyWith( color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

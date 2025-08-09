import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';

import '../../../../../generated/l10n.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key, required this.tittle, this.onTap});
  final String tittle;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style:AppStyles.bold16(context),
        ),
        GestureDetector(
          onTap:onTap,
          child: Text(
            S.of(context).more,
            style: AppStyles.semiBold16(context).copyWith(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
      ],
    );
  }
}

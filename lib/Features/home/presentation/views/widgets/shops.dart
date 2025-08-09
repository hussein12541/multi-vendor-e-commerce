import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_e_commerce_app/core/models/store_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/store_item.dart';

import '../../manger/store_cubit/store_cubit.dart';

class Shops extends StatelessWidget {
  final List<StoreModel>stories;
  const Shops({
    super.key, required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190, // ارتفاع أكبر لاستيعاب المحتوى
      child: ListView.builder(
        itemCount: stories.length, // عدد المتاجر
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // تأثير تمرير طبيعي
        padding: const EdgeInsets.symmetric(horizontal: 16), // تباعد جانبي
        itemBuilder: (context, index) {
          return StoreItem(store: stories[index],favoriteOnPressed: () async {
            await  context.read<StoreCubit>().likeOnTap(stories[index].id);
          }, isDark: Theme.of(context).brightness==Brightness.dark,);
        },

      ),
    );
  }
}


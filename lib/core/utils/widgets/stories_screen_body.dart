
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/store_item.dart';

import '../../../Features/home/presentation/views/widgets/bottom_nav_height.dart';
import '../../../generated/l10n.dart';
import '../../models/store_model.dart';
import 'custom_text_field.dart';

class StoriesScreenBody extends StatefulWidget {
  final TextEditingController controller;
  final List<StoreModel> stories;

  const StoriesScreenBody({
    super.key,
    required this.controller,
    required this.stories,
  });

  @override
  State<StoriesScreenBody> createState() => _StoriesScreenBodyState();
}

class _StoriesScreenBodyState extends State<StoriesScreenBody> {
  @override
  Widget build(BuildContext context) {
    final query = widget.controller.text.toLowerCase();
    final filteredStores = widget.stories.where((store) {

      if(LanguageHelper.isArabic()){
        return store.arabic_name.toLowerCase().contains(query);

      }else{
        return store.english_name.toLowerCase().contains(query);

      }


    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            hintText: S.of(context).searchStore,
            controller: widget.controller,
            onChange: (_) => setState(() {}),
            prefixIcon: FontAwesomeIcons.search,
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      filteredStores.length,
                          (index) => SizedBox(
                        height: 190,
                        child: StoreItem(store: filteredStores[index], favoriteOnPressed: () async {
                        await  context.read<StoreCubit>().likeOnTap(filteredStores[index].id);
                        }, isDark: Theme.of(context).brightness==Brightness.dark,),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: AppDimensions.getBottomBarTotalHeight(context),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

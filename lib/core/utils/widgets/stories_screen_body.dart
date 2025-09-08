import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/store_item.dart';
import 'package:multi_vendor_e_commerce_app/generated/l10n.dart';
import '../../../Features/home/presentation/views/widgets/bottom_nav_height.dart';
import '../../models/store_model.dart';
import 'custom_text_field.dart';

class StoriesScreenBody extends StatefulWidget {
  final TextEditingController controller;
  final List<StoreModel> stories;
  final String? storeSearchQuery;

  const StoriesScreenBody({
    super.key,
    required this.controller,
    required this.stories,
    this.storeSearchQuery,
  });

  @override
  State<StoriesScreenBody> createState() => _StoriesScreenBodyState();
}

class _StoriesScreenBodyState extends State<StoriesScreenBody> {
  @override
  void initState() {
    super.initState();
    // Initialize controller with storeSearchQuery if provided
    if (widget.storeSearchQuery != null && widget.storeSearchQuery!.isNotEmpty) {
      widget.controller.text = widget.storeSearchQuery!;
    }
  }

  @override
  void didUpdateWidget(StoriesScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller if storeSearchQuery changes
    if (widget.storeSearchQuery != oldWidget.storeSearchQuery &&
        widget.storeSearchQuery != null &&
        widget.storeSearchQuery!.isNotEmpty) {
      widget.controller.text = widget.storeSearchQuery!;
      setState(() {}); // Trigger rebuild to apply filtering
    }
  }

  List<StoreModel> _filterStores(String query) {
    if (query.isEmpty) return widget.stories; // Return full list if query is empty
    final lowerQuery = query.toLowerCase();
    return widget.stories.where((store) {
      if (LanguageHelper.isArabic()) {
        return store.arabic_name.toLowerCase().contains(lowerQuery);
      } else {
        return store.english_name.toLowerCase().contains(lowerQuery);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Use controller.text if non-empty, otherwise use storeSearchQuery
    final query = widget.controller.text.isNotEmpty
        ? widget.controller.text.toLowerCase()
        : (widget.storeSearchQuery?.toLowerCase() ?? '');
    final filteredStores = _filterStores(query);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            hintText: S.of(context).searchStore,
            controller: widget.controller,
            onChange: (_) => setState(() {}), // Rebuild on search input
            prefixIcon: FontAwesomeIcons.search,

          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: filteredStores.isEmpty
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).no_stores_found,
                      style: AppStyles.semiBold16(context).copyWith(color: Colors.grey),
                    ),
                  ),
                )
                    : Center(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      filteredStores.length,
                          (index) => SizedBox(
                        height: 190,
                        child: StoreItem(
                          store: filteredStores[index],
                          favoriteOnPressed: () async {
                            await context
                                .read<StoreCubit>()
                                .likeOnTap(filteredStores[index].id);
                          },
                          isDark: Theme.of(context).brightness == Brightness.dark,
                        ),
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
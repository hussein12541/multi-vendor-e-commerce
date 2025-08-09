import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/models/store_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/products_screen_body.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/stories_screen_body.dart';
import '../../../generated/l10n.dart';
import '../functions/is_arabic.dart'; // لو دي مش موجودة ضيفها

class ProductsStores extends StatefulWidget {
  final List<ProductModel> products;
  final List<StoreModel> stores;
  final bool isFavoritesPage;

  const ProductsStores({
    super.key,
    required this.products,
    required this.stores,  this.isFavoritesPage=false,
  });

  @override
  State<ProductsStores> createState() => _ProductsStoresState();
}

class _ProductsStoresState extends State<ProductsStores> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController priceFromController = TextEditingController();
  final TextEditingController priceToController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<ProductModel> filteredProducts = [];
  String selectedSort = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  @override
  void dispose() {
    searchController.dispose();
    priceFromController.dispose();
    priceToController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredProducts = widget.products.where((product) {
        if (LanguageHelper.isArabic()) {
          return product.arabicName.toLowerCase().contains(searchQuery) ||
              product.arabicDescription.toLowerCase().contains(searchQuery);
        } else {
          return product.englishName.toLowerCase().contains(searchQuery) ||
              product.englishDescription.toLowerCase().contains(searchQuery);
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).favorites),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : Colors.grey,
            tabs: [
              Tab(text: S.of(context).products),
              Tab(text: S.of(context).stores),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductsBody(
              products: widget.products,
              filteredProducts: widget.isFavoritesPage?filteredProducts.where((element) => element.wishlists.isNotEmpty,).toList(): filteredProducts,
              selectedSort: selectedSort,
              searchController: searchController,
              priceFromController: priceFromController,
              priceToController: priceToController,
              formKey: formKey,
              onSearchChanged: _filterProducts,
              onFilterApplied: (List<ProductModel> filtered) {
                setState(() {
                  filteredProducts = filtered;
                });
              },
              onSortApplied: (String sortType, List<ProductModel> sorted) {
                setState(() {
                  selectedSort = sortType;
                  filteredProducts = sorted;
                });
              },
            ),
            StoriesScreenBody(
              controller: searchController,
              stories: widget.stores,
            ),
          ],
        ),
      ),
    );
  }
}

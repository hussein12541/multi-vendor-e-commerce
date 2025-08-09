import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/products_screen_body.dart';

class ProductsScreen extends StatefulWidget {
  final List<ProductModel> products;
  final String title;

  const ProductsScreen({super.key, required this.products, required this.title});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> filteredProducts = [];
  String searchQuery = '';
  String selectedSort = 'default';

  final TextEditingController searchController = TextEditingController();
  final TextEditingController priceFromController = TextEditingController();
  final TextEditingController priceToController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
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
        }}).toList();
    });
  }


  @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ProductsBody(
        products: widget.products,
        filteredProducts: filteredProducts,
        selectedSort: selectedSort,
        searchController: searchController,
        priceFromController: priceFromController,
        priceToController: priceToController,
        formKey: formKey,
        onSearchChanged: _filterProducts,
        onFilterApplied: (filteredList) {
          setState(() {
            filteredProducts = filteredList;
          });
        },
        onSortApplied: (sort, sortedList) {
          setState(() {
            selectedSort = sort;
            filteredProducts = sortedList;
          });
        },
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/products_screen_body.dart';
import '../../../../generated/l10n.dart';
import '../../models/store_model.dart';

class StoreProductsScreen extends StatefulWidget {
  final List<ProductModel> products;
  final StoreModel store;

  const StoreProductsScreen({super.key, required this.products, required this.store});

  @override
  State<StoreProductsScreen> createState() => _StoreProductsScreenState();
}

class _StoreProductsScreenState extends State<StoreProductsScreen> {
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
      appBar: AppBar(title: Text(LanguageHelper.isArabic()?widget.store.arabic_name:widget.store.english_name)),
      body: Column(
        children: [
          StoreBar(store: widget.store,),
          Expanded(
            child: ProductsBody(
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
          ),
        ],
      ),
    );
  }

}




class StoreBar extends StatefulWidget {
  const StoreBar({
    super.key,
    required this.store,
  });

  final StoreModel store;

  @override
  State<StoreBar> createState() => _StoreBarState();
}

class _StoreBarState extends State<StoreBar> {
  late double _userRating;

  @override
  void initState() {
    super.initState();
    _userRating = widget.store.userRating ?? 0;
  }

  void _updateRating(double value) async {
    setState(() => _userRating = value);
    await context.read<StoreCubit>().rateOnTap(widget.store.id, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 🧠 دي مهمة علشان البادج ما ينزلش تحت
            children: [
              _buildStoreImage(),
              const SizedBox(width: 16),
              Expanded(child: _buildInfo(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreImage() {
    return SizedBox(
      width: 90,
      height: 90,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.store.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey.shade200,
            child: Icon(Icons.store, size: 36, color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }


  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // 👈 ده بيخلي الكولوم ما يمدّش زيادة

      children: [
        // Store Name
        Text(
          LanguageHelper.isArabic()
              ? widget.store.arabic_name
              : widget.store.english_name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Rating Stars
        Tooltip(
          enableFeedback: true,
          message: S.of(context).yourRating,
          child: RatingStars(
            value: _userRating,
            onValueChanged: _updateRating,
            starCount: 5,
            starSize: 22,
            maxValue: 5,
            valueLabelVisibility: true,
            valueLabelTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Colors.black,
            ),
            valueLabelRadius: 12,
            valueLabelColor: Colors.amber.shade200,
            starColor: Colors.amber,
            starOffColor: Colors.grey.shade300,
            animationDuration: const Duration(milliseconds: 400),
          ),
        ),
        const SizedBox(height: 8),

        // Badges (Average & User)
        Column(
          children: [
            _buildRatingBadge(
              value: widget.store.rating,
              label: S.of(context).average,
              color: Colors.blueGrey.shade100,
              iconColor: Colors.grey.shade800,
            ),
            const SizedBox(height: 8),
            _buildRatingBadge(
              value: _userRating,
              label: S.of(context).yourRating,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              iconColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildRatingBadge({
    required double value,
    required String label,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.star, size: 16, color: iconColor),
          const SizedBox(width: 4),
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

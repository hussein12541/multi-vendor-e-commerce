import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/is_arabic.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/product_image_details_screen.dart';
import '../../../Features/cart/presentation/manger/cart_cubit/cart_cubit.dart';
import '../../../Features/home/data/repos/home_repo_impl.dart';
import '../../../Features/home/presentation/manger/offer_cubit/offer_cubit.dart';
import '../../../Features/home/presentation/manger/product_cubit/product_cubit.dart';
import '../../../generated/l10n.dart';
import 'custom_button.dart';

// ويدجت رئيسية لشاشة تفاصيل المنتج
class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isLoading = false;

  // دالة لمعالجة إضافة المنتج إلى قائمة المفضلة
  Future<void> _toggleWishlist(BuildContext context) async {
    if (!isLoading) {
      setState(() => isLoading = true);
      await HomeRepoImpl().addOnlineProductLike(widget.product.id);
      await context.read<OfferCubit>().toggleWishlistLocally(widget.product.id);
      await context.read<ProductCubit>().toggleWishlistLocally(widget.product.id);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🔹 SliverAppBar مع FlexibleSpaceBar
          ProductDetailsAppBar(
            product: widget.product,
            isLoading: isLoading,
            onWishlistPressed: () => _toggleWishlist(context),
          ),
          // 🔹 تفاصيل المنتج
          ProductDetailsContent(product: widget.product),
        ],
      ),
      // 🔹 زر الإضافة إلى السلة
      bottomNavigationBar: AddToCartButton(
        product: widget.product,
        onPressed: () {
          if (widget.product.quantity > 0) {
            context.read<CartCubit>().addItem(widget.product, context);
          }
        },
      ),
    );
  }
}

// ويدجت لـ SliverAppBar
class ProductDetailsAppBar extends StatelessWidget {
  final ProductModel product;
  final bool isLoading;
  final VoidCallback onWishlistPressed;

  const ProductDetailsAppBar({
    super.key,
    required this.product,
    required this.isLoading,
    required this.onWishlistPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool kIsArabic = LanguageHelper.isArabic();

    return SliverAppBar(
      actionsPadding: EdgeInsets.zero,
      expandedHeight: 320,
      pinned: true,
      floating: false,
      automaticallyImplyLeading: false,
      titleTextStyle: AppStyles.bold20(context),
      elevation: 4,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: product.id,
              child: ProductImageDetailsScreen(product: product),
            ),
          ],
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final percent = ((constraints.maxHeight - kToolbarHeight) /
                (320 - kToolbarHeight))
                .clamp(0.0, 1.0);
            final opacity = (1 - percent).clamp(0.0, 1.0);

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 320 * opacity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black.withOpacity(0.3 * opacity)
                    : Colors.white.withOpacity(0.1 * opacity),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // زر الرجوع
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black87.withOpacity(0.5 * opacity),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white.withOpacity(0.5 * opacity),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // صورة المنتج وتفاصيل
                  Expanded(
                    child: Opacity(
                      opacity: opacity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // صورة المنتج الصغيرة
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.imageUrl ?? '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // اسم المنتج والتقييم
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kIsArabic ? product.arabicName : product.englishName,
                                  style: AppStyles.semiBold18(context).copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 4,
                                        color: Colors.black.withOpacity(0.3),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      product.averageRate.toString(),
                                      style: AppStyles.bold16(context).copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // زر المفضلة
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black87.withOpacity(0.5 * opacity),
                      child: isLoading
                          ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: LoadingAnimationWidget.bouncingBall(
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      )
                          : IconButton(
                        icon: product.wishlists.isEmpty
                            ? Icon(
                          Icons.favorite_border,
                          color: Colors.white.withOpacity(0.5 * opacity),
                        )
                            : const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ),
                        onPressed: onWishlistPressed,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        titlePadding: EdgeInsets.zero,
      ),
    );
  }
}

// ويدجت لعرض تفاصيل المنتج
class ProductDetailsContent extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool kIsArabic = LanguageHelper.isArabic();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐️ التقييم + السعر
            Text(
              kIsArabic ? product.arabicName : product.englishName,
              style: AppStyles.semiBold24(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // التقييم
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 5),
                        Text(
                          product.averageRate.toString(),
                          style: AppStyles.bold16(context),
                        ),
                        Text(
                          " (${product.rates.length.toString()})",
                        ),
                      ],
                    ),
                  ],
                ),
                // السعر أو غير متاح
                if (product.quantity > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${product.price} ${S.of(context).currency}',
                        style: AppStyles.bold24(context).copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      if (product.oldPrice != null && product.oldPrice! > product.price)
                        Text(
                          '${product.oldPrice!.toStringAsFixed(0)} ${S.of(context).currency}',
                          style: AppStyles.regular16(context)
                              .copyWith(color: Colors.grey)
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  )
                else
                  Text(
                    S.of(context).notAvailable,
                    style: AppStyles.bold20(context).copyWith(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // 📝 الوصف
            Text(
              S.of(context).description + ' :',
              style: AppStyles.semiBold16(context).copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kIsArabic ? product.arabicDescription : product.englishDescription,
              style: AppStyles.medium16(context),
            ),
            const SizedBox(height: 100), // مساحة للزر السفلي
          ],
        ),
      ),
    );
  }
}

// ويدجت لزر الإضافة إلى السلة
class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onPressed;

  const AddToCartButton({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomButton(
        backgroundColor: product.quantity > 0 ? null : Colors.redAccent,
        height: 48,
        onPressed: onPressed,
        text: product.quantity > 0 ? S.of(context).add : S.of(context).notAvailable,
      ),
    );
  }
}
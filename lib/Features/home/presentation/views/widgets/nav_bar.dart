import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/offer_cubit/offer_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/utils/widgets/products_and_stores_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../cart/presentation/views/cart_view.dart';
import '../home_view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> pages = <Widget>[
      const HomeView(),
      ProductsStores(
        isFavoritesPage: true,
        stores: context
            .read<StoreCubit>()
            .stores
            .where(
              (store) => store.favoriteStores.any(
                (fav) =>
                    fav.storeId == store.id &&
                    fav.userId == Supabase.instance.client.auth.currentUser!.id,
              ),
            )
            .toList(),
        products: context
            .read<ProductCubit>()
            .products
            .where((element) => element.wishlists.isNotEmpty)
            .toList(),
      ),
      const CartView(),
      const HomeView(),
    ];

    return Skeletonizer(
      enabled:
          (context.watch<StoreCubit>().state is! GetStoresSuccess ||context.watch<OfferCubit>().state is! GetOffersSuccess ||
          context.watch<ProductCubit>().state is! GetProductsSuccess),
      child: Scaffold(
        extendBody: true, // ضروري عشان البار يبقى فوق الخلفية الشفافة
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: pages[_selectedIndex],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.025, // حوالي 3% من ارتفاع الشاشة
            horizontal: screenWidth * 0.05, // حوالي 8% من عرض الشاشة
          ),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).scaffoldBackgroundColor.withOpacity(0.90), // لون Bookly
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey[500],
              enableFeedback: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    (_selectedIndex == 0) ? Icons.home : Icons.home_outlined,
                  ),
                  label: S.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    (_selectedIndex == 1)
                        ? Icons.favorite_outlined
                        : Icons.favorite_outline,
                  ),
                  label: S.of(context).favorites,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    (_selectedIndex == 2)
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                  ),
                  label: S.of(context).cart,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    (_selectedIndex == 3)
                        ? Icons.favorite_outlined
                        : Icons.favorite_outline,
                  ),
                  label: S.of(context).favorites,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/data/models/offer_model/offer_model.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/category_cubit/category_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/offer_cubit/offer_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/manger/store_cubit/store_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/bottom_nav_height.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/categories.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/home_header.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/offers_bar.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/presentation/views/widgets/shops.dart';
import 'package:multi_vendor_e_commerce_app/core/models/category_model.dart';
import 'package:multi_vendor_e_commerce_app/core/models/store_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/styles/app_styles.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/products_screen.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/products_sliver_grid.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/widgets/custom_text_field.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/widgets/products_and_stores_screen.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/utils/widgets/category_screen.dart';
import '../../../../core/utils/widgets/stories_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ProductCubit>().getProducts();
          await  context.read<StoreCubit>().getStores();
          await  context.read<OfferCubit>().getOffers();
          await  context.read<CategoryCubit>().getCategories();

        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(child: HomeHeader()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  hintText: S.of(context).searchProductOrStore,
                  controller: TextEditingController(),
                  prefixIcon: FontAwesomeIcons.search,
                  onSubmit: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsStores(products: context.read<ProductCubit>().products, stores: context.read<StoreCubit>().stores,productSearchQuery: value,storeSearchQuery: value, title: S.of(context).searchResults,),)),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: BlocBuilder<OfferCubit, OfferState>(
                builder: (context, state) {
                  final isLoading = (state is! GetOffersSuccess && context.watch<ProductCubit>().state is! GetProductsSuccess);
                  List<OfferModel> offers = state is GetOffersSuccess
                      ? state.offers
                      : [
                    OfferModel(
                      id: "1",
                      arabicName: "عرض الصيف المجنون ☀️",
                      englishName: "Crazy Summer Offer",
                      imageUrl: "https://picsum.photos/300/200?random=1",
                      deleteImageUrl: "https://delete.fake.com/1",
                      createdAt: DateTime.now().subtract(const Duration(days: 1)),
                      offerProducts: [],
                    ),
                    OfferModel(
                      id: "2",
                      arabicName: "خصم العيد الكبير 🎉",
                      englishName: "Eid Mega Sale",
                      imageUrl: "https://picsum.photos/300/200?random=2",
                      deleteImageUrl: "https://delete.fake.com/2",
                      createdAt: DateTime.now().subtract(const Duration(days: 2)),
                      offerProducts: [],
                    ),
                    OfferModel(
                      id: "3",
                      arabicName: "عرض العودة للمدارس 🎒",
                      englishName: "Back to School Offer",
                      imageUrl: "https://picsum.photos/300/200?random=3",
                      deleteImageUrl: "https://delete.fake.com/3",
                      createdAt: DateTime.now().subtract(const Duration(days: 3)),
                      offerProducts: [],
                    ),
                  ];
                  return Skeletonizer(
                    enabled: isLoading,
                    child: OffersBar(offers: offers),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<CategoryCubit,CategoryState>(
                  builder:(context, state) =>  Skeletonizer(
                    enabled: state is! GetCategoriesSuccess,
                    child: BestSellingHeader(
                      tittle: S.of(context).categories,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                              categories: (state is! GetCategoriesSuccess)?[    CategoryModel(
                              arabicName: 'name',
                              englishName: 'e name',
                              createdAt: DateTime.now(),
                              id: 'sasa',
                              isShow: true,
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/706/706164.png',
                            ),
                  CategoryModel(
                              arabicName: 'name',
                              englishName: 'e name',
                              createdAt: DateTime.now(),
                              id: 'sasa',
                              isShow: true,
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/706/706164.png',
                            ),
                 ]:state.categories

                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: BlocBuilder<CategoryCubit,CategoryState>(
                builder:(context, state) =>  Skeletonizer(
                  enabled: state is! GetCategoriesSuccess,
                  child: Categories(
                    categories: (state is! GetCategoriesSuccess)?[    CategoryModel(
                              arabicName: 'name',
                              englishName: 'e name',
                              createdAt: DateTime.now(),
                              id: 'sasa',
                              isShow: true,
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/706/706164.png',
                            ),
                  CategoryModel(
                              arabicName: 'name',
                              englishName: 'e name',
                              createdAt: DateTime.now(),
                              id: 'sasa',
                              isShow: true,
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/706/706164.png',
                            ),
                 ]:state.categories

                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is! GetProductsSuccess ) {
                  return SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BestSellingHeader(
                          tittle: S.of(context).bestSeller,
                          onTap: () {},
                        ),
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BestSellingHeader(
                      tittle: S.of(context).bestSeller,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              products: [...state.products]
                                ..sort((a, b) => (b.bought_times ?? 0).compareTo(a.bought_times ?? 0)),
                              title: S.of(context).bestSeller,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is! GetProductsSuccess) {
                  return ProductsSliverGrid(
                    isHome: true,
                    isLoading: true,
                    products: _getPlaceholderProducts(),
                  );
                }
                return ProductsSliverGrid(
                  isHome: true,
                  isLoading: false,
                  products: [...state.products]
                    ..sort((a, b) => (b.bought_times ?? 0).compareTo(a.bought_times ?? 0)),
                );
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<StoreCubit, StoreState>(
                  builder: (context, state) => Skeletonizer(
                    enabled: (state is! GetStoresSuccess && context.watch<ProductCubit>().state is! GetProductsSuccess),
                    child: BestSellingHeader(
                      tittle: S.of(context).stores,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoriesScreen(
                              stories: state is GetStoresSuccess
                                  ? state.stores
                                  : _getPlaceholderStores(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) => Skeletonizer(
                  enabled: (state is! GetStoresSuccess && context.watch<ProductCubit>().state is! GetProductsSuccess),
                  child: Shops(
                    stories: state is GetStoresSuccess ? state.stores : _getPlaceholderStores(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is! GetProductsSuccess) {
                  return SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BestSellingHeader(
                          tittle: S.of(context).latest,
                          onTap: () {},
                        ),
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BestSellingHeader(
                      tittle: S.of(context).latest,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsScreen(
                              products: state.products..sort((a, b) => b.created_at.compareTo(a.created_at)),
                              title: S.of(context).latest,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is! GetProductsSuccess) {
                  return ProductsSliverGrid(
                    isLoading: true,
                    isHome: true,
                    products: _getPlaceholderProducts(),
                  );
                }
                return ProductsSliverGrid(
                  isLoading: false,
                  isHome: true,
                  products: [...state.products]..sort((a, b) => b.created_at.compareTo(a.created_at)),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppDimensions.getBottomBarTotalHeight(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ProductModel> _getPlaceholderProducts() {
    return List.generate(
      4,
          (_) => ProductModel(
        created_at: DateTime.now().toString(),
        id: 'id',
        arabicName: 'arabicName',
        englishName: 'englishName',
        arabicDescription: 'arabicDescription',
        englishDescription: 'englishDescription',
        imageUrl: 'imageUrl',
        deleteImageUrl: 'deleteImageUrl',
        price: 50,
        weight: 1,
        oldPrice: 12,
        isShow: true,
        quantity: 5,
        storeId: 'storeId',
        categoryId: 'categoryId',
        wishlists: [],
        store: StoreModel(
           userRating: 5,
           deleteImageUrl: 'fdsfdsfds',
          id: 'id',
          arabic_name: 'arabic_name',
          english_name: "english_name",
          imageUrl: "imageUrl",
          arabic_description: "description",
          english_description: "description",
          userId: "userId",
          createdAt: DateTime.now(),
          isShow: true,
          rating: 4.5,
          ratingCount: 25,
          favoriteStores: [],
        ),
        rates: [], comments: [],
      ),
    );
  }

  List<StoreModel> _getPlaceholderStores() {
    return List.generate(
      3,
          (_) => StoreModel(
        favoriteStores: [],
        userRating: 5,
        deleteImageUrl: 'fdsfdsfd',
        id: "id",
        arabic_name: "storeName",
        english_name: "storeName",
        imageUrl: "imageUrl",
         arabic_description: "description",
         english_description: "description",
        userId: "userId",
        createdAt: DateTime.now(),
        isShow: true,
        rating: 4.5,
        ratingCount: 5,
      ),
    );
  }
}














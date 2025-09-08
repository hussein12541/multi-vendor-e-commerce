import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/data/models/offer_model/offer_model.dart';
import 'package:multi_vendor_e_commerce_app/Features/home/data/repos/home_repo.dart';
import 'package:multi_vendor_e_commerce_app/core/errors/failures.dart';
import 'package:multi_vendor_e_commerce_app/core/models/category_model.dart';
import 'package:multi_vendor_e_commerce_app/core/models/product_model.dart';
import 'package:multi_vendor_e_commerce_app/core/models/store_model.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/api_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeRepoImpl implements HomeRepo{
  final ApiServices _api=ApiServices();
  @override
  Future<Either<Failure, List<OfferModel>>> getOffers({required String id}) async {
    try {
      Response response=await _api.getData(path: 'offers?select=*,offer_products(*,products(*,stores(*,favorites_stores(*),store_reviews(*)),rates(*),wishlists(*)))&offer_products.products.is_show=eq.true&offer_products.products.wishlists.user_id=eq.$id');
      List<OfferModel>offers=[];
      for(var item in response.data){
        offers.add(OfferModel.fromJson(item));
      }
      return right(offers);
    } on Exception catch (e) {
     return left( ServerFailure(e.toString())); // TODO
    }

  }
@override
  Future<Either<Failure, List<ProductModel>>> getProducts({required String id}) async {
    try {
      Response response=await _api.getData(path: 'products?select=*,order_items(*,orders(*)),comments(*),stores(*,favorites_stores(*),store_reviews(*)),rates(*),wishlists(*)&is_show=eq.true&order_items.orders.user_id=eq.$id&wishlists.user_id=eq.$id');
      List<ProductModel>products=[];
      for(var item in response.data){
        products.add(ProductModel.fromJson(item));
      }
      return right(products);
    } on Exception catch (e) {
     return left( ServerFailure(e.toString())); // TODO
    }

  }

  @override
  Future<void> addOnlineProductLike(String productId) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    final response = await ApiServices().getData(
      path: 'wishlists?user_id=eq.$userId&product_id=eq.$productId',
    );

    final isInWishlist = (response.data as List).isNotEmpty;

    if (!isInWishlist) {
      await ApiServices().postData(
        path: 'wishlists',
        data: {"user_id": userId, "product_id": productId},
      );
    } else {
      await ApiServices().deleteData(
        path: 'wishlists?user_id=eq.$userId&product_id=eq.$productId',
      );
    }
  }

  @override
  Future<Either<Failure, List<StoreModel>>> getStores() async {
    try {
      Response response=await _api.getData(path: 'stores?select=*,favorites_stores(*),store_reviews(*)&is_show=eq.true');
      List<StoreModel>stores=[];
      for(var item in response.data){
        stores.add(StoreModel.fromJson(item, currentUserId: Supabase.instance.client.auth.currentUser!.id));
      }
      return right(stores);
    } on Exception catch (e) {
      return left( ServerFailure(e.toString())); // TODO
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategory() async {
    try {
      Response response=await _api.getData(path: 'categories?is_show=eq.true');
      List<CategoryModel>categories=[];
      for(var item in response.data){
        categories.add(CategoryModel.fromJson(item));
      }
      return right(categories);
    } on Exception catch (e) {
      return left( ServerFailure(e.toString())); // TODO
    }
  }
 @override
  Future<void> addOnlineStoreRate(storeId, double rate) async {
   try {
     final userId = Supabase.instance.client.auth.currentUser?.id;
     if (userId == null) return;

     final response = await ApiServices().getData(
       path: 'store_reviews?user_id=eq.$userId&store_id=eq.$storeId',
     );

     final isInWishlist = (response.data as List).isNotEmpty;

     if (!isInWishlist) {
       await ApiServices().postData(
         path: 'store_reviews',
         data: {"user_id": userId, "store_id": storeId,"rating":rate},
       );
     } else {
       await ApiServices().patchData(
         path: 'store_reviews?user_id=eq.$userId&store_id=eq.$storeId',
         data: {"rating":rate},
       );
     }
   } on Exception catch (e) {
     log(e.toString());
   }
  }

  @override
  Future<void> addOnlineStoreLike(String storeId) async {

    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      final response = await ApiServices().getData(
        path: 'favorites_stores?user_id=eq.$userId&store_id=eq.$storeId',
      );

      final isInWishlist = (response.data as List).isNotEmpty;

      if (!isInWishlist) {
        await ApiServices().postData(
          path: 'favorites_stores',
          data: {"user_id": userId, "store_id": storeId},
        );
      } else {
        await ApiServices().deleteData(
          path: 'favorites_stores?user_id=eq.$userId&store_id=eq.$storeId',
        );
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }


}
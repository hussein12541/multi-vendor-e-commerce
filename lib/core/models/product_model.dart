import 'package:multi_vendor_e_commerce_app/core/models/store_model.dart';
import 'package:multi_vendor_e_commerce_app/core/models/wish_list_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'comment_model.dart';
import 'rate_model.dart'; // لو حطيته في فايل مستقل

class ProductModel {
  final String id;
  final String arabicName;
  final int? bought_times;
  final String englishName;
  final String arabicDescription;
  final String englishDescription;
  final String? imageUrl;
  final String? deleteImageUrl;
  final double price;
  final double weight;
  final double? oldPrice;
  final bool isShow;
  final int quantity;
  final String storeId;
  final String categoryId;
  final List<WishlistModel> wishlists;
  final StoreModel store;
  final List<RateModel> rates;
  final String created_at;
  final List<CommentModel> comments;

  ProductModel( {
    required this.created_at,
    required this.id,
    required this.arabicName,
     this.bought_times,
    required this.englishName,
    required this.arabicDescription,
    required this.englishDescription,
    required this.imageUrl,
    required this.deleteImageUrl,
    required this.price,
    required this.weight,
    required this.oldPrice,
    required this.isShow,
    required this.quantity,
    required this.storeId,
    required this.categoryId,
    required this.wishlists,
    required this.store,
    required this.rates,
    required this.comments,
  });
  double get averageRate {
    if (rates.isEmpty) return 0.0;
    double sum = rates.fold(0.0, (total, rate) => total + rate.rate);
    return sum / rates.length;
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': created_at,
      'arabic_name': arabicName,
      'bought_times': bought_times,
      'english_name': englishName,
      'arabic_description': arabicDescription,
      'english_description': englishDescription,
      'image_url': imageUrl,
      'delete_image_url': deleteImageUrl,
      'price': price,
      'weight': weight,
      'old_price': oldPrice,
      'is_show': isShow,
      'quantity': quantity,
      'store_id': storeId,
      'category_id': categoryId,
      'wishlists': wishlists.map((e) => e.toJson()).toList(),
      'stores': store.toJson(),
      'rates': rates.map((e) => e.toJson()).toList(),
      'comments': comments.map((e) => e.toJson()).toList(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      created_at: json['created_at'],
      arabicName: json['arabic_name'],
      bought_times: json['bought_times'],
      englishName: json['english_name'],
      arabicDescription: json['arabic_description'],
      englishDescription: json['english_description'],
      imageUrl: json['image_url'],
      deleteImageUrl: json['delete_image_url'],
      price: (json['price'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      oldPrice: json['old_price'] != null ? (json['old_price'] as num).toDouble() : null,
      isShow: json['is_show'],
      quantity: json['quantity'],
      storeId: json['store_id'],
      categoryId: json['category_id'],
      wishlists: (json['wishlists'] as List?)?.map((e) => WishlistModel.fromJson(e)).toList() ?? [],
      store: StoreModel.fromJson(json['stores'], currentUserId:Supabase.instance.client.auth.currentUser!.id),
      rates: (json['rates'] as List?)?.map((e) => RateModel.fromJson(e)).toList() ?? [],
      comments: (json['comments'] as List?)?.map((e) => CommentModel.fromJson(e)).toList() ?? [],
    );
  }
}

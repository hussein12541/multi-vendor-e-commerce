import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce_app/Features/cart/data/models/cart_model/cart_model.dart';
import 'package:multi_vendor_e_commerce_app/core/errors/failures.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/api_services.dart';
import 'package:multi_vendor_e_commerce_app/core/utils/functions/show_message.dart';
import 'package:multi_vendor_e_commerce_app/generated/l10n.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final ApiServices _api = ApiServices();

  Future<Either<Failure, bool>> checkProductsAvilable(
    BuildContext context,
    CartModel cart,
  ) async {
    try {
      for (var item in cart.items) {
        int availableCount = 0;

        final response = await _api.getData(path: 'products?id=eq.${item.id}');

        if (response.data == null || response.data.isEmpty) {
          return Left(ServerFailure(S.of(context).productNotFound));
        }

        availableCount = response.data[0]['quantity'];

        if (availableCount < item.quantity) {
          ShowMessage.showToast(
            '${S.of(context).availableQuantityFrom} ${item.product.arabicName} ${S.of(context).quantityIs} $availableCount',
          );
          return const Right(false);
        }
      }

      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addProductToCart({
    required CartModel cart,
    required String name,
    required String phone,
    required String address,
    required bool isPaid,
    required String addressUrl,
    required double price,
  }) async {
    try {
      for (var item in cart.items) {
        await _api.postData(
          path: 'rpc/update_product_after_order',
          data: {
            "p_product_id": item.product.id,
            "p_bought_quantity": item.quantity,
          },
        );
      }
      final orderId = const Uuid().v4();
      await _api.postData(
        path: 'orders',
        data: {
          "id": orderId,
          "user_id": Supabase.instance.client.auth.currentUser!.id,
          "total_price": price,
          "name": name,
          "phone": phone,
          "address": address,
          "is_paid": isPaid,
          "address_url": addressUrl,
          "status": 0,
        },
      );

      for (var item in cart.items) {
        await _api.postData(
          path: 'order_items',
          data: {
            "price": item.totalPrice,
            "product_id": item.product.id,
            "quantity": item.quantity,
            "order_id": orderId,
          },
        );
      }




      final response = await _api.getData(path: 'orders?id=eq.$orderId');
final number = response.data[0]['number'].toString();

      
      return Right(number);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


}

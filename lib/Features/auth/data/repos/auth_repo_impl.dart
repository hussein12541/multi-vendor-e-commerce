import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/data/repos/auth_repo.dart';
import 'package:multi_vendor_e_commerce_app/core/errors/failures.dart';
import 'package:multi_vendor_e_commerce_app/core/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/api_services.dart';
import '../../../../core/utils/local_storage_helper.dart';

class AuthRepoImpl implements AuthRepo {
  final SupabaseClient client = Supabase.instance.client;
  final ApiServices _api = ApiServices();

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // تسجيل الدخول
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (response.user == null || response.session == null) {
        return left(
          ServerFailure(
            'فشل إنشاء الحساب، قد يكون البريد الإلكتروني مستخدم بالفعل.',
          ),
        );
      }

      // جلب بيانات المستخدم من جدول users عن طريق API
      final userId = user?.id;
      final userResponse = await _api.getData(path: 'users?id=eq.$userId');

      if (userResponse.data == null || userResponse.data.isEmpty) {
        return left(
          ServerFailure('لم يتم العثور على بيانات المستخدم في قاعدة البيانات.'),
        );
      }

      final userModel = UserModel.fromJson(userResponse.data[0]);
      await LocalStorageHelper.saveUserName(userModel.name);


      return right(userModel);
    } on AuthException catch (e) {
      return left(ServerFailure(e.message));
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message ?? 'خطأ في قاعدة البيانات'));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير متوقع: $e'));
    }
  }


  @override
  Future<Either<Failure, UserModel>> googleLoginIn() async {
    try {
      final signIn = GoogleSignIn.instance;
      signIn.initialize(
        serverClientId: "957125236670-ugrp2ojt738pnlhrbvicqufdefblq4ek.apps.googleusercontent.com",);

      // تسجيل الدخول
      final GoogleSignInAccount googleUser = await signIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthResponse response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
      );

      final user = response.user;
      if (user == null) {
        return left(ServerFailure('فشل تسجيل الدخول بجوجل.'));
      }

      final userId = user.id;

      // نتحقق هل المستخدم موجود في جدول users
      final userResponse = await _api.getData(path: 'users?id=eq.$userId');

      if (userResponse.data == null || userResponse.data.isEmpty) {
        // المستخدم جديد؟ نضيفه في الجدول
        final userData = {
          'id': userId,
          'name': googleUser.displayName ?? '',
          'email': googleUser.email,
          'password': '', // أو null لو موديلك يدعم
          'role': 'buyer',
        };

        await _api.postData(path: "users", data: userData);
        await LocalStorageHelper.saveUserName(userData["name"]!);

        return right(UserModel(password:userData["password"]!,email: userData["email"]!,name: userData["name"]!,createdAt: DateTime.now() ,id: userData["id"]!,role: userData["role"]!));
      }

      final userModel = UserModel.fromJson(userResponse.data[0]);
      await LocalStorageHelper.saveUserName(userModel.name);

      return right(userModel);
    } on AuthException catch (e) {
      return left(ServerFailure(e.message));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure('حصل خطأ غير متوقع: $e'));
    }
  }


  @override
  Future<Either<Failure, UserModel>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;

      // نضيف البيانات في جدول users
      final userData = {
        'id': user?.id,
        'name': name,
        'email': email,
        'password': password, // ❌ مش آمن تخزينه كده
        'role': 'buyer',
      };

      await _api.postData(path: "users", data: userData);

      final userModel = UserModel(
        id: userData["id"]!,
        createdAt: DateTime.now(),
        name: userData["name"]!,
        email: userData["email"]!,
        password: userData["password"]!,
        role: userData["role"]!,
      );
      await LocalStorageHelper.saveUserName(userModel.name);


      return right(userModel);
    } on PostgrestException catch (e) {
      log(e.toString());
      return left(ServerFailure(e.message ?? 'خطأ في قاعدة البيانات'));
    } on DioException catch (e) {
     log(e.toString());
      return left(ServerFailure.fromDioException(e));
    } on AuthException catch (e) {
    log(e.toString());
      return left(ServerFailure(e.message));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure('حصل خطأ غير متوقع أثناء إنشاء الحساب: $e'));
    }
  }
}

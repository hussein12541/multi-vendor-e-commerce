

import 'package:dartz/dartz.dart';
import 'package:multi_vendor_e_commerce_app/core/models/user_model.dart';

import '../../../../core/errors/failures.dart';



abstract class AuthRepo {

  Future<Either<Failure, UserModel>> login({required String email,required String password,});
  Future<Either<Failure, UserModel>> googleLoginIn();
  Future<Either<Failure, UserModel>> signUp({required String email,required String password,required String name});



}


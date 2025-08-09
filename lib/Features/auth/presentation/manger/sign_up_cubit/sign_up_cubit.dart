import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/data/repos/auth_repo.dart';

import '../../../../../core/models/user_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit(this.authRepo) : super(SignUpInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.signUp(
      email: email,
      password: password,
      name: name,
    );
    result.fold((failure) {
      emit(SignUpError(failure.errMessage));
    }, (userModel) {
      emit(SignUpSuccess(userModel));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/presentation/manger/sign_up_cubit/sign_up_cubit.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/presentation/views/widgets/sign_up_body.dart';

import '../../../../core/utils/functions/show_message.dart';
import '../../../../core/utils/styles/app_styles.dart';
import '../../../../core/utils/widgets/loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/views/widgets/nav_bar.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(AuthRepoImpl()),
      child: BlocConsumer<SignUpCubit,SignUpState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SignUpLoading,
            dismissible: state is! SignUpLoading,
            opacity: 0.4,
            // يعطي ظل خفيف وشيك
            progressIndicator: loadingWidget(context),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).signup,
                  style: AppStyles.semiBold24(context),
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: SignUpBody(
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        await context.read<SignUpCubit>().signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SignUpSuccess) {

            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
          } else if (state is SignUpError) {
            ShowMessage.showToast(state.errorMessage);
          }
        },
      ),
    );
  }
}

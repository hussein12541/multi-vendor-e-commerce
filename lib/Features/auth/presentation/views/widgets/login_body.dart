import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/presentation/views/reset_password.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/presentation/views/widgets/password_text_form_field.dart';

import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import 'custom_social_login_button.dart';
import 'dont_have_account.dart';
import 'email_text_form_field.dart';
import 'forgot_password.dart';
import 'or_widget.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
    required this.emailController,
    required this.passwordController, required this.googleLoginOnPressed, required this.loginOnPressed,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
final void Function() googleLoginOnPressed;
final void Function() loginOnPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 5 / 3,
            child: Image.asset(Assets.imagesLogo),
          ),
          const SizedBox(height: 16),
          EmailTextFormField(emailController: emailController),
          const SizedBox(height: 16),
          PasswordTextFormField(passwordController: passwordController),
          const SizedBox(height: 10),
          ForgotPassword(onTap: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
          },),
          const SizedBox(height: 25),
          CustomButton(onPressed: loginOnPressed, text: S.of(context).login),
          const SizedBox(height: 20),
          DontHaveAccount(),
          const SizedBox(height: 30),
          OrWidget(),
          const SizedBox(height: 30),
          CustomSocialLoginButton(
            onPressed:googleLoginOnPressed,
            icon: SvgPicture.asset(Assets.imagesGoogle),
            text: S.of(context).loginWithGoogle,
          ),
        ],
      ),
    );
  }
}



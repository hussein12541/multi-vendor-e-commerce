import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce_app/Features/auth/presentation/views/widgets/password_text_form_field.dart';

import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import 'email_text_form_field.dart';
import 'name_text_form_field.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.passwordController, required this.onPressed,

  });

  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final void Function() onPressed;
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
          NameTextFormField(nameController: nameController),
          const SizedBox(height: 16),
          EmailTextFormField(emailController: emailController),
          const SizedBox(height: 16),
          PasswordTextFormField(passwordController: passwordController),
          const SizedBox(height: 25),
          CustomButton(onPressed: onPressed, text: S.of(context).signup),
        ],
      ),
    );
  }
}



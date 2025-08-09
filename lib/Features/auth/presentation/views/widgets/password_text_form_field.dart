import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.lock_outline_rounded,
      hintText: S.of(context).password,
      controller: passwordController,
      isPassword: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).pleaseEnterYourPassword;
        }
        if (value.length < 6) {
          return S.of(context).passwordTooShort;
        }
        return null;
      },
    );
  }
}

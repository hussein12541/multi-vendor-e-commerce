import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon: Icons.email_outlined,
      hintText: S.of(context).email,
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).pleaseEnterYourEmail;
        }
        if (!RegExp(
          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
        ).hasMatch(value)) {
          return S.of(context).pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }
}

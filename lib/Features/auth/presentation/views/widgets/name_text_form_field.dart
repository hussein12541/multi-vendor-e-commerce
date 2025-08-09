import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      prefixIcon:  FontAwesomeIcons.userPen,
      hintText: S.of(context).name,
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).pleaseEnterYourName;
        }

        return null;
      },
    );
  }
}

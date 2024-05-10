import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/add_contact_form_field.dart';
import 'package:flutter/material.dart';

class AddContactFormFieldColumn extends StatelessWidget {
  const AddContactFormFieldColumn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: AddContactFormField(
              hintText: AppStrings.firstNameHintText,
              onChanged: (value) {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: AddContactFormField(
              hintText: AppStrings.lastNameHintText,
              onChanged: (value) {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: AddContactFormField(
              hintText: AppStrings.phoneHintText,
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
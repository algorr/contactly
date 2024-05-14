import 'package:contactly/core/widgets/custom_text_button.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactTopButtonRow extends StatelessWidget {
  const AddContactTopButtonRow({
    super.key,
    required this.rightButtonText,
    required this.rightButtonPressed,
    required this.rightButtonColor,
    required this.newContactTitle,
  });

  final String rightButtonText;
  final String newContactTitle;
  final VoidCallback rightButtonPressed;
  final Color rightButtonColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: AppStrings.cancelText,
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        CustomTextButton(
          onPressed: () {},
          text: newContactTitle,
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
        BlocBuilder<ContactCubit, ContactState>(
          builder: (context, state) {
            return CustomTextButton(
              onPressed: () => rightButtonPressed(),
              text: rightButtonText,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: rightButtonColor),
            );
          },
        ),
      ],
    );
  }
}

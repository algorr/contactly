import 'package:contactly/core/widgets/custom_text_button.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactTopButtonRow extends StatelessWidget {
  const ContactTopButtonRow({
    super.key,
    required this.rightButtonText,
    required this.rightButtonPressed,
    required this.rightButtonColor,
    required this.newContactTitle,
    this.user,
    required this.size,
  });

  final String rightButtonText;
  final String newContactTitle;
  final VoidCallback rightButtonPressed;
  final Color rightButtonColor;
  final User? user;
  final Size size;

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
            return context.read<ContactCubit>().isEditPressed == false
                ? CustomTextButton(
                    onPressed: () {
                      context.read<ContactCubit>().changeEditPressed();
                    },
                    text: rightButtonText,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: rightButtonColor),
                  )
                : CustomTextButton(
                    onPressed: () {
                      context.read<ServiceCubit>().updateUser(
                          context,
                          context
                              .read<ServiceCubit>()
                              .nameController
                              .text
                              .trim(),
                          context
                              .read<ServiceCubit>()
                              .lastNameController
                              .text
                              .trim(),
                          context
                              .read<ServiceCubit>()
                              .phoneController
                              .text
                              .trim(),
                          context.read<ServiceCubit>().imagePath,
                          user!.id!,
                          size);
                    },
                    text: AppStrings.doneText,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: ColorManager.grey),
                  );
          },
        ),
      ],
    );
  }
}

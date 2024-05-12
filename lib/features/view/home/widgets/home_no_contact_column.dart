import 'package:contactly/core/widgets/custom_text_button.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_sized_box.dart';
import '../../../../core/widgets/custom_text.dart';
import '../mixin/add_new_contact_mixin.dart';

class HomeNoContactColumn extends StatelessWidget with AddNewContactMixin {
  HomeNoContactColumn({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        return Column(
          children: [
            /// No Contacts Image

            Image.asset(AssetsManager.noContactImage),

            /// No Contacts Text
            CustomText(
              text: AppStrings.noContacts,
              fontWeight: FontWeight.bold,
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
            CustomSizedBox(
              size: size,
              heightParam: .01,
            ),

            /// No Contacts Text Appear Information
            CustomText(
                text: AppStrings.contactAppearHere,
                /* color: ColorManager.black,
                        fontSize: FontSize.s16, */
                style: Theme.of(context).textTheme.titleMedium!),
            CustomSizedBox(
              size: size,
              heightParam: .01,
            ),

            /// Create New Contact Text Button
            CustomTextButton(
              onPressed: () => addContactBottomSheet(
                  context, size, context.read<ContactCubit>().imagePicker),
              text: AppStrings.createContactButtonText,
              style: Theme.of(context).textTheme.bodySmall!,
            ),
          ],
        );
      },
    );
  }
}

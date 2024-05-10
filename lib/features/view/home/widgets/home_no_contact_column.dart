import 'package:contactly/core/widgets/custom_text_button.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/custom_sized_box.dart';
import '../../../../core/widgets/custom_text.dart';
import '../mixin/add_new_contact_mixin.dart';

class HomeNoContactColumn extends StatelessWidget with AddNewContactMixin {
  const HomeNoContactColumn(
      {super.key, required this.size, required this.picker});

  final Size size;
  final ImagePicker picker;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// No Contacts Image
        Image.asset(AssetsManager.noContactImage),

        /// No Contacts Text
        CustomText(
          text: AppStrings.noContacts,
          /*  color: ColorManager.black,
                  fontSize: FontSize.s25, */
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
          onPressed: () => addContactBottomSheet(context, size, picker),
          text: AppStrings.createContactButtonText,
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ],
    );
  }
}

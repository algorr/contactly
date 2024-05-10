import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_button.dart';
import '../../../resources/index.dart';

/// The `AddContactBottomSheetButtonsRow` class in Dart defines a row of custom text buttons for adding
/// contacts with different functionalities.
class AddContactBottomSheetButtonsRow extends StatelessWidget {
  const AddContactBottomSheetButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          onPressed: () {},
          text: AppStrings.cancelText,
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        CustomTextButton(
          onPressed: () {},
          text: AppStrings.newContactText,
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
        CustomTextButton(
          onPressed: () {},
          text: AppStrings.doneText,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: ColorManager.grey),
        ),
      ],
    );
  }
}

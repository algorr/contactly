import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onPressed: () {
            Navigator.pop(context);
          },
          text: AppStrings.cancelText,
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        CustomTextButton(
          onPressed: () {},
          text: AppStrings.newContactText,
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
        CustomTextButton(
          onPressed: () async {
            await context.read<ServiceCubit>().saveContact();

            Navigator.pop(context);
          },
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

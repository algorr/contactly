import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/add_contact_form_field_column.dart';
import 'package:flutter/material.dart';
import 'add_contact_bottom_sheet_buttons_row.dart';

/// The `AddContactMainContainer` class is a StatelessWidget in Dart that represents a container for
/// adding contacts with specific styling and child widgets.
class AddContactMainContainer extends StatelessWidget {
  const AddContactMainContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s18),
        border:
            Border.all(style: BorderStyle.none, color: ColorManager.primary),
      ),
      width: size.width,
      height: size.height,
      duration: const Duration(seconds: 1),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.p10),
            child: AddContactBottomSheetButtonsRow(),
          ),
          Image.asset(AssetsManager.bigBlankImage),
          SizedBox(
            height: size.height * 0.02,
          ),
          CustomText(
            text: AppStrings.addPhotoTitle,
            style: Theme.of(context).textTheme.headlineMedium!,
          ),
          AddContactFormFieldColumn(
            size: size,
          ),
          SizedBox(
            height: size.height * 0.02,
          )
        ],
      ),
    );
  }
}

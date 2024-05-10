import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../resources/index.dart';
import '../widgets/add_contact_main_container.dart';

mixin AddNewContactMixin {
  Future<dynamic> addContactBottomSheet(
      BuildContext context, Size size, ImagePicker imagePicker) {
    return showModalBottomSheet(
      backgroundColor: ColorManager.primary,
      useSafeArea: true,
      elevation: AppSize.s20,
      isScrollControlled: true,
      shape:
          OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s18)),
      context: context,
      builder: (context) {
        /// `return AddContactMainContainer(size: size);` is creating an instance of the
        /// `AddContactMainContainer` widget with the provided `size` parameter and returning it. This
        /// widget likely represents the main container for adding a new contact and is being displayed
        /// within the modal bottom sheet when the `addContactBottomSheet` function is called.
        return AddContactMainContainer(
          size: size,
        );
      },
    );
  }
}

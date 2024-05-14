import 'package:flutter/material.dart';
import '../../../resources/index.dart';
import '../widgets/add_contact/add_contact_main_container.dart';

mixin AddNewContactMixin {
  Future<dynamic> addContactBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      backgroundColor: ColorManager.primary,
      useSafeArea: true,
      elevation: AppSize.s20,
      isScrollControlled: true,
      shape:
          OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s18)),
      context: context,
      builder: (context) {
        return AddContactMainContainer(
          size: size,
        );
      },
    );
  }
}

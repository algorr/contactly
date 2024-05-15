import 'package:contactly/features/model/response_model.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/features/view/home/widgets/add_photo/add_photo_tab_view.dart';
import 'package:contactly/features/view/home/widgets/delete_contact/delete_sheet_column.dart';
import 'package:flutter/material.dart';

import '../../../resources/index.dart';

mixin DeleteContactMixin {
  Future<dynamic> deleteContactBottomSheet(
      BuildContext context, Size size, User user) {
    return showModalBottomSheet(
      backgroundColor: ColorManager.white,
      useSafeArea: true,
      elevation: 20,
      shape:
          OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s18)),
      context: context,
      builder: (context) {
        return AnimatedContainer(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s18),
              topRight: Radius.circular(AppSize.s18),
            ),
          ),
          width: size.width,
          height: size.height * .3,
          duration: const Duration(seconds: 1),
          child: DeleteSheetColumn(
            size: size,
            user: user,
          ),
        );
      },
    );
  }
}

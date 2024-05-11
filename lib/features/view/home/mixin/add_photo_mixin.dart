import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/add_photo_tab_view.dart';

mixin AddPhotoMixin {
  Future<dynamic> homeAddPhotoBottomSheet(
      BuildContext context, Size size, ImagePicker imagePicker) {
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
          height: size.height * .35,
          duration: const Duration(seconds: 1),
          child: BottomSheetTabView(
            size: size,
          ),
        );
      },
    );
  }
}

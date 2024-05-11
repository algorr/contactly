import 'package:contactly/features/view/home/widgets/clickable_row.dart';
import 'package:flutter/material.dart';
import '../../../resources/index.dart';

class AddPhotoSheetColumn extends StatelessWidget {
  const AddPhotoSheetColumn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
          child: Divider(
            thickness: 5,
            height: 10,
            indent: size.width * .4,
            endIndent: size.width * .4,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: size.height * .01,
            left: size.width * .03,
            right: size.width * .03,
          ),
          child: ClickableRow(
            onTap: () {
              // context.read<ScanCubit>().scanImageWithCamera(context);
            },
            style: Theme.of(context).textTheme.bodyLarge!,
            icon: Image.asset('assets/icons/ic_camera.png'),
            title: AppStrings.iconCamera,
            size: size,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .01,
              left: size.width * .03,
              right: size.width * .03),
          child: ClickableRow(
            onTap: () {
              //context.read<ScanCubit>().scanImageWithCropperGallery(context);
              Navigator.pop(context);
            },
            style: Theme.of(context).textTheme.bodyLarge!,
            icon: Image.asset('assets/icons/ic_gallery.png'),
            title: AppStrings.iconGallery,
            size: size,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .01,
              left: size.width * .03,
              right: size.width * .03),
          child: ClickableRow(
            onTap: () {
              /*   context
                  .read<ScanCubit>()
                  .ocrBottomSheet(context, size)
                  .then((value) => Navigator.pop(context)); */
            },
            title: 'Cancel',
            size: size,
            icon: null,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorManager.blue),
          ),
        ),
      ],
    );
  }
}

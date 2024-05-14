import 'package:contactly/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../../features/resources/index.dart';

mixin AppSnackBar {
  void showAppSnackBar(BuildContext context, Size size, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Row(
          children: [
            Image.asset('assets/icons/ic_tick.png'),
            SizedBox(
              width: size.width * 0.02,
            ),
            CustomText(
                text: message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: ColorManager.green))
          ],
        ),
      ),
    );
  }
}

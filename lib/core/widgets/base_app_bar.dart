import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final VoidCallback onPressed;

  const BaseAppBar({
    super.key,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
          text: AppStrings.appBarText,
          style: Theme.of(context).textTheme.bodyLarge!),
      centerTitle: false,
      actions: [
        /// Add New Contact Button
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.add_circle_outlined,
            color: ColorManager.blue,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

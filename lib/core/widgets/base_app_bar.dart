import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size size;
  final VoidCallback onPressed;

  BaseAppBar({
    Key? key,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: size.width * .3,

      /// Contacts Logo Image
      leading: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p10),
        child: Image.asset(
          AssetsManager.imgContacts,
        ),
      ),
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

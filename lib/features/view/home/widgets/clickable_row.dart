import 'package:flutter/material.dart';
import '../../../resources/index.dart';

class ClickableRow extends StatelessWidget {
  const ClickableRow(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      required this.size,
      this.imageIcon,
      required this.style});
  final VoidCallback onTap;
  final Widget? icon;
  final ImageIcon? imageIcon;
  final String title;
  final Size size;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Container(
          height: size.height * .06,
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(AppSize.s16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon ?? imageIcon,
              ),
              SizedBox(
                width: size.width * .02,
              ),
              Text(
                title,
                style: style,
              )
            ],
          ),
        ),
      ),
    );
  }
}

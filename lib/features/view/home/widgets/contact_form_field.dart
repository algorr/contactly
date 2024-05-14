import 'package:flutter/material.dart';
import '../../../resources/index.dart';

class ContactFormField extends StatelessWidget {
  const ContactFormField(
      {super.key,
      required this.hintText,
      this.onChanged,
      required this.controller,
      this.label});

  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: ColorManager.black,
      cursorHeight: AppSize.s20,
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        filled: true,
        fillColor: ColorManager.primary,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: ColorManager.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s15)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s15)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s15)),
      ),
    );
  }
}

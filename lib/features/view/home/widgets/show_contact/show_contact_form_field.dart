import 'package:contactly/core/extensions/string_capitalize.dart';
import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../resources/index.dart';

class ShowContactFormField extends StatelessWidget {
  const ShowContactFormField(
      {super.key,
      this.onChanged,
      required this.controller,
      required this.label});
  final String label;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return state is ChangedEditPressed
            ? TextFormField(
                controller: controller,
                onChanged: onChanged,
                cursorColor: ColorManager.black,
                cursorHeight: AppSize.s20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: context.read<ContactCubit>().isEditPressed == false
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.black))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s15)),
                  label: CustomText(
                      text: label.capitalize(),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold)),
                  focusedBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                  enabledBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                  disabledBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                ),
              )
            : TextFormField(
                controller: controller,
                onChanged: onChanged,
                cursorColor: ColorManager.black,
                cursorHeight: AppSize.s20,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: context.read<ContactCubit>().isEditPressed == false
                      ? UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.black))
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s15)),
                  label: CustomText(
                      text: label.capitalize(),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold)),
                  focusedBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                  enabledBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                  disabledBorder:
                      context.read<ContactCubit>().isEditPressed == false
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.black))
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s15)),
                ),
              );
      },
    );
  }
}

import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/resources/index.dart';

/// The CustomTextFormField class is a custom text form field widget in Dart that allows for
/// customization of prefix icon, hint text, label text, prefix icon color, and onChanged callback.
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.labelText,
    this.prefixIconColor,
    this.onChanged,
  });

  final Icon? prefixIcon;
  final String hintText;
  final String? labelText;
  final Color? prefixIconColor;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ServiceCubit>().searchController,
      cursorColor: ColorManager.black,
      //cursorHeight: AppSize.s20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 25),
        border: InputBorder.none,
        prefixIcon: Icon(
          IconManager.homeSearchIcon,
          color: ColorManager.grey,
        ),
        hintText: AppStrings.searchBarHintText,
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      onChanged: onChanged,
    );
  }
}

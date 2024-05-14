import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/model/response_model.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/index.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../mixin/index.dart';

class ShowContactFormColumn extends StatelessWidget with DeleteContactMixin {
  const ShowContactFormColumn({
    super.key,
    required this.size,
    required this.user,
  });

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: ShowContactFormField(
              controller: context.read<ServiceCubit>().nameController,
              label: user.firstName ?? '',
              onChanged: (value) {
                print('Name : $value');
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: ShowContactFormField(
              label: user.lastName ?? '',
              onChanged: (value) {
                print('lastname : $value');
              },
              controller: context.read<ServiceCubit>().lastNameController,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: SizedBox(
            height: size.height * .05,
            child: ShowContactFormField(
              label: user.phoneNumber ?? '',
              onChanged: (value) {
                print('phone :$value');
              },
              controller: context.read<ServiceCubit>().phoneController,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(AppMargin.m16),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    //await context.read<ServiceCubit>().deleteUser(user.id!);
                    deleteContactBottomSheet(context, size, user);
                  },
                  child: CustomText(
                      text: AppStrings.deleteContactText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.red,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )),
      ],
    );
  }
}

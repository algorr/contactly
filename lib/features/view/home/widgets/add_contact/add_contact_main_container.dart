import 'dart:io';
import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import '../../mixin/add_photo_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactMainContainer extends StatelessWidget with AddPhotoMixin {
  const AddContactMainContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s18),
            border: Border.all(
                style: BorderStyle.none, color: ColorManager.primary),
          ),
          width: size.width,
          height: size.height,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),

                /// Add Contact Bottom Sheet Top of Screen's Buttons Row
                child: AddContactTopButtonRow(
                  rightButtonText: AppStrings.doneText,
                  rightButtonPressed: () async {
                    print('Kayıta basıldı');

                    await context
                        .read<ServiceCubit>()
                        .saveContact(context, size);
                  },
                  rightButtonColor: ColorManager.grey,
                  newContactTitle: AppStrings.newContactText,
                ),
              ),
              InkWell(
                onTap: () => homeAddPhotoBottomSheet(
                    context, size, context.read<ContactCubit>().imagePicker),
                child: state is PhotoAddedSuccess
                    ? Builder(
                        builder: (context) {
                          context.read<ServiceCubit>().imagePath =
                              state.photoUrl;

                          return CircleAvatar(
                            radius: size.height * 0.1,
                            backgroundImage: FileImage(File(state.photoUrl)),
                          );
                        },
                      )
                    : Image.asset(AssetsManager.bigBlankImage),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomText(
                text: AppStrings.addPhotoTitle,
                style: Theme.of(context).textTheme.headlineMedium!,
              ),
              ContactFormColumn(
                size: size,
              ),
              SizedBox(
                height: size.height * 0.02,
              )
            ],
          ),
        );
      },
    );
  }
}

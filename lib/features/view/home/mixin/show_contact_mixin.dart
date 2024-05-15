import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ShowContactMixin {
  Future<dynamic> showContactBottomSheet(
      BuildContext context, Size size, User user) {
    return showModalBottomSheet(
      backgroundColor: ColorManager.primary,
      useSafeArea: true,
      elevation: AppSize.s20,
      isScrollControlled: true,
      shape:
          OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s18)),
      context: context,
      builder: (context) {
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

                    /// Show Contact Bottom Sheet Top of Screen's Buttons Row
                    child: ContactTopButtonRow(
                      rightButtonText: AppStrings.rightButtonText,
                      rightButtonPressed: () {},
                      rightButtonColor: ColorManager.blue,
                      newContactTitle: '',
                      user: user,
                      size: size,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final image = await context
                          .read<ContactCubit>()
                          .pickImageWithGallery(context);
                      context.read<ServiceCubit>().imagePath = image!;
                    },
                    child: CircleAvatar(
                      radius: size.height * 0.1,
                      backgroundImage: NetworkImage(user.profileImageUrl!),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomText(
                    text: AppStrings.changePhotoText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  ShowContactFormColumn(
                    size: size,
                    user: user,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

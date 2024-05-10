import 'package:contactly/core/widgets/custom_sized_box.dart';
import 'package:contactly/core/widgets/custom_text.dart';
import 'package:contactly/core/widgets/custom_text_button.dart';
import 'package:contactly/core/widgets/custom_text_form_field.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
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
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outlined,
              color: ColorManager.blue,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * .02),
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                  elevation: AppSize.s5,
                  shadowColor: ColorManager.grey,
                  color: ColorManager.white,

                  /// Search Bar
                  child: CustomTextFormField(
                    hintText: AppStrings.searchBarHintText,
                    prefixIcon: Icon(
                      IconManager.homeSearchIcon,
                      color: ColorManager.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .3,
            ),
            Column(
              children: [
                /// No Contacts Image
                Image.asset(AssetsManager.noContactImage),

                /// No Contacts Text
                CustomText(
                  text: AppStrings.noContacts,
                  color: ColorManager.black,
                  fontSize: FontSize.s25,
                  fontWeight: FontWeight.bold,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                CustomSizedBox(
                  size: size,
                  heightParam: .01,
                ),

                /// No Contacts Text Appear Information
                CustomText(
                    text: AppStrings.contactAppearHere,
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                    style: Theme.of(context).textTheme.titleMedium!),
                CustomSizedBox(
                  size: size,
                  heightParam: .01,
                ),

                /// Create New Contact Text Button
                CustomTextButton(
                  onPressed: () {},
                  text: AppStrings.createContactButtonText,
                  color: ColorManager.blue,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

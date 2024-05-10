import 'package:contactly/core/widgets/base_app_bar.dart';
import 'package:contactly/core/widgets/custom_text_form_field.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/home_no_contact_column.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'mixin/add_new_contact_mixin.dart';

class HomeView extends StatelessWidget with AddNewContactMixin {
  HomeView({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.primary,

      /// The `appBar: BaseAppBar(size: size, onPressed: () {}),` in the `Scaffold` of the `HomeView`
      /// widget is setting the app bar for the screen.
      appBar: BaseAppBar(
        size: size,
        onPressed: () {},
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

                  /// This part of the code is creating a `CustomTextFormField` widget with a hint text
                  /// and a prefix icon.
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

            /// The `HomeNoContactColumn` widget is being used in the `HomeView` to display a column of
            /// UI elements related to the scenario where there are no contacts available.
            HomeNoContactColumn(
              size: size,
              picker: _picker,
            ),
          ],
        ),
      ),
    );
  }
}

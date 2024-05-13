import 'package:contactly/core/widgets/base_app_bar.dart';
import 'package:contactly/core/widgets/custom_text_form_field.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/widgets/home_no_contact_column.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mixin/add_new_contact_mixin.dart';
import 'mixin/contact_list_text_mixin.dart';
import 'widgets/contact_list_item_text.dart';

class HomeView extends StatelessWidget
    with AddNewContactMixin, ContactListTextMixin {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        print('Homeview build anında state : $state');

        return Scaffold(
          backgroundColor: ColorManager.primary,

          /// The `appBar: BaseAppBar(size: size, onPressed: () {}),` in the `Scaffold` of the `HomeView`
          /// widget is setting the app bar for the screen.
          appBar: BaseAppBar(
            size: size,
            onPressed: () => addContactBottomSheet(
                context, size, context.read<ContactCubit>().imagePicker),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                    width: size.width,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * .02),
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
                    height: size.height * .01,
                  ),
                  state is FetchContactsSuccess
                      ? SizedBox(
                          height: size.height * .7,
                          child: ListView.builder(
                              itemCount: state.contactList?.length,
                              itemBuilder: (context, index) {
                                print(
                                    'Gelen Image Url : ${state.contactList![index].profileImageUrl}');
                                print(
                                    'Gelen Name : ${state.contactList![index].firstName}');
                                print(
                                    'Gelen lastname : ${state.contactList![index].lastName}');

                                // /data/user/0/com.appoint.co.contactly/cache/scaled_text.png
                                return InkWell(
                                  onTap: () async {
                                    await context
                                        .read<ServiceCubit>()
                                        .deleteUser(
                                            state.contactList![index].id!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppMargin.m20,
                                        vertical: AppMargin.m10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: ColorManager.white),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: /* FileImage(
                                            File(state.contactList?[index]
                                                    .profileImageUrl ??
                                                ''),
                                          ) */
                                              NetworkImage(state
                                                  .contactList![index]
                                                  .profileImageUrl!),
                                        ),
                                        title: ContactListItemText(
                                          text:
                                              '${state.contactList?[index].firstName} ${state.contactList?[index].lastName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!,
                                        ),
                                        subtitle: Text(state.contactList?[index]
                                                .phoneNumber ??
                                            ''),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      :

                      /// The `HomeNoContactColumn` widget is being used in the `HomeView` to display a column of
                      /// UI elements related to the scenario where there are no contacts available.
                      Padding(
                          padding: EdgeInsets.only(top: size.height * .3),
                          child: HomeNoContactColumn(
                            size: size,
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

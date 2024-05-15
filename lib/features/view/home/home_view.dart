import 'package:contactly/core/widgets/base_app_bar.dart';
import 'package:contactly/core/widgets/custom_text_form_field.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/view/home/mixin/index.dart';
import 'package:contactly/features/view/home/widgets/home_no_contact_column.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/contact_list_item_text.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AddNewContactMixin, ContactListTextMixin, ShowContactMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        print('Homeview build anında state : $state');
        print(
            'Build anında filtered : ${context.read<ServiceCubit>().filteredUsers.length}');

        if (state is FetchContactsSuccess) {
          return Scaffold(
            backgroundColor: ColorManager.primary,

            /// The `appBar: BaseAppBar(size: size, onPressed: () {}),` in the `Scaffold` of the `HomeView`
            /// widget is setting the app bar for the screen.
            appBar: BaseAppBar(
              size: size,
              onPressed: () => addContactBottomSheet(
                context,
                size,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                      width: size.width,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.height * .02),
                        child: PhysicalModel(
                          borderRadius: BorderRadius.circular(AppSize.s15),
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
                            onChanged: (value) {
                              setState(() {
                                context
                                    .read<ServiceCubit>()
                                    .filterUsers(value, state.contactList!);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    SizedBox(
                      height: size.height * .8,
                      child: ListView.builder(
                        itemCount:
                            context.read<ServiceCubit>().filteredUsers.length,
                        itemBuilder: (context, index) {
                          print(
                              'listview builder filtered : ${context.read<ServiceCubit>().filteredUsers?.length}');
                          final user =
                              context.read<ServiceCubit>().filteredUsers[index];
                          return InkWell(
                            onTap: () async {
                              await showContactBottomSheet(
                                  context, size, state.contactList![index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppMargin.m20,
                                  vertical: AppMargin.m10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorManager.white),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        user?.profileImageUrl ?? ''),
                                  ),
                                  title: ContactListItemText(
                                    text:
                                        '${user?.firstName} ${user?.lastName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!,
                                  ),
                                  subtitle: Text(user?.phoneNumber ?? ''),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is FetchContactsSuccess && state.contactList == null ||
            state is ServiceInitial) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            appBar: BaseAppBar(
              size: size,
              onPressed: () => addContactBottomSheet(
                context,
                size,
              ),
            ),
            body: SingleChildScrollView(
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
                        shadowColor: ColorManager.grey,
                        color: ColorManager.white,
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
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .3),
                    child: HomeNoContactColumn(
                      size: size,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is LoadingState) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            appBar: BaseAppBar(
              size: size,
              onPressed: () => addContactBottomSheet(
                context,
                size,
              ),
            ),
            body: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: ColorManager.black,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

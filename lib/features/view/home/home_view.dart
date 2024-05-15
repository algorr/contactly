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
  const HomeView({super.key});

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
                      child: _fetchContactList(context, size, state),
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

  /// This function creates a ListView of contact items with user information and a clickable behavior to
  /// show a bottom sheet with more details.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter in Flutter represents the build context of the
  /// widget that is currently being built. It provides access to various properties and methods related
  /// to the widget tree, such as accessing inherited widgets, theme data, media queries, and more.
  ///   size (Size): The `size` parameter in the `_fetchContactList` function represents the size of the
  /// parent widget or the available space in which the `ListView` will be rendered. It is typically used
  /// to adjust the layout and appearance of the `ListView` based on the available space.
  ///   state (FetchContactsSuccess): The `state` parameter in the `_fetchContactList` function is of
  /// type `FetchContactsSuccess`. It seems to represent the state of fetching contacts successfully.
  /// This state likely contains information about the contact list that was fetched successfully, such
  /// as the list of contacts or any other relevant data related to the
  ///
  /// Returns:
  ///   A ListView widget is being returned with a builder that generates a list of contacts. Each
  /// contact item in the list is represented by a ListTile inside a Container with a CircleAvatar for
  /// the profile image, ContactListItemText for the name, and a Text widget for the phone number.
  /// Tapping on a contact item will show a contact bottom sheet.
  ListView _fetchContactList(
      BuildContext context, Size size, FetchContactsSuccess state) {
    return ListView.builder(
      itemCount: context.read<ServiceCubit>().filteredUsers.length,
      itemBuilder: (context, index) {
        final user = context.read<ServiceCubit>().filteredUsers[index];
        return InkWell(
          onTap: () async {
            await showContactBottomSheet(
                context, size, state.contactList![index]);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.m20, vertical: AppMargin.m10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.white),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImageUrl ?? ''),
                ),
                title: ContactListItemText(
                  text: '${user.firstName} ${user.lastName}',
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                subtitle: Text(user.phoneNumber ?? ''),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:contactly/domain/service/api/next_api_service.dart';
import 'package:contactly/domain/service/cache/hive_local_service.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:contactly/features/viewmodel/contact/cubit/contact_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/mixins/index.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> with AppSnackBar {
  ServiceCubit() : super(ServiceInitial());

  /// API Service
  final NexApiService _service = NexApiService();

  /// Hive Service Cache
  final HiveLocalService _hiveLocalService = HiveLocalService();

  /// Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  /// Filtered Users
  List<User> filteredUsers = [];

  /// Search Query
  String search = '';

  /// Image Path for Contact
  String imagePath = '';

  /// Image Url for Contact
  List<String>? imageUrl = [];

  /// The `serviceInit` function initializes Hive, fetches contacts from local storage and a remote
  /// service, and emits corresponding states in a Flutter application.
  Future<void> serviceInit() async {
    try {
      await Hive.initFlutter();
      await _hiveLocalService.init();
      emit(LoadingState());
      final storagedContacts = await _hiveLocalService.fetchAllContacts();
      if (storagedContacts!.isNotEmpty) {
        emit(FetchLocalContactsSuccess(contactList: storagedContacts));
      }

      final contactList = await _service.fetchContacts();

      filteredUsers = contactList!;

      emit(FetchContactsSuccess(contactList: contactList));
    } catch (e) {
      emit(ServiceInitial());
    }
  }

  /// The `filterUsers` function filters a list of users based on a search query and emits a success
  /// event with the filtered user list.
  ///
  /// Args:
  ///   query (String): The `query` parameter is a string that represents the search query entered by
  /// the user to filter the list of users.
  ///   users (List<User>): The `users` parameter in the `filterUsers` function is a list of `User`
  /// objects. It contains the list of users that need to be filtered based on the provided query
  /// string.
  ///
  /// Returns:
  ///   The `filterUsers` function returns a list of `User` objects that match the search query
  /// provided. If the query is empty, it returns the original list of users. If the query is not empty,
  /// it filters the list of users based on whether the first name or last name of each user contains
  /// the search query (case-insensitive) and returns the filtered list.
  void filterUsers(String query, List<User> users) {
    if (query.isEmpty) {
      filteredUsers = users;
      emit(FetchContactsSuccess(contactList: filteredUsers));
    } else {
      filteredUsers = users.where((user) {
        final firstName = user.firstName?.toLowerCase() ?? '';
        final lastName = user.lastName?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return firstName.contains(searchQuery) ||
            lastName.contains(searchQuery);
      }).toList();
      emit(FetchContactsSuccess(contactList: filteredUsers));
    }
  }

  /// This Dart function fetches all contacts, updates the state based on the fetched data, and returns a
  /// Future of a list of users.
  ///
  /// Returns:
  ///   The `fetchAllContacts` function is returning a `Future` that resolves to a `List` of `User`
  /// objects or `null`.
  Future<List<User>?> fetchAllContacts() async {
    try {
      final contactList = await _service.fetchContacts();

      filteredUsers = contactList!;
      if (contactList.isNotEmpty) {
        emit(FetchContactsSuccess(contactList: contactList));
      } else {
        emit(ServiceInitial());
      }
    } catch (e) {
      emit(ServiceInitial());
    }
    return null;
  }

  /// The function `uploadImage` asynchronously uploads an image file and returns the uploaded image's
  /// URL.
  ///
  /// Args:
  ///   image (String): The `image` parameter in the `uploadImage` function is a String that represents
  /// the file path or URL of the image that you want to upload.
  ///
  /// Returns:
  ///   A `Future<String?>` is being returned.
  Future<String?> uploadImage(String image) async {
    final lastImage = await _service.uploadContactImage(File(image));
    return lastImage;
  }

  /// The `saveContact` function in Dart saves a contact with user input data and an image, updates the
  /// contact list, shows a success message, and handles errors.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` parameter in the `saveContact` function is used to
  /// provide access to the context of the widget where the function is being called. This context can
  /// be used to access various properties of the widget tree, such as navigating to a new screen,
  /// showing dialogs, accessing theme data, etc
  ///   size (Size): The `size` parameter in the `saveContact` function is of type `Size`. It is likely
  /// used to pass the size information to the function for any necessary calculations or UI adjustments
  /// based on the size of the screen or a specific widget. The `Size` class in Flutter represents a 2
  Future<void> saveContact(BuildContext context, Size size) async {
    try {
      emit(LoadingState());
      final image = await _service.saveContact(
          nameController.text.trim(),
          lastNameController.text.trim(),
          phoneController.text.trim(),
          imagePath);

      await writeLocalStorage(nameController.text, lastNameController.text,
          phoneController.text, image!);

      final contactList = await fetchAllContacts();

      clearControllers();
      if (context.mounted) {
        showAppSnackBar(context, size, AppStrings.addedUser);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }

      emit(FetchContactsSuccess(contactList: contactList));

      //clearControllers();
    } catch (e) {
      emit(ServiceErrorState(message: e.toString()));
    }
  }

  void clearControllers() {
    nameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    imagePath = '';
  }

  /// This function deletes a user, handles loading state, pops the current screen, deletes the user
  /// from a service, deletes a contact from local storage, fetches all contacts, shows a snack bar
  /// message, and updates the UI accordingly.
  ///
  /// Args:
  ///   id (String): The `id` parameter in the `deleteUser` function is typically a unique identifier
  /// that is used to specify which user should be deleted from the system. It could be a user ID,
  /// username, or any other identifier that uniquely identifies the user to be deleted.
  ///   context (BuildContext): The `context` parameter in the `deleteUser` function refers to the
  /// `BuildContext` object. It is typically used in Flutter to provide information about the location
  /// of a widget within the widget tree and to access various services provided by the Flutter
  /// framework. In this function, the `context` parameter is
  ///   size (Size): The `size` parameter in the `deleteUser` function is of type `Size`. It is likely
  /// used to pass the size information to the function for handling UI elements or layouts within the
  /// context of the operation being performed. The `Size` class in Flutter represents a 2D size with
  /// width
  /// Delete func for contact via
  Future<void> deleteUser(String id, BuildContext context, Size size) async {
    try {
      emit(LoadingState());
      if (context.mounted) {
        Navigator.pop(context);
      }
      await _service.deleteUser(id, context, size);

      //await _hiveLocalService.deleteContact();
      await _hiveLocalService.deleteContact();
      final contactList = await fetchAllContacts();
      showAppSnackBar(context, size, AppStrings.deleteContactText);

      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
        //showAppSnackBar(context, size, AppStrings.deleteContactText);
      }
    } catch (e) {
      emit(ServiceErrorState(message: e.toString()));
    }
  }

  /// This Dart function updates user information and handles error states.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` parameter is used to provide the current build
  /// context of the widget. It is typically used to access information about the widget's location in
  /// the widget tree and to navigate to other screens or show dialogs within the app.
  ///   firstName (String): The `firstName` parameter in the `updateUser` function represents the first
  /// name of the user that you want to update in the system. It is a `String` type parameter that holds
  /// the new first name value for the user.
  ///   lastName (String): The `lastName` parameter in the `updateUser` function represents the last
  /// name of the user that you want to update in the system. It is a string type parameter that holds
  /// the last name information of the user.
  ///   phoneNumber (String): The `phoneNumber` parameter in the `updateUser` function represents the
  /// phone number of the user that you want to update in the system. It is a string type parameter that
  /// holds the new phone number value that you want to assign to the user.
  ///   profileImageUrl (String): The `profileImageUrl` parameter in the `updateUser` function
  /// represents the URL of the user's profile image. This URL is used to update the user's profile
  /// image in the system when the `updateUser` function is called.
  ///   userId (String): The `userId` parameter in the `updateUser` function represents the unique
  /// identifier of the user whose information is being updated. This identifier is used to locate the
  /// specific user in the database and update their details accordingly.
  ///   size (Size): The `Size` parameter in the `updateUser` method represents the size of the context
  /// in which the update operation is being performed. It is typically used for UI-related operations,
  /// such as determining the size of a widget or screen.
  Future<void> updateUser(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String profileImageUrl,
      String userId,
      Size size) async {
    try {
      emit(LoadingState());
      await _service.updateUser(
          context, firstName, lastName, phoneNumber, profileImageUrl, userId);
      context.read<ContactCubit>().isEditPressed = false;
      await _hiveLocalService.updateContact(
          firstName, lastName, phoneNumber, profileImageUrl);
      final contactList = await fetchAllContacts();
      if (context.mounted) {
        showAppSnackBar(context, size, AppStrings.updateUser);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
      }
    } catch (e) {
      emit(ServiceErrorState(message: e.toString()));
    }
  }

  /// The function `writeLocalStorage` writes contact information to local storage using Hive in Dart.
  ///
  /// Args:
  ///   firstName (String): The `firstName` parameter in the `writeLocalStorage` function represents the
  /// first name of a contact that you want to store in the local storage.
  ///   lastName (String): The `lastName` parameter in the `writeLocalStorage` function represents the
  /// last name of a contact that is being stored in local storage.
  ///   phoneNumber (String): The `phoneNumber` parameter in the `writeLocalStorage` function is a
  /// `String` type, which represents the phone number of the contact being saved to the local storage.
  ///   profileImageUrl (String): The `profileImageUrl` parameter in the `writeLocalStorage` function is
  /// a string that represents the URL or path to the profile image of the contact being added to the
  /// local storage. This image can be used to display the contact's profile picture in the application
  /// interface.
  Future<void> writeLocalStorage(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    try {
      _hiveLocalService.addContact(
          firstName, lastName, phoneNumber, profileImageUrl);
    } catch (e) {
      emit(ServiceErrorState(message: e.toString()));
    }
  }

  /// The function `fetchLocalContacts` retrieves a list of local contacts using Hive storage and
  /// returns it as a Future.
  ///
  /// Returns:
  ///   A `Future<List<User>?>` is being returned. The function `fetchLocalContacts` is an asynchronous
  /// function that returns a Future. The Future will eventually resolve to a List of User objects or
  /// null.
  Future<List<User>?> fetchLocalContacts() async {
    try {
      final users = await _hiveLocalService.fetchAllContacts();

      if (users != null) {
        return users;
      }
      {}
    } catch (e) {
      emit(ServiceErrorState(message: e.toString()));
    }
    return null;
  }
}

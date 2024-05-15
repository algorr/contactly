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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<User> filteredUsers = [];

  final TextEditingController searchController = TextEditingController();
  String search = '';

  String imagePath = '';
  List<String>? imageUrl = [];

  Future<void> serviceInit() async {
    try {
      await Hive.initFlutter();
      await _hiveLocalService.init();
      emit(LoadingState());
      final storagedContacts = await _hiveLocalService.fetchAllContacts();
      print('Localdeki users length : ${storagedContacts?.length}');
      if (storagedContacts!.isNotEmpty) {
        print(
            'Kullanıcılar localden başarıyla getirildi : ${storagedContacts.length}');
        emit(FetchContactsSuccess(contactList: storagedContacts));
      }

      await Future.delayed(Duration(seconds: 10));

      final contactList = await _service.fetchContacts();
      filteredUsers = contactList!;
      print('Filterde user initial : ${filteredUsers.length}');

      emit(FetchContactsSuccess(contactList: contactList));
      print('Burası var mı?');
    } catch (e) {
      print('Bir hata oluştu: $e');
      emit(ServiceInitial());
    }
  }

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

  Future<List<User>?> fetchAllContacts() async {
    try {
      final contactList = await _service.fetchContacts();

      filteredUsers = contactList!;
      print('Fetched de filteredusers : ${filteredUsers.length}');
      if (contactList.isNotEmpty) {
        print('Fetched users length : ${contactList.isEmpty}');

        emit(FetchContactsSuccess(contactList: contactList));
      } else {
        print('Initial çalıştı mı?');
        emit(ServiceInitial());
      }
    } catch (e) {
      print('Catch çalıştı mı?');
      emit(ServiceInitial());
    }
  }

  Future<String?> uploadImage(String image) async {
    final lastImage = await _service.uploadContactImage(File(image));
    return lastImage;
  }

  Future<void> saveContact(BuildContext context, Size size) async {
    try {
      emit(LoadingState());
      final image = await _service.saveContact(
          nameController.text.trim(),
          lastNameController.text.trim(),
          phoneController.text.trim(),
          imagePath);
      print('Save Contact da image : $imagePath');

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
    } catch (e) {}
  }

  void clearControllers() {
    nameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    imagePath = '';
  }

  Future<void> deleteUser(String id, BuildContext context, Size size) async {
    try {
      emit(LoadingState());
      if (context.mounted) {
        Navigator.pop(context);
      }
      await _service.deleteUser(id, context, size);
      //await _hiveLocalService.deleteContact();

      final contactList = await fetchAllContacts();
      showAppSnackBar(context, size, AppStrings.accountDeleted);
      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
        //showAppSnackBar(context, size, AppStrings.deleteContactText);
      }
    } catch (e) {}
  }

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
    } catch (e) {}
  }

  Future<void> writeLocalStorage(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    try {
      _hiveLocalService.addContact(
          firstName, lastName, phoneNumber, profileImageUrl);
    } catch (e) {}
  }

  Future<List<User>?> fetchLocalContacts() async {
    try {
      final users = await _hiveLocalService.fetchAllContacts();

      if (users != null) {
        print('Kullanıcılar localden başarıyla getirildi');
        print('Users : ${users.length}');
        return users;
      }
      {}
    } catch (e) {}
    return null;
  }
}

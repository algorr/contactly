import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:contactly/domain/service/api/next_api_service.dart';
import 'package:contactly/features/model/response_model.dart';
import 'package:contactly/features/resources/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/mixins/index.dart';
import '../../../../core/widgets/custom_text.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> with AppSnackBar {
  ServiceCubit() : super(ServiceInitial());
  final NexApiService _service = NexApiService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String imagePath = '';
  List<String>? imageUrl = [];

  Future<List<User>?> fetchAllContacts() async {
    final contactList = await _service.fetchContacts();
    print('Users : ${contactList?.length}');
    emit(FetchContactsSuccess(contactList: contactList));
    //print('Users : ${contactList?[0].id}');
    /* if (contactList != null) {
      emit(FetchContactsSuccess(contactList: contactList));
    } else {
      emit(ServiceInitial());
    } */
  }

  Future<String?> uploadImage(String image) async {
    final lastImage = await _service.uploadContactImage(File(image));
    return lastImage;
  }

  Future<void> saveContact(BuildContext context, Size size) async {
    try {
      emit(LoadingState());
      await _service.saveContact(
          nameController.text.trim(),
          lastNameController.text.trim(),
          phoneController.text.trim(),
          imagePath);

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
      await _service.deleteUser(id, context);

      final contactList = await fetchAllContacts();

      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
        showAppSnackBar(context, size, AppStrings.deleteContactText);
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

      final contactList = await fetchAllContacts();
      if (context.mounted) {
        showAppSnackBar(context, size, AppStrings.addedUser);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
      }
    } catch (e) {}
  }
}

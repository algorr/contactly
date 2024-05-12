import 'package:bloc/bloc.dart';
import 'package:contactly/domain/service/api/next_api_service.dart';
import 'package:contactly/features/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  final NexApiService _service = NexApiService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String imagePath = '';

  Future<List<User>?> fetchAllContacts() async {
    final contactList = await _service.fetchContacts();

    emit(FetchContactsSuccess(contactList: contactList));

    return null;
  }

  Future<void> saveContact() async {
    try {
      await _service.saveContact(
          nameController.text.trim(),
          lastNameController.text.trim(),
          phoneController.text.trim(),
          imagePath);
      await _service.uploadContactImage(imagePath);
      emit(AddedContactSuccess());
      clearControllers();
      final contactList = await fetchAllContacts();
      emit(FetchContactsSuccess(contactList: contactList));
    } catch (e) {}
  }

  void clearControllers() {
    nameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    imagePath = '';
  }

  Future<void> deleteUser(String id) async {
    try {
      emit(LoadingState());
      await _service.deleteUser(id);
      emit(DeletedUserSuccess());
      final contactList = await fetchAllContacts();
      if (contactList != null) {
        emit(FetchContactsSuccess(contactList: contactList));
      }
    } catch (e) {}
  }

  Future init() async {}
}

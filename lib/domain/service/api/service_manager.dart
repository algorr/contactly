import 'dart:io';
import '../../../features/model/response_model.dart';

abstract class ServiceManager {
  Future<List<User>?> fetchContacts();
  Future<void> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl);
  Future<String?> uploadContactImage(File imageFile);
  Future<void> deleteUser(String userId);
  Future<void> updateUser(int index);
}

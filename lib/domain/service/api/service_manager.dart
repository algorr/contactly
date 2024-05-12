import 'package:contactly/features/model/user_model.dart';

abstract class ServiceManager {
  Future<List<User>?> fetchContacts();
  Future<void> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl);
  Future<void> uploadContactImage(String profileImageUrl);
  Future<void> deleteUser(String userId);
  Future<void> updateUser(int index);
}

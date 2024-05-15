import 'package:contactly/features/model/user.dart';

abstract class CacheManager {
  Future<void> init();
  void addContact(String firstName, String lastName, String phoneNumber,
      String profileImageUrl);
  Future<void> deleteContact();
  Future<List<User>?> fetchAllContacts();
  Future<void> updateContact(
    String firstName,
    String lastName,
    String phoneNumber,
    String profileImageUrl,
  );
}

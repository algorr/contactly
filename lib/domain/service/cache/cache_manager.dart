import 'package:contactly/features/model/contact_model.dart';

abstract class CacheManager {
  Future<void> init();
  void addContact(String name, String lastName, String phone, String photoUrl);
  Future<void> removeContact(int index);
  Future<List<ContactModel>> fetchAllFiles();
}

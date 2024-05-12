import 'package:contactly/domain/service/cache/cache_manager.dart';
import 'package:contactly/features/model/contact_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class HiveLocalService extends CacheManager {
  late final Box<ContactModel> _box;
  @override
  Future<void> init() async {
    Hive.registerAdapter(ContactModelAdapter());
    _box = Hive.box<ContactModel>('contacts');
    print('Box : ${_box.isOpen}');
  }

  @override
  void addContact(String name, String lastName, String phone, String photoUrl) {
    _box.add(ContactModel(
        name: name, lastName: lastName, phone: phone, photoUrl: photoUrl));
    print('Başarıyla eklendi : $name');
  }

  @override
  Future<List<ContactModel>> fetchAllFiles() async {
    final contactList = _box.values.toList();
    //return Future.value(contactList);
    return contactList;
  }

  @override
  Future<void> removeContact(int index) async {
    await _box.deleteAt(index);
  }
}

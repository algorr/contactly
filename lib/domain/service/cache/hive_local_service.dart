import 'package:contactly/domain/service/cache/cache_manager.dart';
import 'package:contactly/features/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class HiveLocalService extends CacheManager {
  late final Box<User> _box;

  @override
  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _box = await Hive.openBox<User>('contacts');
    print('Box : ${_box.isOpen}');
  }

  @override
  void addContact(String firstName, String lastName, String phoneNumber,
      String profileImageUrl) {
    _box.add(
      User(
        id: '',
        createdAt: DateTime.now(),
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profileImageUrl: profileImageUrl,
      ),
    );
    print('User added to local : ${_box.getAt(0)}}');
  }

  @override
  Future<void> deleteContact() async {
    await _box.deleteFromDisk();
  }

  @override
  Future<List<User>?> fetchAllContacts() async {
    final userList = await _box.values.toList();
    //print('User fetched from local : ${userList[0].firstName}');
    return userList;
  }

  @override
  Future<void> updateContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    var userIndex = _box.values
        .toList()
        .indexWhere((element) => element.firstName == firstName);
    if (userIndex != -1) {
      var user = _box.getAt(userIndex);
      user?.firstName = firstName;
      user?.lastName = lastName;
      user?.phoneNumber = phoneNumber;
      user?.profileImageUrl = profileImageUrl;

      _box.putAt(userIndex, user!);
    } else {
      print('Kullanıcı bulunamadı');
    }
  }
}

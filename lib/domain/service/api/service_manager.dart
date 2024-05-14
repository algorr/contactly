import 'dart:io';
import 'package:flutter/material.dart';

import '../../../features/model/response_model.dart';

abstract class ServiceManager {
  Future<List<User>?> fetchContacts();
  Future<void> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl);
  Future<String?> uploadContactImage(File imageFile);
  Future<void> deleteUser(String userId, BuildContext context);
  Future<void> updateUser(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String profileImageUrl,
      String userId);

  Future<void> delete(String id);
}

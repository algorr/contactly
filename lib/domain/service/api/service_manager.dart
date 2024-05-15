import 'dart:io';
import 'package:contactly/features/model/user.dart';
import 'package:flutter/material.dart';

abstract class ServiceManager {
  /// The `Future<List<User>?> fetchContacts();` method in the `ServiceManager` abstract class is a
  /// declaration of a method that returns a `Future` containing a list of `User` objects or `null`.
  /// This method is intended to fetch contacts, likely from a data source such as a database or an API.
  /// The return type `Future<List<User>?>` indicates that the method will asynchronously return a list
  /// of `User` objects or `null` if there is an error or no contacts are found.
  Future<List<User>?> fetchContacts();

  /// The `Future<String?> saveContact(String firstName, String lastName, String phoneNumber, String
  /// profileImageUrl);` method in the `ServiceManager` abstract class is a declaration of a method that
  /// is intended to save a contact with the provided information.
  Future<String?> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl);

  /// The `Future<String?> uploadContactImage(File imageFile);` method in the `ServiceManager` abstract
  /// class is a declaration of a method that is intended to upload an image file associated with a
  /// contact.
  /// The `Future<String?> uploadContactImage(File imageFile);` method in the `ServiceManager` abstract
  /// class is a declaration of a method that is intended to upload an image file associated with a
  /// contact. This method takes a `File` object representing the image file to be uploaded and returns
  /// a `Future` containing a `String` or `null`.
  Future<String?> uploadContactImage(File imageFile);

  /// The `Future<void> deleteUser(String userId, BuildContext context, Size size);` method in the
  /// `ServiceManager` abstract class is a declaration of a method that is intended to delete a user
  /// with the specified `userId`.
  Future<void> deleteUser(String userId, BuildContext context, Size size);

  /// The `Future<void> updateUser` method in the `ServiceManager` abstract class is a declaration of a
  /// method that is intended to update a user's information. It takes several parameters including the
  /// `BuildContext` for UI operations, the user's `firstName`, `lastName`, `phoneNumber`,
  /// `profileImageUrl`, and the `userId` of the user to be updated.
  Future<void> updateUser(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String profileImageUrl,
      String userId);

  /// The `Future<void> delete(String id);` method in the `ServiceManager` abstract class is a
  /// declaration of a method that is intended to delete an entity with the specified `id`. The method
  /// takes a `String` parameter `id` representing the identifier of the entity to be deleted.
  Future<void> delete(String id);
}

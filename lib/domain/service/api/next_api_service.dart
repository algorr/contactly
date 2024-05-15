import 'dart:convert';
import 'dart:io';
import 'package:contactly/core/mixins/index.dart';
import 'package:contactly/domain/service/api/service_manager.dart';
import 'package:contactly/features/model/image_response.dart';
import 'package:contactly/features/model/response_model.dart';
import 'package:contactly/features/model/user.dart';
import 'package:contactly/product/init/config/env_prod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final class NexApiService extends ServiceManager with AppSnackBar {
  /// The function `saveContact` saves contact information with a profile image by uploading the image
  /// and sending a POST request with the contact details.
  ///
  /// Args:
  ///   firstName (String): The `saveContact` method you provided seems to be a function that saves
  /// contact information along with a profile image. The parameters for the method are:
  ///   lastName (String): The `lastName` parameter in the `saveContact` method refers to the last name
  /// of the contact you are trying to save. It is a string value that represents the last name of the
  /// contact being saved in your application.
  ///   phoneNumber (String): The `phoneNumber` parameter in the `saveContact` method represents the
  /// phone number of the contact that you are trying to save. It is a required field for creating a new
  /// contact entry in your system. Make sure to provide a valid phone number format when calling this
  /// method to ensure the contact information is
  ///   profileImageUrl (String): The `profileImageUrl` parameter in the `saveContact` method is a
  /// string that represents the file path or URL of the profile image of the contact that you want to
  /// save. This method uploads the image file to a server and then sends a POST request with contact
  /// information including the profile image URL to
  ///
  /// Returns:
  ///   The `saveContact` method returns a `Future<String?>`. If the HTTP response status code is 200,
  /// it returns the `image` URL. Otherwise, it returns `null`. If an exception occurs during the
  /// process, it throws an exception with the message 'Failed to save user'.
  @override
  Future<String?> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    try {
      final image = await uploadContactImage(File(profileImageUrl));

      final response = await http.post(
        Uri.parse(ProdEnv().baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'profileImageUrl': image,
        }),
      );

      if (response.statusCode == 200) {
        return image;
      }
    } catch (e) {
      throw Exception('Failed to save user');
    }
    return null;
  }

  /// The function `uploadContactImage` uploads an image file to a server using a POST request and
  /// returns the URL of the uploaded image.
  ///
  /// Args:
  ///   imageFile (File): The `uploadContactImage` function you provided is responsible for uploading an
  /// image file to a server. The `imageFile` parameter is of type `File`, which represents the image
  /// file that you want to upload.
  ///
  /// Returns:
  ///   The `uploadContactImage` function returns a `Future<String?>`. This future will either contain
  /// the URL of the uploaded image if the upload is successful, or it will be empty if there is an
  /// error during the upload process.
  @override
  Future<String?> uploadContactImage(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ProdEnv().baseUrl}/UploadImage'),
      );

      List<int> imageBytes = await imageFile.readAsBytes();
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'image.png',
          contentType: MediaType('image', 'png'),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      String? imageUrl = '';

      if (response.statusCode == 200) {
        //print('Image uploaded successfully. Response: ${response.body}');
        ImageResponse responseModel =
            ImageResponse.fromJson(jsonDecode(response.body));
        imageUrl = responseModel.data!.imageUrl;

        return imageUrl;
      }
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image');
    }
  }

  /// The fetchContacts function fetches a list of users from a remote API using HTTP GET request and
  /// returns the list of users if the response is successful.
  ///
  /// Returns:
  ///   The `fetchContacts` method is returning a `Future` that resolves to a `List<User>?` (nullable list
  /// of User objects).
  @override
  Future<List<User>?> fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse(ProdEnv().baseUrl),
        headers: {
          'accept': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final data = Data.fromJson(responseData['data']);

        return data.users;
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }

  /// This Dart function deletes a user using an HTTP DELETE request with error handling.
  ///
  /// Args:
  ///   userId (String): The `userId` parameter in the `deleteUser` method represents the unique
  /// identifier of the user that you want to delete from the system. This identifier is used to specify
  /// which user should be deleted when making the HTTP DELETE request to the server.
  ///   context (BuildContext): The `context` parameter in the `deleteUser` method is of type
  /// `BuildContext`. It is typically used in Flutter applications to provide information about the
  /// location of the widget within the widget tree. This context can be used to access theme data, media
  /// queries, navigator, etc., within the widget tree
  ///   size (Size): The `size` parameter in the `deleteUser` method appears to be of type `Size`. In
  /// Flutter, the `Size` class represents a 2D size with a width and a height. It is commonly used in
  /// layout calculations and widget positioning.
  @override
  Future<void> deleteUser(
      String userId, BuildContext context, Size size) async {
    try {
      await http.delete(
        Uri.parse('${ProdEnv().deleteUrl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
      );
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }

  /// The updateUser function updates user information by sending a PUT request with the provided data
  /// to a specified URL.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext context` parameter in the `updateUser` method is
  /// typically used in Flutter applications to provide information about the location of the widget
  /// within the widget tree. It is commonly used to access theme data, media queries, and to navigate
  /// to other screens using the Navigator.
  ///   firstName (String): The `firstName` parameter in the `updateUser` method represents the first
  /// name of the user that you want to update in the system. It is a string value that should contain
  /// the new first name that you want to assign to the user.
  ///   lastName (String): The `lastName` parameter in the `updateUser` method represents the last name
  /// of the user that you want to update in the system. It is a string value that should be provided
  /// when calling this method to update the user's information.
  ///   phoneNumber (String): The `phoneNumber` parameter in the `updateUser` method represents the
  /// phone number of the user that you want to update in the system. It is a string type parameter
  /// where you can provide the new phone number for the user. This phone number will be updated along
  /// with other user details like first name
  ///   profileImageUrl (String): The `profileImageUrl` parameter in the `updateUser` function
  /// represents the URL or path to the image file of the user's profile picture that you want to
  /// update. This function uploads the image file to a server and then sends a PUT request to update
  /// the user's information with the new profile image
  ///   userId (String): The `userId` parameter in the `updateUser` method represents the unique
  /// identifier of the user whose information is being updated. It is used to specify which user's data
  /// should be updated in the system.
  @override
  Future<void> updateUser(
      BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String profileImageUrl,
      String userId) async {
    try {
      final image = await uploadContactImage(File(profileImageUrl));

      final response = await http.put(
        Uri.parse('${ProdEnv().deleteUrl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'profileImageUrl': image,
        }),
      );
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }

  /// This Dart function deletes a user by sending an HTTP DELETE request to a specified URL with the
  /// user's ID as a parameter.
  ///
  /// Args:
  ///   id (String): The `id` parameter in the `delete` method represents the unique identifier of the
  /// user or resource that you want to delete. This identifier is used to specify which specific item
  /// should be deleted from the server when making the HTTP DELETE request.
  @override
  Future<void> delete(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ProdEnv().deleteUrl}/$id'),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
      );
    } catch (e) {
      throw Exception('Failed to delete user');
    }
  }
}

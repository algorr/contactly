import 'dart:convert';
import 'dart:io';
import 'package:contactly/domain/service/api/service_manager.dart';
import 'package:contactly/features/model/image_response.dart';
import 'package:contactly/features/model/response_model.dart';
import 'package:contactly/product/init/config/env_prod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final class NexApiService extends ServiceManager {
  @override
  Future<void> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    try {
      final image = await uploadContactImage(File(profileImageUrl));
      print('Kaydedilen Image : $image');

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
        print('Contact posted successfully!');
      } else {
        print('Failed to post contact: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Future<String?> uploadContactImage(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://146.59.52.68:11235/api/User/UploadImage'),
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
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
      return imageUrl;
    } catch (e) {
      print('An error occurred: $e');
    }
    return null;
  }

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
        print('contacts successfully fetched: ${response.statusCode}');
        return data.users;
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to fetch users');
    }
  }

  @override
  Future<void> deleteUser(String userId, BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('${ProdEnv().deleteUrl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
      );

      if (response.statusCode == 200) {
        print('User deleted successfully!');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 8),
                Text('Contact updated successfully!'),
              ],
            )),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to delete user');
    }
  }

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

      if (response.statusCode == 200) {
        print('Contact updated successfully!');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 8),
                Text('Contact updated successfully!'),
              ],
            )),
          );
        }
      } else {
        print('Failed to updated contact: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

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

      if (response.statusCode == 200) {
        print('User deleted successfully!');
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to delete user');
    }
  }
}

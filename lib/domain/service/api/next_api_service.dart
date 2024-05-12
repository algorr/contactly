import 'dart:convert';
import 'package:contactly/domain/service/api/service_manager.dart';
import 'package:contactly/features/model/data_model.dart';
import 'package:contactly/features/model/user_model.dart';
import 'package:contactly/product/init/config/env_prod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final class NexApiService extends ServiceManager {
  @override
  Future<void> saveContact(String firstName, String lastName,
      String phoneNumber, String profileImageUrl) async {
    try {
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
          'profileImageUrl': profileImageUrl,
        }),
      );

      print('ImageUrl : $profileImageUrl');

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
  Future<void> uploadContactImage(String profileImageUrl) async {
    try {
      final uri = Uri.parse('${ProdEnv().baseUrl}/UploadImage');

      final mimeType =
          MediaType.parse('image/${profileImageUrl.split('.').last}');

      var request = http.MultipartRequest('POST', uri)
        ..headers['accept'] = 'text/plain'
        ..files.add(
          await http.MultipartFile.fromPath(
            'image',
            profileImageUrl,
            contentType: mimeType,
          ),
        );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Failed to upload image: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while uploading image: $e');
    }
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
  Future<void> deleteUser(String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('${ProdEnv().deleteUrl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'ApiKey': ProdEnv().apiKey,
        },
      );
      print('URL : ${ProdEnv().deleteUrl}/$userId');

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

  @override
  Future<void> updateUser(int index) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}

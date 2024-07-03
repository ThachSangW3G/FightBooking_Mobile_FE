import 'dart:convert';
import 'package:flightbooking_mobile_fe/models/user.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserController extends GetxController {
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  var currentUser = Rx<User?>(null);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getUserByToken(String accessToken) async {
    final uri = Uri.parse('$_baseURL/users/token?token=$accessToken');

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));

        final int id = responseData['id'];

        final String email = responseData['email'];
        final String fullName = responseData['fullName'];

        final String? phoneNumber = responseData['phoneNumber'];

        final String? address = responseData['address'];
        final String? gender = responseData['gender'];
        final DateTime dayOfBirth =
            DateTime.fromMillisecondsSinceEpoch(responseData['dayOfBirth']);

        final String? personalId = responseData['personalId'];
        final String? avatarUrl = responseData['avatarUrl'];

        currentUser.value = User(
            id: id,
            fullName: fullName,
            phoneNumber: phoneNumber,
            address: address,
            dayOfBirth: dayOfBirth,
            personalId: personalId,
            email: email,
            gender: gender,
            avatarUrl: avatarUrl);
      }
    } catch (e) {
      print("Bi loi");
      print(e);
    }
  }

  Future<bool> changeInfor(
      String accessToken,
      String fullName,
      String dayOfBirth,
      String gender,
      String address,
      String phoneNumber,
      String personalId) async {
    final uri = Uri.parse('$_baseURL/users/change-info');

    final headers = {'Content-Type': 'application/json'};

    final requestBody = {
      'token': accessToken,
      'fullName': fullName,
      'dayOfBirth': dayOfBirth,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber,
      'personalId': personalId
    };

    try {
      final response =
          await http.put(uri, body: jsonEncode(requestBody), headers: headers);

      print(response.statusCode);

      if (response.statusCode == 200) {
        currentUser.value = User(
            id: currentUser.value!.id,
            fullName: fullName,
            phoneNumber: phoneNumber,
            address: address,
            dayOfBirth: DateTime.parse(dayOfBirth),
            personalId: personalId,
            email: currentUser.value!.email,
            gender: gender,
            avatarUrl: currentUser.value!.avatarUrl);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> uploadNewAvatar(String filename) async {
    final prefs = await _prefs;
    final token = prefs.getString('tokenAccess');

    final uri = Uri.parse('$_baseURL/users/upload-new-avatar?token=$token');

    //final requestBody = {'avatarFile': base64Encode(await file.readAsBytes())};

    try {
      // final response =
      //     await http.post(uri, body: jsonEncode(requestBody), headers: headers);

      var request = http.MultipartRequest('POST', uri);

      var multipartFile = http.MultipartFile.fromPath('avatarFile', filename,
          contentType: MediaType('image', 'jpeg'));
      request.files.add(await multipartFile);

      var res = await request.send();

      if (res.statusCode == 200) {
        return true;
      }

      print(res.statusCode);
      print(filename.split("/").last);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final prefs = await _prefs;
    final token = prefs.getString('tokenAccess');

    final uri = Uri.parse('$_baseURL/users/change-password');

    final requestBody = {
      'token': token,
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };

    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(uri, body: jsonEncode(requestBody), headers: headers);

      print(token);
      print(oldPassword);
      print(newPassword);

      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

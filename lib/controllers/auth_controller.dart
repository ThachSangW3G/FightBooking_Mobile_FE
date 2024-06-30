import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final String _baseURL = 'https://flightbookingbe-production.up.railway.app';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> signup(String email, String username, String fullname,
      String password, String dayOfBirth) async {
    final uri = Uri.parse('$_baseURL/auth/signup');
    final requestBody = {
      'password': password,
      'fullName': fullname,
      'username': username,
      'email': email,
      'dayOfBirth': dayOfBirth
    };
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/hal+json',
    };

    print(requestBody);

    try {
      final response =
          await http.post(uri, body: jsonEncode(requestBody), headers: headers);

      if (response.statusCode == 301 || response.statusCode == 302) {
        // Lấy URL mới từ header "Location"
        final newUrl = response.headers['location'];
        // Tạo một yêu cầu mới đến URL mới
        final newResponse = await http.post(
          Uri.parse(newUrl!),
          body: jsonEncode(requestBody),
          headers: headers,
        );
        // Xử lý kết quả từ phản hồi mới
        if (newResponse.statusCode == 200) {
          return true;
        } else {
          print(newResponse.statusCode);
          return false;
        }
      } else if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final uri = Uri.parse('$_baseURL/auth/signin');
    final requestBody = {'username': username, 'password': password};
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/hal+json',
    };

    print(requestBody);

    try {
      final response =
          await http.post(uri, body: jsonEncode(requestBody), headers: headers);
      if (response.statusCode == 301 || response.statusCode == 302) {
        // Lấy URL mới từ header "Location"
        final newUrl = response.headers['location'];
        // Tạo một yêu cầu mới đến URL mới
        final newResponse = await http.post(
          Uri.parse(newUrl!),
          body: jsonEncode(requestBody),
          headers: headers,
        );
        // Xử lý kết quả từ phản hồi mới
        if (newResponse.statusCode == 200) {
          final responseData = jsonDecode(newResponse.body);

          final String tokenAccess = responseData['tokenAccess'];

          final String tokenRefresh = responseData['tokenRefresh'];
          final int expiresIn = responseData['expiresIn'];
          final int expiresRefreshIn = responseData['expiresRefreshIn'];
          final String username = responseData['username'];
          final String role = responseData['role'];

          final SharedPreferences prefs = await _prefs;

          await prefs.setString('tokenAccess', tokenAccess);
          await prefs.setString('tokenRefresh', tokenRefresh);
          await prefs.setInt('expiresIn', expiresIn);
          await prefs.setInt('expiresRefreshIn', expiresRefreshIn);
          await prefs.setString('username', username);
          await prefs.setString('role', role);

          return true;
        } else {
          print(newResponse.statusCode);
          return false;
        }
      } else if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final String tokenAccess = responseData['tokenAccess'];
        final String tokenRefresh = responseData['tokenRefresh'];
        final int expiresIn = responseData['expiresIn'];
        final int expiresRefreshIn = responseData['expiresRefreshIn'];
        final String username = responseData['username'];
        final String role = responseData['role'];

        final SharedPreferences prefs = await _prefs;

        await prefs.setString('tokenAccess', tokenAccess);
        await prefs.setString('tokenRefresh', tokenRefresh);
        await prefs.setInt('expiresIn', expiresIn);
        await prefs.setInt('expiresRefreshIn', expiresRefreshIn);
        await prefs.setString('username', username);
        await prefs.setString('role', role);

        return true;
      } else {
        print('Login failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    final uri = Uri.parse('$_baseURL/auth/forgot-password?email=$email');

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/hal+json',
    };

    try {
      final response = await http.put(uri, headers: headers);

      if (response.statusCode == 301 || response.statusCode == 302) {
        // Lấy URL mới từ header "Location"
        final newUrl = response.headers['location'];
        // Tạo một yêu cầu mới đến URL mới
        final newResponse = await http.put(
          Uri.parse(newUrl!),
          headers: headers,
        );
        // Xử lý kết quả từ phản hồi mới
        if (newResponse.statusCode == 200) {
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('email', email);
          return true;
        } else {
          print(newResponse.statusCode);
          return false;
        }
      } else if (response.statusCode == 200) {
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('email', email);

        return true;
      }

      return false;
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }

  Future<bool> verifyCode(int otp) async {
    final SharedPreferences prefs = await _prefs;

    final email = prefs.getString('email');

    final uri = Uri.parse('$_baseURL/auth/check-otp?codeOTP=$otp&email=$email');

    print(uri);

    print(uri);
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(uri, headers: headers);
      if (response.statusCode == 301 || response.statusCode == 302) {
        // Lấy URL mới từ header "Location"
        final newUrl = response.headers['location'];
        // Tạo một yêu cầu mới đến URL mới
        final newResponse = await http.post(
          Uri.parse(newUrl!),
          headers: headers,
        );
        // Xử lý kết quả từ phản hồi mới
        if (newResponse.statusCode == 200) {
          await prefs.setInt('otp', otp);
          return true;
        } else {
          print(newResponse.statusCode);
          return false;
        }
      } else if (response.statusCode == 200) {
        await prefs.setInt('otp', otp);

        return true;
      }

      return false;
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String newPassword, String confirmPassword) async {
    final SharedPreferences prefs = await _prefs;
    final email = prefs.getString('email');
    final otp = prefs.getInt('otp');

    final uri = Uri.parse('$_baseURL/auth/reset-password');

    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/hal+json',
    };

    final requestBody = {
      'email': email,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
      'otp': otp,
    };

    print(email);
    print(newPassword);
    print(confirmPassword);
    print(otp);

    try {
      final response =
          await http.put(uri, body: jsonEncode(requestBody), headers: headers);

      if (response.statusCode == 301 || response.statusCode == 302) {
        // Lấy URL mới từ header "Location"
        final newUrl = response.headers['location'];
        // Tạo một yêu cầu mới đến URL mới
        final newResponse = await http.put(
          Uri.parse(newUrl!),
          body: jsonEncode(requestBody),
          headers: headers,
        );
        // Xử lý kết quả từ phản hồi mới
        if (newResponse.statusCode == 200) {
          return true;
        } else {
          print(newResponse.statusCode);
          return false;
        }
      }

      if (response.statusCode == 200) {
        return true;
      }

      print(response.statusCode);

      return false;
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }
}

import 'dart:convert';
import 'package:btl_iot_2023/login/model/data_user.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  LoginRepo();

  Future<int> signUp(String name, String number, String age, String email, String account,String password) async {
    try {
      final uri = Uri.parse('https://appiottest-23a3da89803d.herokuapp.com/home/users/');
      Map<String,dynamic> data = {
        "name": name,
        "lc_number": number,
        "age": age,
        "email": email,
        "account": account,
        "password": password,
      };
      final response = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        return 201;
      } else {
        // Xử lý các mã trạng thái khác hoặc lỗi
        print('Lỗi: ${response.statusCode}');
        return response.statusCode;
      }
    } catch (e) {
      // Xử lý các ngoại lệ khác
      print('Ngoại lệ: $e');
      return 500;
    }
  }
  Future<DataUser> signIn(String username,String password) async {

      final uri = Uri.parse('https://appiottest-23a3da89803d.herokuapp.com/home/user_login/');
      Map<String,dynamic> data = {
        "username": username,
        "password": password,
      };
      final response = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );
        return DataUser.fromJson(jsonDecode(response.body)) ;
  }
}

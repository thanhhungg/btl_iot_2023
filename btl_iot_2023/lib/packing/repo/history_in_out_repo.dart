
import 'dart:convert';

import 'package:btl_iot_2023/login/model/data_user.dart';
import 'package:hive/hive.dart';

import '../model/history_in_out.dart';
import 'package:http/http.dart' as http;

class HistoryInOutRepo {


  Future<List<HistoryInOut>> getHistoryInOut() async {

    final uri = Uri.parse('https://appiottest-23a3da89803d.herokuapp.com/home/getAllDriver/');

    Map<String,dynamic> datas = {
      "lc_number": "${Hive.box<DataUser>('myBox').get('dataUser')!.lcNumber}",
    };
    final response = await http.post(
      uri,
      body: jsonEncode(datas),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = response.body ;
      final listHistoryInOut = jsonDecode(data).map<HistoryInOut>((json) => HistoryInOut.fromJson(json)).toList();
      return listHistoryInOut;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
// Import các thư viện cần thiết
import 'dart:convert';

import 'package:btl_iot_2023/login/cubit/login_cubit.dart';
import 'package:btl_iot_2023/login/screen/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../login/model/data_user.dart';

// Class SettingsScreen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Các giá trị demo
  String name = 'John Doe';
  int age = 25;
  String licensePlate = 'ABC123';
  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu từ Hive
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Thông tin tài khoản'),
      ),
      body: ValueListenableBuilder(
        valueListenable:  Hive.box<DataUser>('myBox').listenable(),
        builder: ( context, box, widget)
        => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                 // Căn giữa theo chiều ngang
                  children: [
                    // Thêm ảnh đại diện
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,  // Đổi màu nền tại đây
                        image: DecorationImage(
                          scale: 0.5,
                          image: AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                    ),


                    SizedBox(height: 20),
                    Text(
                      'Họ và Tên: ${utf8.decode(latin1.encode(box.get('dataUser')!.name!))}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tuổi: ${box.get('dataUser')!.age}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Biển số xe: ${box.get('dataUser')!.lcNumber}',
                      style: TextStyle(fontSize: 20),
                    ),SizedBox(height: 10),
                    Text(
                      'Gmail: ${box.get('dataUser')!.email}',
                      style: TextStyle(fontSize: 20),
                    ),

                    SizedBox(height: 40),
                    // Cài đặt nút Logout
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<LoginCubit>(context),
                              child: SignInPage(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text('Log Out'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

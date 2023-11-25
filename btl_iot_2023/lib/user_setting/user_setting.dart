// Import các thư viện cần thiết
import 'package:btl_iot_2023/login/cubit/login_cubit.dart';
import 'package:btl_iot_2023/login/screen/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Thông tin tài khoản'),
      ),
      body: Padding(
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
                'Name: $name',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Age: $age',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'License Plate: $licensePlate',
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
    );
  }
}

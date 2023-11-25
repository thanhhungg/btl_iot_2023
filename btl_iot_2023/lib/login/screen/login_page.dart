import 'package:btl_iot_2023/login/screen/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../home.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginCubit _loginCubit = LoginCubit();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _accountController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _numberController = TextEditingController();
  late TextEditingController _ageController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: BlocListener<LoginCubit, LoginState>(
          bloc: context.read<LoginCubit>(),
          listener: (BuildContext context, state) {
            if (state is LoginFailure) {
              Fluttertoast.showToast(
                msg: "Đăng ký thất bại",
                backgroundColor: Colors.grey.shade600,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
              );
            }
            if (state is LoginSuccess) {
              Fluttertoast.showToast(
                msg: "Đăng ký thành công",
                backgroundColor: Colors.green.shade600,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT,
              );
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tạo tài khoản",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "HIHI",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: 'Tên đăng nhập',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    labelText: 'Biển số xe',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Tuổi',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  focusNode: _focusNode,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(_focusNode);
                      context.read<LoginCubit>().signUp(
                          _nameController.text,
                          _numberController.text,
                          _ageController.text,
                          _emailController.text,
                          _accountController.text,
                          _passwordController.text);
                    },
                    child: Text('Đăng ký'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn đã có tài khoản?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Đăng nhập"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:btl_iot_2023/login/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../home.dart';
import '../cubit/login_cubit.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LoginCubit _loginCubit = LoginCubit();
  late TextEditingController _accountController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        bloc: context.read<LoginCubit>(),
        listener: (BuildContext context, state) {

          if (state is SignInFailure) {
            Fluttertoast.showToast(
              msg: "Đăng nhập thất bại",
              backgroundColor: Colors.grey.shade600,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
          if (state is SignInSuccess) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Đăng nhập",
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
                    "Đăng nhập để tiếp tục sử dụng",
                    style: TextStyle(
                      fontSize: 20,
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
                controller: _accountController,
                decoration: InputDecoration(
                  labelText: 'Tên đăng nhập',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                focusNode: _focusNode,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(_focusNode);
                    context.read<LoginCubit>().signIn(
                        _accountController.text, _passwordController.text);
                  },
                  child: Text('Đăng nhập'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bạn chưa có tài khoản?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<LoginCubit>(context),
                            child: LoginPage(),
                          ),
                        ),
                      );
                    },
                    child: Text("Đăng ký"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

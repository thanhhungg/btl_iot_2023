import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../model/data_user.dart';
import '../repo/login_repo.dart';
part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final LoginRepo _loginRepo = LoginRepo();
  late DataUser dataUser = DataUser();

  Future<void> signUp(String name, String number, String age ,String email,String account,String password) async{
    emit(LoginLoading());
    try{
      final data = await _loginRepo.signUp(name, number, age, email, account, password);
      if(data == 201){

        emit(LoginSuccess());
      }else{
        emit(LoginFailure(error: 'Something went wrong'));
      }
    }catch(e){
      emit(LoginFailure(error: e.toString()));
    }
  }
  Future<void> signIn(String username,String password) async{
    emit(SignInLoading());
    try{
      final data = await _loginRepo.signIn(username, password);
      print(data.name);
      if(data.name!=null){
        print(data.name);
        emit(SignInSuccess( dataUser: data));
        var box = await Hive.openBox<DataUser>('myBox');
        box.put('dataUser', data);
        print("cutchuwa");
      }else{
        emit(SignInFailure(error: 'Something went wrong'));
      }
    }catch(e){
      emit(SignInFailure(error: e.toString()));
    }
  }
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/login_repo.dart';
part 'login_state.dart';
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final LoginRepo _loginRepo = LoginRepo();
  Future<void> signUp(String name, String number, String age ,String email,String account,String password) async{
    emit(LoginLoading());
    try{
      final response = await _loginRepo.signUp(name, number, age, email, account, password);
      if(response== 201){
        print("hihihi");
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
      final response = await _loginRepo.signIn(username, password);
      if(response== 200){
        print("hihihi");
        emit(SignInSuccess());
      }else{
        emit(SignInFailure(error: 'Something went wrong'));
      }
    }catch(e){
      emit(SignInFailure(error: e.toString()));
    }
  }
}
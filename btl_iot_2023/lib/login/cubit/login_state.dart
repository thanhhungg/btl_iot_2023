
part of 'login_cubit.dart';
abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
class SignInLoading extends LoginState {}
class SignInSuccess extends LoginState {}
class SignInFailure extends LoginState {
  final String error;
  SignInFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
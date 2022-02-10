import 'package:equatable/equatable.dart';
import 'auth_models/email.dart';
import 'auth_models/password.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.error,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? error;

  @override
  List<Object> get props => [email, password, status, error!];

  LoginState copyWith({
    Email? email,
    Password? password,
     FormzStatus? status,
     String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
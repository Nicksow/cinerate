import 'package:cinerate/models/users.dart';

abstract class LoginState {
  const LoginState();
}

class LoggingIn extends LoginState {
  const LoggingIn();
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class LoggedIn extends LoginState {
  final Users user;
  LoggedIn(this.user);
}

class LoggedOut extends LoginState {
  const LoggedOut();
}

class Registering extends LoginState {
  const Registering();
}


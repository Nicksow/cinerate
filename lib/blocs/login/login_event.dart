abstract class LoginEvent {}

class LogInEvent extends LoginEvent {
  final String name;
  final String password;

  LogInEvent({required this.name, required this.password});
}

class LogOutEvent extends LoginEvent {}

class RegisterEvent extends LoginEvent {
  final String name;
  final String password;

  RegisterEvent({required this.name, required this.password});
}

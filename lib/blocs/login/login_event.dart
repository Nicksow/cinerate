abstract class LoginEvent {}

class LogInEvent extends LoginEvent {
  final String name;
  final String password;

  LogInEvent({required this.name, required this.password});
}

class LogOutEvent extends LoginEvent {}

import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/login/login_event.dart';
import 'package:cinerate/blocs/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoggedIn) {
                Navigator.pushNamed(context, '/home');
                SnackBar snackBar = SnackBar(
                  content: Text('Welcome back  ${state.user.name} !'),
                  duration: const Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Container()),
        BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoggingIn) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              if (state is LoginError) ...[
                const Text("Status : ", style: TextStyle(color: Colors.redAccent)),
                Text(state.error, style: const TextStyle(color: Colors.redAccent)),
                LoginForm()
              ] else if (state is LoggedOut) ...[
                LoginForm(),
              ]
            ],
          );
        }),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return SizedBox(
      width: 450,
      child: Container(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.white70)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            const Text('Entrez votre nom et mot de passe',
                style: TextStyle(color: Colors.white70)),
            TextField(
              decoration: const InputDecoration(labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white70)),
              controller: nameController,
              onSubmitted: (value) => _tryLogin(loginBloc),
              style: const TextStyle(color: Colors.white70),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white70)),
              controller: passwordController,
              obscureText: true,
              onSubmitted: (value) => _tryLogin(loginBloc),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _tryLogin(loginBloc);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _tryLogin(loginBloc) {
    loginBloc.add(LogInEvent(
        name: nameController.text, password: passwordController.text));
  }
}

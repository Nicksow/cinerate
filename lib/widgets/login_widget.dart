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
                  content: Text('Content de vous revoir ${state.user.name} !'),
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
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      const Text("Erreur : ", style: TextStyle(color: Colors.white)),
                      Text(state.error, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
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
            const Text('Connexion',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            TextField(
              decoration: const InputDecoration(labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white70)),
              controller: nameController,
              onSubmitted: (value) => tryLogin(loginBloc),
              style: const TextStyle(color: Colors.white70),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.white70)),
              controller: passwordController,
              obscureText: true,
              onSubmitted: (value) => tryLogin(loginBloc),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 25),
              ),
              onPressed: () {
                tryLogin(loginBloc);
              },
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 25),
              ),
              onPressed: () {
                tryRegister(loginBloc);
              },
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }

  void tryLogin(loginBloc) {
    loginBloc.add(LogInEvent(
        name: nameController.text, password: passwordController.text));
  }

  void tryRegister(loginBloc) {
    loginBloc.add(RegisterEvent(
        name: nameController.text, password: passwordController.text));
  }
}

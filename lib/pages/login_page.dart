import 'package:cinerate/widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CinéRate',
            style: TextStyle(
              fontSize: 32,
              color: Color(0xffF2EFEA),
            )),
        backgroundColor: const Color(0xff38302E),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginWidget(),
          ],
        ),

      ),
    );
  }
}
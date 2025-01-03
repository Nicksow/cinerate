import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/login/login_event.dart';
import 'package:cinerate/blocs/login/login_state.dart';
import 'package:cinerate/models/menuIndex.dart';
import 'package:cinerate/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final menuIndex = Provider.of<MenuIndex>(context);

    return Drawer(
      backgroundColor: const Color(0xFF788585),
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'CinéRate',
                style: TextStyle(
                  fontSize: 48,
                  color: Color(0xffF2EFEA),
                ),
              ),
            ),
          ),
          ListTile(
            hoverColor: const Color(0xFFD9D9D9),
            textColor: const Color(0xffF2EFEA),
            title: const Text('A voir',
                style: TextStyle(
                  fontSize: 24,
                )),
            selected: menuIndex.index == 0,
            onTap: () {
              menuIndex.updateIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            hoverColor: const Color(0xFFD9D9D9),
            textColor: const Color(0xffF2EFEA),
            title: const Text('Déjà vu',
                style: TextStyle(
                  fontSize: 24,
                )),
            selected: menuIndex.index == 1,
            onTap: () {
              menuIndex.updateIndex(1);
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoggedIn) {
              return Column(
                children: [
                  const Text('Connecté en tant que :'),
                  Text(state.user.name),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<LoginBloc>().add(LogOutEvent());
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                      );
                    },
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
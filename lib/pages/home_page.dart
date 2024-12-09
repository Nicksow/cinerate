import 'package:cinerate/blocs/content/content_bloc.dart';
import 'package:cinerate/blocs/content/content_state.dart';
import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/login/login_state.dart';
import 'package:cinerate/widgets/content_widget.dart';
import 'package:cinerate/widgets/menu_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFF454545),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color(0xffF2EFEA),
            ),
            toolbarHeight: 75,
            backgroundColor: const Color(0xff38302E),
            title: TabBar(
              dividerColor: Colors.transparent,
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 5.0, color: Colors.white),
                insets: const EdgeInsets.symmetric(horizontal: 40.0),
              ),
              tabs: const [
                Tab(child: Text( "FILMS", style: TextStyle(fontSize: 20, color: Color(0xffF2EFEA)))),
                Tab(child: Text( "SERIES",style: TextStyle(fontSize: 20, color: Color(0xffF2EFEA)))),
              ],
            ),
          ),
          body: Column(
            children: [
              ContentWidget(),
              BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoggedIn) {
                      SnackBar snackBar = SnackBar(
                        content: Text('Welcome back  ${state.user.name} !'),
                        duration: const Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container()),
            ],
          ),
          drawer: const MenuDrawerWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            child: const Icon(Icons.add),
          ),
        )
    );
  }
}

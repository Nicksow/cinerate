import 'package:cinerate/widgets/content_widget.dart';
import 'package:cinerate/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';

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

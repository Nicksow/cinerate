import 'package:cinerate/blocs/content/content_bloc.dart';
import 'package:cinerate/blocs/detail/detail_bloc.dart';
import 'package:cinerate/blocs/login/login_bloc.dart';
import 'package:cinerate/blocs/movieDB/movieDB_bloc.dart';
import 'package:cinerate/firebase_options.dart';
import 'package:cinerate/models/menuIndex.dart';
import 'package:cinerate/pages/add_page.dart';
import 'package:cinerate/pages/detail_page.dart';
import 'package:cinerate/pages/home_page.dart';
import 'package:cinerate/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => MenuIndex(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<MovieDBBloc>(
          create: (context) => MovieDBBloc(),
        ),
        BlocProvider<ContentBloc>(
          create: (context) => ContentBloc(),
        ),
        BlocProvider<DetailBloc>(
          create: (context) => DetailBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'CinéRate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/add': (context) => const AddPage(),
          '/detail': (context) => const DetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


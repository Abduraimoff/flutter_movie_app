import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'pages/auth_page.dart';
import 'pages/home_page.dart';
import 'providers/person_provider.dart';
import 'utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => PersonProvider()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: kPrimaryColor,
          ),
        ),
        home: const AuthPage(),
        routes: {
          '/auth': (context) => const AuthPage(),
          '/home_page': (context) => const HomePage(),
          // '/home_page/movie_details':(context) =>  MovieDetails(),
        },
      ),
    );
  }
}

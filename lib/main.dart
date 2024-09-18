import 'package:flutter/material.dart';
import 'package:movies_assingment/pages/home.dart';
import 'package:movies_assingment/splash/spalsh.dart';
import 'package:movies_assingment/utlites/watchlist_provider.dart';
import 'package:provider/provider.dart';

void main()  {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
      ],
      child:const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
    );
  }
}

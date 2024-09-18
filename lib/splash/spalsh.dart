
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_assingment/pages/home.dart';
class SplashScreen extends StatefulWidget {
  static String routeName = "Splash";

  const SplashScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 300,),
            Center(child: Image.asset('assets/movies.png', )),
             const Spacer(),
           
            const Text('route', 
            style: TextStyle(color: Colors.white, fontSize: 16)),
            const Text('supervised by Mohamed Nabil', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
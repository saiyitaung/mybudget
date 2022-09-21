import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mybudget/ui/home.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI
({Key? key}) : super(key: key);

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  
  @override
  void initState() {
    
    super.initState();
    _navigateHome();
  }
  _navigateHome() async{
    await Future.delayed(const Duration(seconds: 3),(){});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(child: Lottie.asset("lottiefile/loading-finance-app.json")),
    );
  }
}
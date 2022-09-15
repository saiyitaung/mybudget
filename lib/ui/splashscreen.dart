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
    // TODO: implement initState
    super.initState();
    _navigateHome();
  }
  _navigateHome() async{
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(child: Lottie.asset("lottiefile/loading-finance-app.json")),
    );
  }
}
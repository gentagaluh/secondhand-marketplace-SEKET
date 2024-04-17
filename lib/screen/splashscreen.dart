import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/screen/bnb/bnb.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nama = prefs.getString('id');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => nama == null ? Login() : Bnb(id: nama)));
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      getId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.warna3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset('images/logo.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Se',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Warna.warna1,
                    fontSize: MediaQuery.of(context).size.width / 25),
              ),
              Text('Ket',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: Warna.warna2))
            ],
          )
        ],
      ),
    );
  }
}

import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/bnb/business.dart';
import 'package:app_seket/screen/bnb/fav.dart';
import 'package:app_seket/screen/bnb/home.dart';
import 'package:app_seket/screen/bnb/notif.dart';
import 'package:app_seket/screen/bnb/set.dart';
import 'package:flutter/material.dart';

class Bnb extends StatefulWidget {
  final String id;
  Bnb({required this.id});

  @override
  State<Bnb> createState() => _BnbState();
}

class _BnbState extends State<Bnb> {
  int currentIndex = 0;

  void ontap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      Home(id: widget.id),
      Fav(id: widget.id),
      Business(id: widget.id),
      Notif(id: widget.id),
      Set(id: widget.id),
    ];
    return Scaffold(
        body: body[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Warna.warna1,
            unselectedItemColor: Warna.warna4,
            onTap: ontap,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded), label: 'Fav'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business_center,
                  ),
                  label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notif'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Set'),
            ]));
  }
}

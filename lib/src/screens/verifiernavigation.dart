

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dashboardverifier.dart';
import 'historyverifier.dart';
import 'profileverifier.dart';

class VerifierNav extends StatefulWidget {

  @override
  _VerifierScreen createState() => _VerifierScreen();
}

class _VerifierScreen extends State<VerifierNav> {
  int _selectedIndex = 0;
 bool status = false;


  List<Widget> _widgetOptions = <Widget>[
    Verifier(name: 'Tristan',),
    History(),
    Profile(),
  ];

  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body:  Scaffold(body: Container(child:_widgetOptions.elementAt(_selectedIndex),)),
      bottomNavigationBar: 
        BottomNavigationBar(
          selectedItemColor: Colors.pinkAccent,
          items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                  backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Scan History',
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Verifier Profile',
              backgroundColor: Colors.pinkAccent,
            ),
          ],
           currentIndex:  _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
    );
  }
}
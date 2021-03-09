import 'package:ecom_test/bottom_navigation.dart';
import 'package:ecom_test/pdp.dart';
import 'package:ecom_test/plp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex;

  final List<Widget> _children = [
    PlpPage(),
    Container(),
    PDPPage(),
    Container(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xfffbaf03),
        accentColor: Color(0xfffbaf03),
      ),
      home: SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: TitledBottomNavigationBar(
            reverse: false,
            activeColor: Colors.black,
            indicatorColor: Colors.black,
            inactiveColor: Colors.grey,
            height: 60,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              TitledNavigationBarItem(
                  title: Text('Home'), icon: Icon(Icons.home_outlined)),
              TitledNavigationBarItem(
                  title: Text('My Order'),
                  icon: Icon(Icons.assignment_outlined)),
              TitledNavigationBarItem(
                  title: Text('Cart'),
                  icon: Icon(Icons.shopping_cart_outlined)),
              TitledNavigationBarItem(
                  title: Text('Settings'), icon: Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivary_app/screens/auth/sign_up_page.dart';
import 'package:food_delivary_app/screens/cart/cart_history.dart';
import 'package:food_delivary_app/screens/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../profile/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PersistentTabController _controller;

  int _selectedIndex = 0;
  List pages = [
    MainFoodPage(),
    SignUpPage(),
    CartHistoryPage(),
    AccountPage(),
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: 30,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined,size: 30),label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,size: 30),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded,size: 30),label: 'Account'),
        ],
      ),
    );
  }
}

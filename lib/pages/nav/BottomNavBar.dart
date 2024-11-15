import 'package:flutter/material.dart';
import 'package:wedding_organizer/pages/Vendor_page/vendor-main.dart';
import 'package:wedding_organizer/pages/home/home.dart';
import 'package:wedding_organizer/pages/profile/profile.dart';
import 'package:wedding_organizer/pages/souvenir/souvenir.dart';



class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _index = 0;
  List _screen = [HomeScreen(),Vendor(),SouvenirPage(),ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_index],
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _index,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey ,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store
            ),
            label: 'Vendor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard
            ),
            label: 'Souvenir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person
            ),
            label: 'Profile',
          ),
          
        ],
        onTap: (value) {
          setState(() {
            print(value);
            _index = value;
          });
        },
      ),
    );
  }
}

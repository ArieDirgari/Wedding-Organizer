import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_organizer/pages/auth/Login_Register_Screen.dart';

class ProfilePage extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginRegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.pink[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'), 
                ),
                SizedBox(height: 10),
                Text(
                  // currentUser?.email,
                  "User",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Pengaturan Profil'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Pengaturan Keamanan'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.link),
                  title: Text('Akun Terhubung'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('SmartPay'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Bantuan'),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logout(context),
        child: Icon(Icons.logout),
        backgroundColor: Colors.red,
        tooltip: 'Logout',
        
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'product_list_screen.dart';
import 'package:digital/models/category.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[800],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/logo.png', height: 60),
              Text('Digital Products'),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  // Placeholder for user profile navigation
                },
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'E-Books'),
              Tab(text: 'Softwares'),
              Tab(text: 'Digital Arts'),
              Tab(text: 'Online Courses'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user?.displayName ?? "User"),
                accountEmail: Text(user?.email ?? ""),
                currentAccountPicture: CircleAvatar(
                  child: Text(user?.email?.substring(0, 1) ?? 'U'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductListScreen(category: 'E-Books'),
            ProductListScreen(category: 'Softwares'),
            ProductListScreen(category: 'Digital Arts'),
            ProductListScreen(category: 'Online Courses'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.pink,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.pink[300],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

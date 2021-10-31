import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controllers/social_layout_controller.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/screens/login_screen.dart';

class SocialLayout extends StatefulWidget {
  SocialLayout({Key? key}) : super(key: key);

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SocialLayoutController.item[SocialLayoutController.currentIndex].label),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconly_Broken.Notification),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Iconly_Broken.Search),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => LoginScreen());
            },
            icon: Icon(Iconly_Broken.Logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: SocialLayoutController.currentIndex,
        children: SocialLayoutController.item.map((element) => element.screen).toList(),
      ), // SocialLayoutController.item[SocialLayoutController.currentIndex].screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: SocialLayoutController.currentIndex,
        onTap: (int newValue) {
          setState(() {
            SocialLayoutController.changeIndex(newValue);
          });
        },
        backgroundColor: Colors.blueAccent,
        items: SocialLayoutController.item
            .map(
              (element) => BottomNavigationBarItem(
                label: element.label,
                icon: element.icon,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
            .toList(),
      ),
    );
  }
}

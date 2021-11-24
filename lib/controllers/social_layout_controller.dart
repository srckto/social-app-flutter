import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/styles/Iconly-Broken_icons.dart';
import 'package:social_app/views/screens/chat_screen.dart';
import 'package:social_app/views/screens/home_screen.dart';
import 'package:social_app/views/screens/create_post_screen.dart';
import 'package:social_app/views/screens/setting_screen.dart';
import 'package:social_app/views/screens/user_location_screen.dart';

class BoardingItem {
  final String label;
  final Icon icon;
  final Widget screen;

  BoardingItem({
    required this.label,
    required this.icon,
    required this.screen,
  });
}

class SocialLayoutController {
  static int currentIndex = 0;
  static List<BoardingItem> item = [
    BoardingItem(label: "Home", icon: Icon(Iconly_Broken.Home), screen: HomeScreen()),
    BoardingItem(label: "Chat", icon: Icon(Iconly_Broken.Chat), screen: ChatScreen()),
    BoardingItem(label: "Post", icon: Icon(Iconly_Broken.Paper_Upload), screen: CreatePostScreen()),
    BoardingItem(label: "Location", icon: Icon(Iconly_Broken.Location), screen: UserLocationScreen()),
    BoardingItem(label: "Setting", icon: Icon(Iconly_Broken.Setting), screen: SettingScreen()),
  ];

  static void changeIndex(int newIndex) {
    if (newIndex == 2)
      Get.to(() => CreatePostScreen());
    else
      currentIndex = newIndex;
  }
}

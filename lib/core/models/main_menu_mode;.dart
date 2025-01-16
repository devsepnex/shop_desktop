import 'package:flutter/widgets.dart';
import 'package:shop/core/models/sub_menu_model.dart';
class MainMenuModel {
  String nameParent;
  IconData icon;
  bool isOpen;
  List<SubMenuModel> children;
  List<String>access;
  Widget? screen;

  MainMenuModel(
      {required this.nameParent,
      required this.icon,
      required this.children,
      this.isOpen = false,
      required this.access,
      this.screen
      
      });
}

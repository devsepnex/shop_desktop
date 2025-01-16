import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/core/api/api_manager.dart';
import 'package:shop/core/models/main_menu_mode;.dart';
import 'package:shop/core/models/sub_menu_model.dart';
import 'package:shop/screens/DashBoard/Update/update2_screen.dart';
import 'package:shop/screens/DashBoard/Update/update_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int openTicketsCount = 0;
  Widget currentScreen = UpdateScreen();
  late ApiManager apiManager;
  int? total_records_open;

  DashboardProvider() {
    apiManager = GetIt.I.get<ApiManager>();
  }

  String selectedMenuTitle = 'سپنکس';
  void updateSelectedMenuTitle(String title) {
    selectedMenuTitle = title;
    notifyListeners();
  }

  // متد برای به‌روزرسانی تعداد تیکت‌ها
  void setOpenTicketsCount(int count) {
    openTicketsCount = count;
    notifyListeners();
  }

  // متغیر برای ذخیره ایندکس منوی انتخابی و زیرمنوی انتخابی
  int? selectedMenuIndex; // ایندکس منوی والد
  int? selectedChildMenuIndex; // ایندکس زیرمنوی انتخابی

  // متد برای تنظیم ایندکس منوی انتخابی
  void setSelectedMenuIndex(int? index) {
    selectedMenuIndex = index;
    notifyListeners();
  }

  // متد برای تنظیم ایندکس زیرمنوی انتخابی
  void setSelectedChildMenuIndex(int? index) {
    selectedChildMenuIndex = index;
    notifyListeners();
  }

  void initMenu(String role) async {
    List<MainMenuModel> menus1 = [];
    menus.clear();
    menus1.clear();
    childrenList.clear();

    SubMenuModel ch1 = SubMenuModel(name: ' احراز هویت', screen: UpdateScreen(),icon: Icons.shopping_bag);
    SubMenuModel ch2 = SubMenuModel(name: ' اطلاعات بانکی', screen: UpdateScreen(),icon: Icons.shopping_bag);
    SubMenuModel ch3 = SubMenuModel(name: 'شخصی سازی غرفه ', screen: UpdateScreen(),icon: Icons.shopping_bag);
    SubMenuModel ch4 = SubMenuModel(name: ' اطلاعات غرفه', screen: UpdateScreen(),icon: Icons.shopping_bag);

    childrenList.add(ch1);
    childrenList.add(ch2);
    childrenList.add(ch3);
    childrenList.add(ch4);

    MainMenuModel m1 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'پیشخوان',
        icon: Icons.dashboard,
        children: [],
        screen: UpdateScreen2());

    MainMenuModel m2 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'گفت و گو',
        icon: Icons.forum,
        children: [],
        screen: UpdateScreen2());

    MainMenuModel m3 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'محصولات',
        icon: Icons.shopping_bag,
        children: [],
        screen: UpdateScreen2());

    MainMenuModel m4 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'تنظیمات غرفه',
        icon: Icons.manage_accounts,
        children: [ch1, ch2, ch3, ch4]);
    MainMenuModel m5 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'گزارش مالی و تسویه حساب',
        icon: Icons.bar_chart,
        children: []);
    MainMenuModel m6 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'آمار و تحلیل رشد غرفه',
        icon: Icons.trending_up,
        children: []);

    MainMenuModel m7 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'مشتریان',
        icon: Icons.group,
        children: []);
    MainMenuModel m8 = MainMenuModel(
        access: [
          "super_admin",
        ],
        nameParent: 'پشتیبانی',
        icon: Icons.support_agent,
        children: []);
    menus1.add(m1);
    menus1.add(m2);
    menus1.add(m3);
    menus1.add(m4);
    menus1.add(m5);
    menus1.add(m6);
    menus1.add(m7);
    menus1.add(m8);

    for (var element in menus1) {
      if (element.access.contains(role)) {
        menus.add(element);
      }
    }
  }

  List<SubMenuModel> childrenList = [];
  List<MainMenuModel> menus = [];

  void onParentMenuClicked(int index, bool open) {
    menus.elementAt(index).isOpen = open;
    notifyListeners();
  }

  void setCurrentScreen(Widget screen) {
    currentScreen = screen;
    notifyListeners();
  }
}

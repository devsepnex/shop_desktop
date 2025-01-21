import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/constants/app_color.dart';
import 'package:shop/core/constants/live_date.dart';
import 'package:shop/main_provider.dart';
import 'package:shop/screens/DashBoard/Update/update_screen.dart';
import 'package:shop/screens/DashBoard/dashboard_provider.dart';
import 'package:shop/screens/login/login_screen.dart';
import '../../core/widgets/response_detector.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.role});
  final String role;
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardProvider provider;
  @override
  void initState() {
    provider = DashboardProvider();
    super.initState();

    // menu binding through role access
    provider.initMenu(widget.role);

    // تعیین صفحه‌ی مورد نظر بر اساس رول
    if (widget.role == 'admin_1') {
      provider.setCurrentScreen(UpdateScreen());
    } else if (widget.role == 'super_admin') {
      provider.setCurrentScreen(UpdateScreen());
    }

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      builder: (context, child) => Scaffold(
        appBar: _appBar(context),
        body: ResponseDetector(
             screenWindows: screenW(context),
            screenTab: screen(context),
            screenMob: screen(context),),
        drawer: MediaQuery.of(context).size.width <= 1024
            ? MediaQuery.of(context).size.width > 426
                ? Drawer(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: _sideMenu(context),
                  )
                : Drawer(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: _sideMenu(context),
                  )
            : null,
      ),
    );
  }

  Column screenW(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _sideMenu(context),
              ),
              SizedBox(width: 16),
              Expanded(child: context.watch<DashboardProvider>().currentScreen),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

Widget screen(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 16),
            SizedBox(width: 16),
            Expanded(child: context.watch<DashboardProvider>().currentScreen),
            SizedBox(width: 16),
          ],
        ),
      ),
    ],
  );
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    forceMaterialTransparency: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                context.watch<MainProvider>().themeMode == ThemeMode.dark
                    ? Icons.sunny
                    : Icons.dark_mode,
              ),
              onPressed: () {
                context.read<MainProvider>().toggleTheme();
              },
            ),
            SizedBox(width: 4),
            IconButton(
                onPressed: () {
                  showMenu(
                    color: AppColor.baseColor,
                    context: context,
                    position: RelativeRect.fromLTRB(20, 50, 100, 0),
                    items: [
                      PopupMenuItem(
                          height: 100,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.userTie,
                                          size: 15,
                                          color: AppColor.SecondColor,
                                        ),
                                        SizedBox(
                                          height: 21,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.userShield,
                                          size: 15,
                                          color: AppColor.SecondColor,
                                        ),
                                        SizedBox(height: 24),
                                        Icon(
                                          FontAwesomeIcons.phone,
                                          size: 15,
                                          color: AppColor.SecondColor,
                                        ),
                                   
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 3),
                                            Text(
                                              '${LiveData.firstName} ${LiveData.lastName}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                
                                                  color:
                                                      AppColor.darkContainer),
                                            ),
                                            SizedBox(height: 14),
                                            Text(
                                              '${LiveData.role}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColor.darkContainer),
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              '${LiveData.username}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColor.darkContainer),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[700],
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                                label: Text('خروج'),
                                icon: Icon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              )
                            ],
                          ))
                    ],
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.userCircle,
                  size: 25,
                )),
            SizedBox(width: 4),
          ],
        ),
      ],
    ),
  );
}

Widget _sideMenu(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.18,
      decoration: BoxDecoration(
        color: context.watch<MainProvider>().themeMode == ThemeMode.dark
            ? AppColor.gradientColor3
            : AppColor.mainColor.shade100,
        borderRadius: BorderRadius.circular(8), // گوشه‌های گرد کل منو
      ),
      child: Consumer<DashboardProvider>(
        builder: (context, value, child) {
          int? hoveredMenuIndex;
          int? hoveredChildIndex;
          return StatefulBuilder(
            builder: (context, setState) {
              return ListView(
                padding: EdgeInsets.zero,
                children: List.generate(
                  value.menus.length,
                  (index) => Column(
                    children: [
                      MouseRegion(
  onEnter: (_) => setState(() => hoveredMenuIndex = index),
  onExit: (_) => setState(() => hoveredMenuIndex = null),
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4), // مشابه زیرمنو
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // مشابه زیرمنو
    decoration: BoxDecoration(
      color: index == value.selectedMenuIndex &&
              value.selectedChildMenuIndex == null
          ? context.watch<MainProvider>().themeMode == ThemeMode.dark
              ? AppColor.mainColor.shade100
              : AppColor.gradientColor2
          : hoveredMenuIndex == index
              ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                  ? AppColor.mainColor.shade100
                  : AppColor.gradientColor2
              : Colors.transparent,
      borderRadius: BorderRadius.circular(8), // گوشه‌های گرد
    ),
    child: InkWell(
      onTap: () {
        DashboardProvider provider = context.read<DashboardProvider>();
        if (value.menus[index].children.isNotEmpty) {
          provider.onParentMenuClicked(index, !provider.menus[index].isOpen);
        } else {
          provider.setSelectedMenuIndex(index);
          provider.setSelectedChildMenuIndex(null);
          provider.setCurrentScreen(value.menus[index].screen ?? UpdateScreen());
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (value.menus[index].children.isNotEmpty)
            value.menus[index].isOpen
                ? RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: AppColor.mainColor.shade900,
                    ),
                  )
                : Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColor.mainColor.shade900,
                  ),
          Spacer(),
          // تغییر رنگ متن به سفید در حالت لایت و آمبر در حالت دارک
          Text(
            value.menus[index].nameParent,
            style: TextStyle(
              color: hoveredMenuIndex == index
                  ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                   ?AppColor.gradientColor2
                    : AppColor.baseColor
                  : value.selectedMenuIndex == index &&
                          value.selectedChildMenuIndex == null
                      ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                          ? AppColor.mainColor.shade900
                          : AppColor.baseColor
                      : context.watch<MainProvider>().themeMode == ThemeMode.dark
                          ? AppColor.baseColor
                          : AppColor.mainColor.shade900,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            value.menus[index].icon,
            color: hoveredMenuIndex == index
                ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                    ?AppColor.gradientColor2
                    : AppColor.baseColor
                : value.selectedMenuIndex == index &&
                        value.selectedChildMenuIndex == null
                    ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                        ? AppColor.mainColor.shade900
                        : AppColor.baseColor
                    : context.watch<MainProvider>().themeMode == ThemeMode.dark
                        ? AppColor.baseColor
                        : AppColor.mainColor.shade900,
          ),
        ],
      ),
    ),
  ),
),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: value.menus[index].isOpen
                            ? value.menus[index].children.length * 50
                            : 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.menus[index].children.length,
                          itemBuilder: (context, childIndex) {
                            var child = value.menus[index].children[childIndex];
                            bool isSelected = value.selectedMenuIndex == index &&
                                value.selectedChildMenuIndex == childIndex;
                            return MouseRegion(
  onEnter: (_) => setState(() => hoveredChildIndex = childIndex),
  onExit: (_) => setState(() => hoveredChildIndex = null),
  child: Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 12),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: isSelected ||
              (hoveredChildIndex == childIndex &&
                  value.selectedMenuIndex == index)
          ? context.watch<MainProvider>().themeMode == ThemeMode.dark
              ? AppColor.mainColor.shade100
              : AppColor.gradientColor2
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: InkWell(
      onTap: () {
        value.setSelectedMenuIndex(index);
        value.setSelectedChildMenuIndex(childIndex);
        value.setCurrentScreen(child.screen);
        context.read<DashboardProvider>().updateSelectedMenuTitle(child.name);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 4),
          Text(
            child.name,
            style: TextStyle(
              color: hoveredChildIndex == childIndex
                  ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                      ? AppColor.gradientColor2
                      : AppColor.baseColor
                  : isSelected
                      ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                          ? AppColor.mainColor.shade900
                          : AppColor.baseColor
                      : context.watch<MainProvider>().themeMode == ThemeMode.dark
                          ? AppColor.baseColor
                          : AppColor.mainColor.shade900,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            child.icon,
            color: hoveredChildIndex == childIndex
                ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                    ? AppColor.gradientColor2
                    : AppColor.baseColor
                : isSelected
                    ? context.watch<MainProvider>().themeMode == ThemeMode.dark
                        ? AppColor.mainColor.shade900
                        : AppColor.baseColor
                    : context.watch<MainProvider>().themeMode == ThemeMode.dark
                        ? AppColor.baseColor
                        : AppColor.mainColor.shade900,
          ),
        ],
      ),
    ),
  ),
)
;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  );
}
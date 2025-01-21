import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/Utils/custom_scroll_behavior.dart';
import 'package:shop/core/constants/app_color.dart';
import 'package:shop/core/di/di.dart';
import 'package:shop/main_provider.dart';
import 'package:shop/screens/login/login_screen.dart';

void main()async {
await di();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        )
      ],
      child: Consumer<MainProvider>(
        builder: (context, value, child) => MaterialApp(
          home: MyHomePage(),
          locale: const Locale('fa', 'IR'),
          supportedLocales: const [
            Locale('fa', 'IR'),
          ],

          localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

          debugShowCheckedModeBanner: false,
          title: 'پنل فروشندگان',
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'vazir',
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
            scaffoldBackgroundColor: AppColor.baseColor,
            useMaterial3: true,
            textTheme:
                TextTheme(bodyMedium: TextStyle(color: AppColor.darkContainer)),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            fontFamily: 'vazir',
            colorSchemeSeed: AppColor.darkBaseColor,
            scaffoldBackgroundColor: AppColor.gradientColor1,
            textTheme: TextTheme(
                bodyMedium: TextStyle(color: AppColor.lightContainer)),
          ),
          themeMode: value.themeMode,
          scrollBehavior: CustomScrollBehavior(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return LoginScreen();
  }
}

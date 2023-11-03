import 'package:siento_shop/common/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/router.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/common/widgets/bottom_bar.dart';
import 'package:siento_shop/pages/auth/screens/auth_screen.dart';
import 'package:siento_shop/pages/admin/screens/admin_screen.dart';
import 'package:siento_shop/pages/auth/services/auth_service.dart';
import 'package:siento_shop/pages/home/providers/search_provider.dart';
import 'package:siento_shop/pages/home/providers/filter_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SearchProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FilterProvider(),
    ),
  ], child: const MyApp()));
}

late Size mq;
late TextTheme myTextTheme;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Siento Shop',
            builder: (context, widget) {
              return Theme(
                data: MyTheme.getThemeData(isLight: true),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                ),
              );
            },
            onGenerateRoute: (settings) => generateRoute(settings),
            home: Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == 'user'
                    ? const BottomBar()
                    : const AdminScreen()
                : const AuthScreen(),
          );
        });
  }
}

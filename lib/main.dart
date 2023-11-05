import 'package:flutter/services.dart';
import 'package:siento_shop/components/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/pages/splash/splash_screen.dart';
import 'package:siento_shop/router.dart';
import 'package:siento_shop/providers/user_provider.dart';
import 'package:siento_shop/pages/home/providers/search_provider.dart';
import 'package:siento_shop/pages/home/providers/filter_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return MaterialApp(
            title: 'Siento Shop',
            debugShowCheckedModeBanner: false,
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
            home: const SplashScreen(),
          );
        });
  }
}

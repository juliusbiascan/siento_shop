import 'package:flutter/foundation.dart';
import 'package:siento_shop/components/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/pages/admin/screens/admin_screen.dart';
import 'package:siento_shop/pages/auth/screens/auth_screen.dart';
import 'package:siento_shop/pages/auth/services/auth_service.dart';
import 'package:siento_shop/pages/splash/widgets/splash_content.dart';
import '../../providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    if (kDebugMode) {
      print("\n\niniside splash screen initState");
    }
    authService.getUserData(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserData(context);
      if (kDebugMode) {
        print(
            "\n\n\nuser type splash init before future: ${Provider.of<UserProvider>(context, listen: false).user.type}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(
          "\n\n\nuser type splash build : ${Provider.of<UserProvider>(context, listen: true).user.type}");
    }
    return Scaffold(
        body: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Provider.of<UserProvider>(context, listen: false)
                              .user
                              .token
                              .isNotEmpty
                          ? Provider.of<UserProvider>(context, listen: false)
                                      .user
                                      .type ==
                                  'user'
                              ? const BottomBar()
                              : const AdminScreen()
                          : const AuthScreen(),
                ),
              );
            }),
            builder: (context, snapshot) {
              return const SplashContent(
                text: "Experience convenience at your fingertips",
                image: "assets/images/bottom_icons.jpg",
              );
            }));
  }
}

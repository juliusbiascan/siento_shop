import 'package:flutter/material.dart';

import 'package:siento_shop/constants/utils.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/components/widgets/custom_textfield.dart';
import 'package:siento_shop/pages/auth/services/auth_service.dart';

//enum signin, signup
enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //form keys for validation
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  // controllers of the textfields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // password controller for signUp
  final TextEditingController _passwordSUpController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  // password controller for signIn
  final TextEditingController _passwordSInController = TextEditingController();

  bool isSignIn = true;
  double opacityLvl = 1.0;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordSUpController.dispose();
    _confirmPasswordController.dispose();
    _passwordSInController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordSUpController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordSInController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return isSignIn
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: GlobalVariables.greyBackgroundColor,
              body: SafeArea(
                child: Container(
                  height: mq.height,
                  width: mq.width,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.loginPageGradient),
                  child: Padding(
                    padding: EdgeInsets.all(mq.width * .1),
                    child: SingleChildScrollView(
                      reverse: false,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/app_iconv2.png",
                                height: mq.height * .16,
                              ),
                            ),
                            SizedBox(height: mq.height * .03),
                            const Text("Welcome to Siento Shop",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                            SizedBox(height: mq.height * .05),
                            CustomTextField(
                                controller: _emailController,
                                hintText: "Email"),
                            SizedBox(height: mq.height * .025),
                            CustomTextField(
                                isObscureText: true,
                                controller: _passwordSInController,
                                hintText: "Password"),
                            SizedBox(height: mq.height * .04),
                            AnimatedOpacity(
                              opacity: opacityLvl,
                              duration: const Duration(seconds: 1),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    opacityLvl = 0.5;
                                  });
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  minimumSize: Size(mq.width, mq.height * 0.08),
                                ),
                                child: Text(
                                  "SIGN IN",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: mq.height * .015),
                            Divider(thickness: 3, color: Colors.grey.shade300),
                            SizedBox(height: mq.height * .015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Don't have an account?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                                SizedBox(width: mq.width * .012),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSignIn = !isSignIn;
                                    });
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decorationStyle:
                                            TextDecorationStyle.solid),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: GlobalVariables.greyBackgroundColor,
              body: SafeArea(
                child: Container(
                  height: mq.height,
                  width: mq.width,
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.loginPageGradient),
                  child: Padding(
                    padding: EdgeInsets.all(mq.width * .1),
                    child: SingleChildScrollView(
                      reverse: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset("assets/images/app_iconv2.png",
                                  height: mq.height * .16),
                            ),
                            SizedBox(height: mq.height * .03),
                            const Text("Create a new account",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                            SizedBox(height: mq.height * .03),
                            CustomTextField(
                                controller: _nameController, hintText: "Name"),
                            SizedBox(height: mq.height * .01),
                            CustomTextField(
                                controller: _emailController,
                                hintText: "Email"),
                            SizedBox(height: mq.height * .01),
                            CustomTextField(
                                isObscureText: true,
                                controller: _passwordSUpController,
                                hintText: "Password"),
                            SizedBox(height: mq.height * .01),
                            CustomTextField(
                                isObscureText: true,
                                controller: _confirmPasswordController,
                                hintText: "Confirm Password"),
                            SizedBox(height: mq.height * .04),
                            ElevatedButton(
                                onPressed: () {
                                  // ensuring form validation and matching passwords
                                  if (_signUpFormKey.currentState!.validate() &&
                                      _passwordSUpController.text ==
                                          _confirmPasswordController.text) {
                                    signUpUser();
                                    setState(() {
                                      isSignIn = !isSignIn;
                                    });
                                    // Navigator.pushReplacementNamed(
                                    //     context, AuthScreen.routeName);
                                  }
                                  if (_signUpFormKey.currentState!.validate() &&
                                      _passwordSUpController.text !=
                                          _confirmPasswordController.text) {
                                    showSnackBar(
                                        context: context,
                                        text: "Passwords do not match");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  minimumSize: Size(mq.width, mq.height * 0.08),
                                ),
                                child: Text(
                                  "REGISTER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                )),
                            SizedBox(height: mq.height * .015),
                            // Divider(thickness: 3, color: Colors.grey.shade300),
                            SizedBox(height: mq.height * .015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Already have an account?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                                SizedBox(width: mq.width * .012),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSignIn = !isSignIn;
                                    });
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decorationStyle:
                                            TextDecorationStyle.solid),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                                // this is new
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

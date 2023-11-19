import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:siento_shop/constants/constants.dart';
import 'package:siento_shop/constants/global_variables.dart';
import 'package:siento_shop/pages/account/services/account_services.dart';
import 'package:siento_shop/pages/account/widgets/orders.dart';
import 'package:siento_shop/pages/account/widgets/settings_item.dart';
import 'package:siento_shop/pages/account/widgets/top_buttons.dart';
import 'package:siento_shop/pages/search_delegate/my_search_screen.dart';
import 'package:siento_shop/providers/user_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _image;
  AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    Size mq = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          title: "Me",
          onClickSearchNavigateTo: const MySearchScreen()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
          children: [
            20.verticalSpace,
            Text('Account',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    )),
            20.verticalSpace,
            ListTile(
              title: Text(user.name,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 16.sp,
                  )),
              subtitle: Text(user.email),
              leading: CircleAvatar(
                radius: 30.r,
                backgroundColor: theme.primaryColor,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * 0.1),
                      //display profile picture
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: user.imageUrl == null ||
                                user.imageUrl == ""
                            ? const NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnWaCAfSN08VMtSjYBj0QKSfHk4-fjJZCOxgHLPuBSAw&s")
                            : NetworkImage(user.imageUrl!),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _showBottomSheet();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        padding: EdgeInsets.all(mq.height * .003),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SvgPicture.asset(Constants.forwardArrowIcon,
                    fit: BoxFit.none),
              ),
            ),
            SizedBox(height: mq.width * .025),
            const TopButtons(),
            SizedBox(height: mq.width * .045),
            const Orders(),
            30.verticalSpace,
            Text('Settings',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                    )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Language',
              icon: Constants.languageIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
            ),
            25.verticalSpace,
            ListTile(
              title: Text("Sign Out",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 16.sp,
                  )),
              leading: CircleAvatar(
                radius: 25.r,
                backgroundColor: theme.primaryColor,
                child: SvgPicture.asset(Constants.logoutIcon, fit: BoxFit.none),
              ),
              trailing: InkWell(
                onTap: () => AccountServices().logOut(context),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SvgPicture.asset(Constants.forwardArrowIcon,
                      fit: BoxFit.none),
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Size mq = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          //container won't render the borderradius as it will paint its color over it
          //hence use something else other than container
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: mq.height * 0.008, bottom: mq.height * 0.03),
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * 0.005, horizontal: mq.width * 0.4),
                height: mq.height * 0.007,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(mq.width * 0.01)),
              ),
              SizedBox(height: mq.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Pick Profile Photo",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  SizedBox(width: mq.width * 0.02),
                  //tooltip suggesting maximum file size 100KB
                  const Tooltip(
                      message: "Maximum File Size is 100KB",
                      child: Icon(Icons.info_rounded))
                ],
              ),
              SizedBox(height: mq.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick photo from gallery
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image.
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              //reducing image quality to 70, ranges from 0-100
                              imageQuality: 70,
                            );

                            //size in KB
                            // final fileBytes =
                            //     File(_image!).readAsBytesSync().lengthInBytes /
                            //         1024;
                            // int size in KB
                            // final int intFileBytes = fileBytes.toInt();
                            // print(
                            //     "===> File Size in kB : $intFileBytes KB, in MB :${(intFileBytes / 1048576)} MB");
                            if (image != null) {
                              setState(() {
                                _image = image.path;
                              });

                              if (context.mounted) {
                                accountServices.addProfilePicture(
                                    context: context,
                                    imagePicked: File(_image!));

                                // function here
                                // APIs.updateProfilePicture(File(_image!));

                                //hiding bottomsheet
                                Navigator.pop(context);
                                // showSnackBar(
                                //     context: context,
                                //     text: "Profile Picture updated successfully!");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              fixedSize:
                                  Size(mq.width * 0.25, mq.height * 0.15)),
                          child: Image.asset("assets/images/gallery.png")),
                      const Text("Gallery"),
                    ],
                  ),

                  //pick photo from camera
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image.
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera);

                            if (image != null) {
                              setState(() {
                                _image = image.path;
                              });

                              if (context.mounted) {
                                accountServices.addProfilePicture(
                                    context: context,
                                    imagePicked: File(_image!));

                                //hiding bottomSheet
                                Navigator.pop(context);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              fixedSize:
                                  Size(mq.width * 0.25, mq.height * 0.15)),
                          child: Image.asset("assets/images/camera.png")),
                      const Text("Camera"),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }
}

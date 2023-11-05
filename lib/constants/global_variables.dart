import 'package:google_fonts/google_fonts.dart';
import 'package:siento_shop/components/widgets/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String uri = 'https://lively-pike-tux.cyclic.app';
//String uri = kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216)
    ],
    stops: [0.5, 1.0],
  );

  // STATIC IMAGES
  static const List<String> carouselImages = [
    "https://res.cloudinary.com/dcyjzfazz/image/upload/v1698844561/Carousel/noxnvpwe7gzge1nxnyl7.png",
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobile-svg.svg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials-svg.svg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances-svg.svg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books-svg.svg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion-svg.svg',
    },
  ];

  static Route createRoute(Widget className) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => className,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static AppBar getAppBar(
      {required BuildContext context,
      required dynamic onClickSearchNavigateTo,
      bool? wantBackNavigation = true,
      bool? wantActions = true,
      String? title = "",
      double? dividerEndIndent}) {
    Size mq = MediaQuery.of(context).size;
    return AppBar(
      title: ScreenTitle(
        title: '$title',
        dividerEndIndent: dividerEndIndent,
      ),
      iconTheme: Theme.of(context).iconTheme,
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: wantActions!
          ? [
              Padding(
                padding: EdgeInsets.only(right: mq.width * 0.035),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(createRoute(onClickSearchNavigateTo));
                      },
                      child: SvgPicture.asset("assets/images/search-svg.svg",
                          height: 25,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn)),
                    ),
                  ],
                ),
              ),
            ]
          : [],
    );
  }

  static AppBar getAdminAppBar({
    required BuildContext context,
    String? title = "",
  }) {
    Size mq = MediaQuery.of(context).size;
    return AppBar(
      title: Text("$title", maxLines: 1, overflow: TextOverflow.ellipsis),
      iconTheme: const IconThemeData(color: Colors.black),
      // automaticallyImplyLeading: true,
      leading: Padding(
        padding: EdgeInsets.all(mq.width * .025).copyWith(right: 0),
        child: InkWell(
          onTap: () {},
          child: Image.asset(
            "assets/images/app_icon.png",
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        TextButton(
            onPressed: () {},
            child: Text(
              "Admin",
              style: GoogleFonts.poppins(fontSize: 16),
            ))
      ],
    );
  }
}

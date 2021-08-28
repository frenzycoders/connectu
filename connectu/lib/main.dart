import 'package:connectu/Screens/addContact.screen.dart';
import 'package:connectu/Screens/archive.screen.dart';
import 'package:connectu/Screens/join.screen.dart';
import 'package:connectu/Screens/main.screen.dart';
import 'package:connectu/Screens/otpVerify.screen.dart';
import 'package:connectu/Screens/profile.screen.dart';
import 'package:connectu/Screens/search.screen.dart';
import 'package:connectu/Screens/settings/main.settings.screen.dart';
import 'package:connectu/Screens/splash.screen.dart';
import 'package:connectu/core/binding/user_binding.dart';
import 'package:connectu/utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(ConnectU());
}

class ConnectU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: CustomThemes.appName,
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          binding: UserBinding(),
        ),
        GetPage(
          name: '/join-user',
          page: () => JoinScreen(),
          binding: UserBinding(),
        ),
        GetPage(name: '/otp-verification', page: () => OtpVerificationScreen()),
        GetPage(name: '/home', page: () => MainScreen()),
        GetPage(name: '/archive-chats', page: () => ArchiveScreen()),
        GetPage(name: '/search-screen', page: () => SearchScreen()),
        GetPage(name: '/add-friend', page: () => AddFriendScreen()),
        GetPage(
            name: '/general-profile-screen',
            page: () => GeneralProfileScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen())
      ],
      initialRoute: '/splash',
    );
  }
}

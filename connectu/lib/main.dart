import 'package:connectu/Screens/Chats/main.chats.screen.dart';
import 'package:connectu/Screens/addContact.screen.dart';
import 'package:connectu/Screens/archive.screen.dart';
import 'package:connectu/Screens/join.screen.dart';
import 'package:connectu/Screens/main.screen.dart';
import 'package:connectu/Screens/otpVerify.screen.dart';
import 'package:connectu/Screens/permission.screen.dart';
import 'package:connectu/Screens/profile.screen.dart';
import 'package:connectu/Screens/search.screen.dart';
import 'package:connectu/Screens/settings/main.settings.screen.dart';
import 'package:connectu/Screens/splash.screen.dart';
import 'package:connectu/core/bindings/chatsBinding.dart';
import 'package:connectu/core/bindings/contactBinding.dart';
import 'package:connectu/core/bindings/RTCbinding.dart';
import 'package:connectu/core/bindings/hiveBindings.dart';
import 'package:connectu/core/models/hiveChats.dart';
import 'package:connectu/core/models/hiveContact.dart';
import 'package:connectu/core/models/hiveFriends.dart';
import 'package:connectu/core/models/hiveLastMessage.dart';
import 'package:connectu/core/models/hiveProfile.dart';
import 'package:connectu/utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/bindings/user_binding.dart';

void main() async {
  await Hive.initFlutter();
  String profile = 'profile';
  String chats = 'chats';
  String friends = 'friends';
  String contacts = 'contacts';
  String lastMessage = 'lastMessage';
  Hive.registerAdapter(ProfileAdapter());
  await Hive.openBox<Profile>(profile);
  Hive.registerAdapter(ChatsAdapter());
  await Hive.openBox<Chats>(chats);
  Hive.registerAdapter(LastMessageAdapter());
  await Hive.openBox<LastMessage>(lastMessage);
  Hive.registerAdapter(FriendAdapter());
  await Hive.openBox<Friend>(friends);
  Hive.registerAdapter(HiveContcatsAdapter());
  await Hive.openBox<HiveContcats>(contacts);
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
          bindings: [
            HiveBinding(),
            UserBinding(),
          ],
        ),
        GetPage(
          name: '/join-user',
          page: () => JoinScreen(),
        ),
        GetPage(
          name: '/otp-verification',
          page: () => OtpVerificationScreen(),
        ),
        GetPage(name: '/permission-screen', page: () => PermissionScreen()),
        GetPage(name: '/home', page: () => MainScreen(), bindings: [
          RTCbinding(),
          ContactBinding(),
          ChatsBinding(),
        ]),
        GetPage(name: '/archive-chats', page: () => ArchiveScreen()),
        GetPage(name: '/search-screen', page: () => SearchScreen()),
        GetPage(name: '/add-friend', page: () => AddFriendScreen()),
        GetPage(name: '/chats-screen', page: () => ChatScreen()),
        GetPage(
            name: '/general-profile-screen',
            page: () => GeneralProfileScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen())
      ],
      initialRoute: '/splash',
    );
  }
}

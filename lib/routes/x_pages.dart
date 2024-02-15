import 'package:chat_x/bindings/auth_binding.dart';
import 'package:chat_x/view/pages/home_page.dart';
import 'package:chat_x/view/pages/login_page.dart';
import 'package:chat_x/view/pages/singup_page.dart';
import 'package:chat_x/view/pages/splash_page.dart';
import 'package:get/get.dart';

import '../bindings/home_binding.dart';

class AppPages {
  static const String intital = '/';
  static const String login = '/login';
  static const String homepage = '/home';
  static const String singup = '/signup';
  static const String chatPage = '/chat';

  static final routes = [
    GetPage(name: '/', page: ()=>const SplashPage(), binding: AuthBinding()),
    GetPage(name: '/login', page: ()=>LoginPage(),),
    GetPage(name: '/signup', page: ()=>SignupPage(),),
    GetPage(name: '/home', page: ()=>const HomePage(), binding: HomeBinding()),

  ];
}
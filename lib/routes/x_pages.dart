import 'package:chat_x/bindings/login_binding.dart';
import 'package:chat_x/bindings/singup_binding.dart';
import 'package:chat_x/services/auth_services/auth_gate.dart';
import 'package:chat_x/view/pages/chat_page.dart';
import 'package:chat_x/view/pages/home_page.dart';
import 'package:chat_x/view/pages/login_page.dart';
import 'package:chat_x/view/pages/singup_page.dart';
import 'package:chat_x/view/pages/splash_page.dart';
import 'package:get/get.dart';

import '../bindings/home_binding.dart';
import '../bindings/splash_binding.dart';

class AppPages {
  static const String intital = '/';
  static const String login = '/login';
  static const String authGate = '/auth';
  static const String homepage = '/home';
  static const String singup = '/signup';
  static const String chatPage = '/chat';

  static final routes = [
    GetPage(name: '/', page: ()=>SplashPage(), binding: SplashBinding()),
    GetPage(name: '/auth', page: ()=>AuthGate(),),
    GetPage(name: '/login', page: ()=>LoginPage(), binding: LoginBinding()),
    GetPage(name: '/signup', page: ()=>SignupPage(), binding: SignupBinding()),
    GetPage(name: '/home', page: ()=>HomePage(), binding: HomeBinding()),
    GetPage(name: '/chat', page: ()=>ChatPage(receiverEmail: '', receiverId: '',),)

  ];
}
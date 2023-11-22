import 'package:chat_app/features/add_room/view/add_room_view.dart';
import 'package:chat_app/features/auth/view/login/login_view.dart';
import 'package:chat_app/features/auth/view/register/register_view.dart';
import 'package:chat_app/features/chat/view/chat_view.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/features/room_intro/view/room_intro_view.dart';
import 'package:chat_app/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  late String route;
  await SharedPrefUtils.init();
  var userName = SharedPrefUtils.getData("userName");
  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (userName == null) {
    route = LoginView.routeName;
  } else {
    route = HomeView.routeName;
  }
  runApp(MyApp(
    route: route,
  ));
}

class MyApp extends StatelessWidget {
  final String route;

  const MyApp({super.key, required this.route});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 943),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            initialRoute: route,
            routes: {
              RegisterView.routeName: (context) => const RegisterView(),
              LoginView.routeName: (context) => const LoginView(),
              HomeView.routeName: (context) => const HomeView(),
              AddRoomView.routeName: (context) => const AddRoomView(),
              RoomIntroView.routeName: (context) => const RoomIntroView(),
              ChatView.routeName: (context) => const ChatView(),
            },
          );
        });
  }
}

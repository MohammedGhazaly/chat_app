import 'package:chat_app/features/add_room/view/add_room_view.dart';
import 'package:chat_app/features/auth/view/login/login_view.dart';
import 'package:chat_app/features/auth/view/register/register_view.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            ),
            initialRoute: HomeView.routeName,
            routes: {
              RegisterView.routeName: (context) => const RegisterView(),
              LoginView.routeName: (context) => const LoginView(),
              HomeView.routeName: (context) => const HomeView(),
              AddRoomView.routeName: (context) => const AddRoomView(),
            },
          );
        });
  }
}

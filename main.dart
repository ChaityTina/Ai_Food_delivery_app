import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import all screens
import 'screens/menu_v1.dart';
import 'screens/menu_v2.dart';
import 'screens/menu_v3.dart';
import 'screens/notifications.dart';
import 'screens/callscreen.dart';
import 'screens/chatscreen.dart';
import 'screens/chatlist.dart';
import 'screens/paymentscreen.dart';
import 'screens/profile.dart';
import 'screens/personal_data.dart';
import 'screens/add_card_v2.dart';
import 'screens/settings.dart';
import 'screens/selectlanguage.dart';
import 'screens/help_center.dart';
import 'screens/extraCard.dart';
import 'screens/register.dart';
import 'screens/loginfield.dart';
import 'screens/search_v3.dart';
import 'screens/onboarding_screen1.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/onboarding_screen3.dart';
import 'screens/change_password_page.dart';
import 'screens/otp_field.dart';
import 'screens/registerapp.dart';
import 'screens/delivery.dart';
import 'screens/order.dart';
import 'screens/order_v2.dart';
import 'screens/order_empty.dart';
import 'screens/forget_password_screen.dart';
import 'screens/success_page.dart';
import 'screens/bottom_navigation.dart';
import 'screens/add_food_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Food Delivery App',

      // First screen
      home: const InitialScreen(),

      // Named routes
      routes: {
        '/home': (context) => const BottomNavigation(),
        '/menu2': (context) => const menu_v2(),
        '/menu3': (context) => const menu_v3(),
        '/notifications': (context) => const notifications(),
        //call': (context) => const callscreen(),
        // '/chat': (context) => const chatscreen(),
        '/chatlist': (context) => const ChatList(),
        '/profile': (context) => const profile(),
        '/personal': (context) => const PersonalData(),
        '/addcard': (context) => const add_card_v2(),
        '/settings': (context) => const settings(),
        '/language': (context) => const selectlanguage(),
        '/help': (context) => const help_center(),
        '/extra': (context) => const extraCard(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginField(),
        '/drawer': (context) => const SearchV3(),
        '/onboarding1': (context) => const onboarding_screen1(),
        '/onboarding2': (context) => const onboarding_screen2(),
        '/onboarding3': (context) => const onboarding_screen3(),
        '/changepassword': (context) => const change_password_page(),
        '/otp': (context) => const otp_field(),
        '/registerapp': (context) => const registerapp(),
        '/order': (context) => const OrderPage(),
        '/order2': (context) => const order_v2(),
        '/orderempty': (context) => const order_empty(),
        '/forget': (context) => const ForgetPasswordScreen(),
        '/success': (context) => const success_page(),
        '/addfood': (context) => const AddFoodPage(),
      },
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isNewUser = true; // Replace with actual logic

    if (isNewUser) {
      return const onboarding_screen1();
    } else {
      return const BottomNavigation();
    }
  }
}

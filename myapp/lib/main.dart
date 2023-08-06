import 'package:flutter/material.dart';
import 'package:myapp/screens/auth_page.dart';
import 'package:myapp/screens/booking_page.dart';
import 'package:myapp/screens/doctor_details.dart';
import 'package:myapp/screens/favorite_page.dart';
import 'package:myapp/screens/success_booked.dart';
import 'package:myapp/screens/user_profile.dart';
import 'package:myapp/utils/config.dart';
import 'package:myapp/utils/main_layout.dart';

void main() {
  runApp(const MyApp());
  // MaterialApp(home: LoginPage(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF35578B),
        ),
        inputDecorationTheme: InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF35578B),
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey,
            elevation: 10,
            type: BottomNavigationBarType.fixed),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        'main': (context) => MainLayout(),
        'doc_details': (context) => DoctorDetails(),
        'booking_page': (context) => BookingPage(),
        'success_page': (context) => AppointmentBooked(),
        'user_profile': (context) => UserProfile(),
        'fav_page': (context) => FavPage()
      },
    );
  }
}

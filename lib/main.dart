import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/providers/booking_provider.dart';
import 'package:project/providers/bookng_provider_v2.dart';
import 'package:project/providers/timeslot_provider.dart';
import 'package:project/screens/book/booking.dart';
import 'package:project/screens/history/history.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/home/booking_list/booking_list_page.dart';
import 'package:project/screens/home/coin/coin_page.dart';
import 'package:project/screens/profile/profile.dart';
import 'package:project/screens/timeslot/timeslot_view.dart';
import 'package:provider/provider.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'screens/login/login.dart';

void main() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  // Enable Widget Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize [FIREBASE] //
  await Firebase.initializeApp(); //firebase see app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => BookingProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => BookingProviderV2(),
            ),
            ChangeNotifierProvider(
              create: (_) => TimeSlotProvider(),
            ),
          ],
          child: MaterialApp(
            home: Home(),
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            // ),

            theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue).copyWith(
              textTheme: GoogleFonts.mitrTextTheme(),
            ),
            darkTheme:
                FlexThemeData.dark(scheme: FlexScheme.bahamaBlue).copyWith(
              textTheme: GoogleFonts.mitrTextTheme(),
            ),
            // initialRoute: '/',
            // routes: {
            //   '/': (context) => Login(),
            //   '/home': (context) => Home(),
            //   '/home/coin': (context) => CoinPage(),
            //   '/home/booking_list': (context) => BookingListPage(),
            //   '/booking': (context) => BookingPage(),
            //   '/history': (context) => HistoryPage(),
            //   '/profile': (context) => ProfilePage(),
            // },
          ),
        );
      },
    );
  }
}

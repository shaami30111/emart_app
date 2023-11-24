import 'dart:io';

import 'package:ai_art_gen/provider/selection_provider.dart';
import 'package:ai_art_gen/theme/theme.dart';
import 'package:ai_art_gen/ui_screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

AppDatabase? db;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = AppDatabase();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
  );
  ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    // Set the system overlay style to remove the safe area shadow
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark, // Adjust icon color
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SelectionProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(720, 1500),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: darkTheme,
          // darkTheme: darkTheme,
          home: const SplashScreen(),
          // home: HomePage(),
        ),
      ),
    );
  }
}

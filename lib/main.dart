import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'pages/landingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CourtSide',
      theme: ThemeData(
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return Color(0xff000000);
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xff43f5bf), width: 2.0),
              );
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return Color(0xff43f5bf);
            }),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused))
                return Color(0xff43f5bf);
              return Color(0xff000000);
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xff43f5bf), width: 2.0),
              );
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return Color(0xff43f5bf);
            }),
          ),
        ),
        primarySwatch: Colors.teal,
        primaryColor: Color(0xff000000),
        primaryColorLight: Color(0xff43f5bf),
        primaryColorDark: Color(0xff43f5bf),
        canvasColor: Color(0xff000000),
        scaffoldBackgroundColor: Color(0xff000000),
        cardColor: Color(0xff343b45),
        dividerColor: Color(0xff272727),
        highlightColor: Color(0xff43f5bf),
        splashColor: Color(0xff43f5bf),
        secondaryHeaderColor: Color(0xffffffff),
        textTheme: GoogleFonts.getTextTheme(
            "Roboto",
            const TextTheme(
              displayLarge: TextStyle(
                color: Color(0xffffffff),
              ),
              displayMedium: TextStyle(
                color: Color(0xffffffff),
              ),
              displaySmall: TextStyle(
                color: Color(0xffffffff),
              ),
              headlineMedium: TextStyle(
                color: Color(0xffffffff),
              ),
              headlineSmall: TextStyle(
                color: Color(0xffffffff),
              ),
              titleLarge: TextStyle(
                color: Color(0xffffffff),
              ),
              labelSmall: TextStyle(
                color: Color(0xffffffff),
              ),
              titleMedium: TextStyle(
                color: Color(0xffffffff),
              ),
              titleSmall: TextStyle(
                color: Color(0xffffffff),
              ),
              bodyLarge: TextStyle(
                color: Color(0xffffffff),
              ),
              bodyMedium: TextStyle(
                color: Color(0xffffffff),
              ),
              labelLarge: TextStyle(
                color: Color(0xff43f5bf),
              ),
              bodySmall: TextStyle(
                color: Color(0xff43f5bf),
              ),
            )),
      ),
      home: LandingPage(),
    );
  }
}

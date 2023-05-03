import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'components/constunts.dart';
import 'layout/home_page.dart';
import 'models/tasks_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(TasksAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Tasks>('tasksBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      theme: ThemeData(
          primaryColor: colorPrimary,
          textTheme: TextTheme(
              displayLarge: GoogleFonts.dmSans(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: colorDarkBlue),
              displayMedium: GoogleFonts.dmSans(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorDarkBlue),
              titleLarge: GoogleFonts.dmSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorDarkBlue),
              titleMedium: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorDarkBlue),
              bodyMedium: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colorDarkBlue),
              labelMedium:
                  GoogleFonts.dmSans(fontSize: 14, color: colorDarkGrey),
              labelSmall: GoogleFonts.dmSans(
                fontSize: 12,
              )),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  const EdgeInsetsDirectional.only(start: 15, top: 30, end: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          iconTheme: const IconThemeData(size: 28),
          buttonTheme: ButtonThemeData(
            buttonColor: colorPrimary,
            disabledColor: colorGrey,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
              backgroundColor: colorPrimary),
          bottomSheetTheme: BottomSheetThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
              backgroundColor: MaterialStatePropertyAll(colorPrimary),
            ),
          )),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

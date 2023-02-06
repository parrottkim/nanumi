import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Pretendard',
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[100],
  splashColor: Colors.transparent,
  highlightColor: Colors.black.withOpacity(0.1),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
  ).copyWith(
    primary: Colors.black,
    secondary: Color(0xFF669F85),
    onSecondary: Color(0xFF3B4E52),
    tertiary: Colors.white,
  ),
  // textTheme: TextTheme(
  //   headlineLarge: TextStyle(
  //     fontFamily: 'JoyrideSTD',
  //     fontSize: 64.0,
  //   ),
  //   // 타이틀
  //   titleLarge: TextStyle(
  //     fontFamily: 'JoyrideSTD',
  //     fontSize: 40.0,
  //   ),
  //   // 서브 타이틀
  //   displayLarge: TextStyle(
  //     fontSize: 24.0,
  //   ),
  //   // 상단 텍스트 버튼
  //   labelLarge: TextStyle(
  //     fontWeight: FontWeight.w400,
  //     fontSize: 14.0,
  //   ),
  //   // 본문
  //   bodyLarge: TextStyle(
  //     fontSize: 18.0,
  //   ),
  // ).apply(
  //   displayColor: Colors.black,
  //   bodyColor: Colors.black,
  // ),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Color(0xFF3B4E52),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    textTheme: ButtonTextTheme.primary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: Size.zero,
      padding: EdgeInsets.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.teal),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF3B4E52),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey[850],
    selectedTileColor: Colors.grey[200],
  ),
  canvasColor: Colors.blueGrey[100],
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Pretendard',
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.grey[100],
  splashColor: Colors.transparent,
  highlightColor: Colors.black.withOpacity(0.1),
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    backgroundColor: Colors.white,
  ).copyWith(
    primary: Colors.white,
    secondary: Color(0xFF669F85),
    onSecondary: Color(0xFF3B4E52),
    tertiary: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Color(0xFF3B4E52),
    ),
  ),
  textTheme: TextTheme().apply(
    bodyColor: Colors.white60,
    displayColor: Colors.white60,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.teal,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.teal),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF3B4E52),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white60,
    selectedTileColor: Colors.grey[800],
  ),
  canvasColor: Colors.blueGrey[800],
);

final themeProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, darkTheme);
  }
}

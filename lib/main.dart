import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nanumi/constants/routes.dart';
import 'package:nanumi/firebase_options.dart';
import 'package:nanumi/pages/home/home_page.dart';
import 'package:nanumi/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'nanumi',
      theme:
          ref.watch(themeProvider.notifier).darkTheme ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: routes,
    );
  }
}

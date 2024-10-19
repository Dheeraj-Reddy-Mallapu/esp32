import 'package:esp32/constants.dart';
import 'package:esp32/data/logic/auth_provider.dart';
import 'package:esp32/firebase_options.dart';
import 'package:esp32/presentation/pages/home_page.dart';
import 'package:esp32/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme({bool isDark = false}) => ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: isDark ? Brightness.dark : Brightness.light,
        );

    final user = ref.watch(userNotifierProvider);

    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData.from(colorScheme: colorScheme(), useMaterial3: true),
      darkTheme: ThemeData.from(
          colorScheme: colorScheme(isDark: true), useMaterial3: true),
      home: user != null ? const HomePage() : const LoginPage(),
    );
  }
}

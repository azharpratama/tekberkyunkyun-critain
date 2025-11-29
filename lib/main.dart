import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'screens/home-page.dart';
import 'screens/perpustakaan-cerita.dart';
import 'screens/dashboard.dart';
import 'screens/home_screen.dart';
import 'screens/mentor_screen.dart';
import 'screens/team_screen.dart';
import 'screens/maps_screen.dart';
import 'screens/testimonials_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await dotenv.load(fileName: ".env");

  // await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  // );

  runApp(const MyApp());
}

// final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceritain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/perpustakaan-cerita': (context) => const PerpustakaanCerita(),
        '/dashboard': (context) => const DashboardScreen(title: 'Dashboard'),
        '/home_screen': (context) => const HomeScreen(title: 'Home Screen'),
        '/mentor_screen': (context) => const MentorScreen(),
        '/team_screen': (context) => const TeamScreen(),
        '/maps_screen': (context) => const MapsScreen(),
        '/testimonials_screen': (context) => const TestimonialsScreen(),
      },
    );
  }
}

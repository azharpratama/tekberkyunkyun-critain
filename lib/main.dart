import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:critain/screens/perpustakaan-cerita.dart';
import 'package:critain/screens/home_page.dart';
import 'package:critain/screens/home_screen.dart';
import 'package:critain/screens/dashboard.dart' as Dashboard;
import 'package:critain/screens/maps_screen.dart';
import 'package:critain/screens/mentor_screen.dart';
import 'package:critain/screens/team_screen.dart';
import 'package:critain/screens/testimonials_screen.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Load environment variables from .env file
  // await dotenv.load(fileName: ".env");

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
      debugShowCheckedModeBanner: false,
      title: 'Critain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/perpustakaan-cerita': (context) => const PerpustakaanCerita(),
        '/home-screen': (context) => const HomeScreen(title: 'Home Screen'),
        '/dashboard': (context) => const Dashboard.HomeScreen(title: 'Dashboard'),
        '/maps': (context) => const MapsScreen(),
        '/mentor': (context) => const MentorScreen(),
        '/team': (context) => const TeamScreen(),
        '/testimonials': (context) => const TestimonialsScreen(),
      },
    );
  }
}
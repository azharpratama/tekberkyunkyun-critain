import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'viewmodels/profile_viewmodel.dart';

import 'screens/startup/splash_screen.dart';
import 'screens/main/home_page.dart';
import 'screens/features/ruang_bercerita/ruang_bercerita_screen.dart';
import 'screens/features/profile/profile_screen.dart';
import 'screens/features/affirmation/affirmation_screen.dart';
import 'screens/features/perpustakaan_cerita/perpustakaan_cerita_screen.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

import 'screens/general/faq_page.dart';
import 'screens/general/testimonials_screen.dart';
import 'screens/general/privacy_security_screen.dart';
import 'screens/general/about_us_screen.dart';
import 'screens/general/about_app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Supabase.initialize(
    url: "https://oqrzburvfyezlbzjjifz.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xcnpidXJ2ZnllemxiempqaWZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5MDcxNTgsImV4cCI6MjA4MDQ4MzE1OH0.iDrUxDUKN2T9Ug5ckbjYtJup0srPbkGb4waPQ1des74",
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MaterialApp(
        title: 'Ceritain',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomePage(),
          '/story': (context) => const RuangBerceritaScreen(),
          '/affirmation': (context) => const AffirmationScreen(),
          '/explore': (context) => const PerpustakaanCeritaScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/faq': (context) => const FAQPage(),
          '/testimonials_screen': (context) => const TestimonialsScreen(),
          '/privacy_security': (context) => const PrivacySecurityScreen(),
          '/about_us': (context) => const AboutUsScreen(),
          '/about_app': (context) => const AboutAppScreen(),
        },
      ),
    );
  }
}

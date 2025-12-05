import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
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
        },
      ),
    );
  }
}

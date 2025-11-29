import 'package:flutter/material.dart';
import 'screens/fitur_utama.dart';
import 'screens/ruang_afirmasi.dart';
import 'screens/ruang_bercerita.dart';
import 'screens/perpustakaan_cerita.dart';
import 'screens/quotes_screen.dart';
import 'screens/packages.dart';

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Critain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const RuangAfirmasiPage(),
    const RuangBerceritaPage(),
    const PerpustakaanCeritaPage(),
    const QuotesScreen(),
    const PackagesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Afirmasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Bercerita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Pustaka',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Paket',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        onTap: _onItemTapped,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

// Model Data Quotes
class Quote {
  final String quoteText;
  final String author;
  const Quote(this.quoteText, this.author);
}

// Data dummy untuk 3 quotes
const List<Quote> _initialQuotes = [
  Quote(
      "Self-care is not a luxury. It's a necessity. Without it, we cannot be our best selves.",
      "- Unknown"),
  Quote(
      "Your present circumstances don't determine where you can go; they merely determine where you start.",
      "— Nido Qubein"),
  Quote("The journey of a thousand miles begins with a single step.",
      "— Lao Tzu"),
];

class DailyQuoteCard extends StatefulWidget {
  const DailyQuoteCard({super.key});

  @override
  State<DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends State<DailyQuoteCard> {
  late PageController _pageController;
  late List<Quote> _currentQuotes;

  // Total quotes ditambah 1 untuk kotak kosong
  int get _totalItems => _currentQuotes.length + 1;

  @override
  void initState() {
    super.initState();
    _currentQuotes = List.from(_initialQuotes);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _reloadQuotes() {
    setState(() {
      _currentQuotes = List.from(_initialQuotes);
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Widget untuk membangun Kartu Quote
  Widget _buildQuoteItem(int index) {
    if (index == _totalItems - 1) {
      return _buildEmptyBox();
    }

    final quote = _currentQuotes[index];

    return Card(
      elevation: 4,
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.format_quote, color: Colors.white.withOpacity(0.8)),
                const SizedBox(width: 8),
                Text('Quote Hari Ini',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                quote.quoteText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                quote.author,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Kotak Kosong (Garis Solid Tipis sebagai pengganti dashed)
  Widget _buildEmptyBox() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.5),
          // FIX: Menggunakan solid dan width tipis sebagai pengganti dashed
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Quotes hari ini sudah habis!",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _reloadQuotes,
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text("Muat Ulang Quotes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _totalItems,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildQuoteItem(index),
          );
        },
      ),
    );
  }
}

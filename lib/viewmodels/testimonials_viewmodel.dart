import 'package:flutter/material.dart';
import '../models/testimonial.dart';

class TestimonialsViewModel extends ChangeNotifier {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  double _currPageValue = 0.0;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  double get currPageValue => _currPageValue;

  final List<Testimonial> _testimonials = const [
    Testimonial(
      name: 'George J - Widodo',
      quote:
          'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
      imagePath: 'assets/george_widodo_photo.png',
    ),
    Testimonial(
      name: 'George J - Widodo',
      quote:
          'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
      imagePath: 'assets/george_widodo_photo.png',
    ),
    Testimonial(
      name: 'George J - Widodo',
      quote:
          'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
      imagePath: 'assets/george_widodo_photo.png',
    ),
  ];

  List<Testimonial> get testimonials => _testimonials;

  TestimonialsViewModel() {
    _pageController.addListener(() {
      _currPageValue = _pageController.page!;
      _currentPage = _currPageValue.round();
      notifyListeners();
    });
  }

  void nextPage() {
    if (_currentPage < _testimonials.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

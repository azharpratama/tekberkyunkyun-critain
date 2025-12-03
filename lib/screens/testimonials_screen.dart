import 'package:flutter/material.dart';

const String _backgroundAsset = 'assets/maps_background.png';
const String _personImage = 'assets/george_widodo_photo.png';
const Color _greenColor = Color(0xFF5AB664);
const Color _orangeColor = Color(0xFFF18E5E);

class Testimonial {
  final String quote;
  final String name;
  final String imagePath;

  const Testimonial(
      {required this.quote, required this.name, required this.imagePath});
}

const List<Testimonial> testimonialsData = [
  Testimonial(
    name: 'George J - Widodo',
    quote:
        'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
    imagePath: _personImage,
  ),
  Testimonial(
    name: 'George J - Widodo',
    quote:
        'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
    imagePath: _personImage,
  ),
  Testimonial(
    name: 'George J - Widodo',
    quote:
        'Selamat, dan Sukses. Lorem ipsum dolor sit amet consectetur. Convallis est urna adipiscing fringilla nulla diam lorem non mauris. Ultrices aliquet at quam adipiscing feugiat interdum mattis.',
    imagePath: _personImage,
  ),
];

class TestimonialsScreen extends StatefulWidget {
  const TestimonialsScreen({super.key});

  @override
  State<TestimonialsScreen> createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  final double _viewportFraction = 0.8;
  final double _scaleFactor = 0.8;

  double _currPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _viewportFraction);

    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
        _currentPage = _currPageValue.round();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = _pageController.initialPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < testimonialsData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildTestimonialCard(int index) {
    Matrix4 matrix = Matrix4.identity();
    double scale = 1.0;

    double diff = index - _currPageValue;

    scale = 1 - (diff.abs() * (1 - _scaleFactor));

    if (diff.abs() >= 1.0) {
      scale = _scaleFactor;
    }

    matrix = Matrix4.diagonal3Values(1.0, scale, 1.0);

    final testimonial = testimonialsData[index];

    return Transform(
      transform: matrix,
      alignment: Alignment.center,
      child: Container(
        height: 300 * scale,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF5AB664), Color(0xFF009C5C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(testimonial.imagePath),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              testimonial.quote,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              testimonial.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: const AssetImage(_backgroundAsset),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Testimonials',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _greenColor,
                  ),
                ),
                const Text(
                  'Healing Words Testimonials from\na Mental Health Consultant',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: _greenColor,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 380,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: testimonialsData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildTestimonialCard(index);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: _currentPage > 0 ? 1.0 : 0.4,
                    child: _buildNavButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: _currentPage > 0 ? _previousPage : null,
                    ),
                  ),
                  Opacity(
                    opacity:
                        _currentPage < testimonialsData.length - 1 ? 1.0 : 0.4,
                    child: _buildNavButton(
                      icon: Icons.arrow_forward_ios,
                      onPressed: _currentPage < testimonialsData.length - 1
                          ? _nextPage
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildNavButton({required IconData icon, VoidCallback? onPressed}) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: onPressed != null
          ? _orangeColor
          : _orangeColor.withValues(alpha: 0.5),
      shape: BoxShape.circle,
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20),
    ),
  );
}

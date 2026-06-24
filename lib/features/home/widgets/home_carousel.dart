import 'package:flutter/material.dart';
import 'dart:async';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _currentPage = 0;

  final List<_CarouselSlide> slides = const [
    _CarouselSlide(
      icon: Icons.eco_rounded,
      title: "Selamat Datang di\nWeedCheck",
      subtitle: "Identifikasi gulma di lahan Anda\ndengan cepat & akurat",
      accentColor: Color(0xFF41B06E),
      gradientEnd: Color(0xFF87D05F),
    ),
    _CarouselSlide(
      icon: Icons.document_scanner_rounded,
      title: "Deteksi Gulma\nOtomatis",
      subtitle: "Arahkan kamera ke gulma dan\nbiarkan AI kami bekerja",
      accentColor: Color(0xFF41B06E),
      gradientEnd: Color(0xFFEF9651),
    ),
    _CarouselSlide(
      icon: Icons.agriculture_rounded,
      title: "Solusi Tepat\ndi Lahan Pertanian",
      subtitle: "Dapatkan rekomendasi pengendalian\ngulma yang efektif",
      accentColor: Color(0xFF18230F),
      gradientEnd: Color(0xFF41B06E),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      if (_controller.hasClients) {
        final next = (_currentPage + 1) % slides.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: slides.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final slide = slides[index];
              return _CarouselItem(slide: slide);
            },
          ),
        ),

        /// Page Indicators
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (i) {
            final isActive = i == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 24 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF41B06E)
                    : const Color(0xFF87D05F).withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CarouselSlide {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color gradientEnd;
  const _CarouselSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.gradientEnd,
  });
}

class _CarouselItem extends StatelessWidget {
  final _CarouselSlide slide;
  const _CarouselItem({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [slide.accentColor, slide.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF246A40).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          /// Decorative circles (background)
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                /// Text side
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slide.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        slide.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                /// Icon side
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(slide.icon, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

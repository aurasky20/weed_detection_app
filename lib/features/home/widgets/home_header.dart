  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';

  class HomeHeader extends StatelessWidget {
    const HomeHeader({super.key});

    @override
    Widget build(BuildContext context) {
      // Use dark status bar icons on light header or adjust as needed
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: Color(0xFF41B06E),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF246A40),
                Color(0xFF41B06E),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3018230F),
                blurRadius: 8,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  /// App Logo Icon
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFFFDD34).withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: Color(0xFFFFDD34),
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Title
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WeedCheck",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        "Aplikasi Deteksi Gulma",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 228, 50),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                ],
              ),
            ),
          ),
        ),
      );
    }
  }
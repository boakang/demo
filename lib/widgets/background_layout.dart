import 'package:flutter/material.dart';

class BackgroundLayout extends StatelessWidget {
  final Widget child;

  const BackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient and Mesh
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFDDEBFF)],
                stops: [0.3, 1.0],
              ),
            ),
          ),
          
          // Mesh/Grid pattern (Simulated with a CustomPaint or Image)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/cubes.png', // Fake mesh texture
                repeat: ImageRepeat.repeat,
                height: 300,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Top Logo (HQSOFT Mock)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.refresh, color: Colors.white, size: 40),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'HQSOFT',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // The Card/Box from Screenshots
                  child,

                  const SizedBox(height: 40),
                  // Bottom Logo and Version
                  Column(
                    children: [
                      const Icon(Icons.layers, color: Colors.pinkAccent, size: 40),
                      const Text(
                        'eSales SFA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Phiên bản eSales SFA 2023R1',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Text(
                        'Phiên bản ngày 21/02/2024',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Flag Selector Top Right
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: const Row(
                children: [
                  Icon(Icons.flag, color: Colors.red, size: 20),
                  Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

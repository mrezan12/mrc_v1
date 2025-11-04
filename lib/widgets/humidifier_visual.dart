import 'package:flutter/material.dart';

/// Hava Nemlendirici 3D Görsel Widget
/// Device Control sayfasındaki cihaz görseli
class HumidifierVisual extends StatelessWidget {
  const HumidifierVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Üst Nozzle/Outlet
          Positioned(
            top: 0,
            child: Container(
              width: 64,
              height: 32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF9ca3af), // gray-400
                    Color(0xFF6b7280), // gray-500
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          
          // Ana Gövde
          Positioned(
            top: 32,
            child: Container(
              width: 80,
              height: 176,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFe5e7eb), // gray-200
                    Color(0xFFFFFFFF), // white
                    Color(0xFFd1d5db), // gray-300
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Su Seviyesi Göstergesi
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0x4Dbfe7fe), // rgba(191, 219, 254, 0.3) - blue-200
                            Color(0x00bfe7fe), // transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Merkez Panel
                  Center(
                    child: Container(
                      width: 64,
                      height: 144,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFf3f4f6), // gray-100
                            Color(0xFFe5e7eb), // gray-200
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            blurRadius: 8,
                            offset: Offset(0, 0),
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Alt Taban
          Positioned(
            bottom: 0,
            child: Container(
              width: 96,
              height: 16,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6b7280), // gray-500
                    Color(0xFF4b5563), // gray-600
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
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


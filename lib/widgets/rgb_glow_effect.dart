import 'package:flutter/material.dart';
import 'dart:math' as math;

/// RGB Glow Efekti Widget - Yenilendi!
/// Breathing effect + Rotating particles + Color pulse
class RgbGlowEffect extends StatefulWidget {
  final int colorIndex; // 0-5 arası (6 renk)

  const RgbGlowEffect({
    super.key,
    required this.colorIndex,
  });

  @override
  State<RgbGlowEffect> createState() => _RgbGlowEffectState();
}

class _RgbGlowEffectState extends State<RgbGlowEffect>
    with TickerProviderStateMixin {
  late AnimationController _breathController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;

  // RGB renk paleti (outer, middle, inner)
  static const List<List<Color>> rgbColors = [
    // Mavi
    [Color(0x993b82f6), Color(0xB360a5fa), Color(0xCC93c5fd)],
    // Mor
    [Color(0x999333ea), Color(0xB3a855f7), Color(0xCCc084fc)],
    // Kırmızı
    [Color(0x99ef4444), Color(0xB3f87171), Color(0xCCfca5a5)],
    // Yeşil
    [Color(0x9922c55e), Color(0xB34ade80), Color(0xCC86efac)],
    // Turuncu
    [Color(0x99fb923c), Color(0xB3fbbf24), Color(0xCCfde047)],
    // Pembe
    [Color(0x99ec4899), Color(0xB3f472b6), Color(0xCCf9a8d4)],
  ];

  @override
  void initState() {
    super.initState();
    
    // Breathing animasyonu (4 saniye - smooth)
    _breathController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat(reverse: true);

    // Rotation animasyonu (12 saniye - yavaş döner)
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 12000),
      vsync: this,
    )..repeat();

    // Pulse animasyonu (2 saniye - hızlı nabız)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = rgbColors[widget.colorIndex % 6];
    
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _breathController,
          _rotationController,
          _pulseController,
        ]),
        builder: (context, child) {
          // Breathing scale (0.9 - 1.1)
          final breathScale = 0.9 + (_breathController.value * 0.2);
          
          // Pulse opacity (0.4 - 0.8)
          final pulseOpacity = 0.4 + (_pulseController.value * 0.4);
          
          // Rotation angle
          final rotationAngle = _rotationController.value * 2 * math.pi;

          return ClipRect(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children: [
                // Ana breathing circle (en dış)
                Transform.scale(
                  scale: breathScale.clamp(0.9, 1.05), // Scale'i sınırlandır
                  child: Opacity(
                    opacity: pulseOpacity * 0.7, // Opaklığı azalt
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment.center,
                          colors: [
                            colors[0],
                            Color.alphaBlend(const Color(0x80000000), colors[0]),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4, 0.8],
                        ),
                      ),
                    ),
                  ),
                ),

              // Dönen particles (8 adet)
              ...List.generate(8, (index) {
                final angle = (rotationAngle + (index * math.pi / 4));
                final radius = 55.0 + (math.sin(_breathController.value * math.pi) * 8);
                final x = math.cos(angle) * radius;
                final y = math.sin(angle) * radius;
                
                final particleSize = 10.0 + (math.sin(_pulseController.value * math.pi + index) * 3);
                
                return Transform.translate(
                  offset: Offset(x, y),
                  child: Container(
                    width: particleSize,
                    height: particleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors[2],
                      boxShadow: [
                        BoxShadow(
                          color: colors[1],
                          blurRadius: 6,
                          spreadRadius: 1.5,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Orta katman - ters yönde döner
              Transform.rotate(
                angle: -rotationAngle * 0.5,
                child: Transform.scale(
                  scale: breathScale * 0.7,
                  child: Opacity(
                    opacity: pulseOpacity,
                    child: Container(
                      width: 126,
                      height: 126,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment.center,
                          colors: [
                            colors[1],
                            Color.alphaBlend(const Color(0x66000000), colors[1]),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 0.9],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // İç katman - parlayan merkez
              Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.12),
                child: Opacity(
                  opacity: 0.6 + (_pulseController.value * 0.25),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: Alignment.center,
                        colors: [
                          colors[2],
                          Color.alphaBlend(const Color(0x4D000000), colors[2]),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors[2],
                          blurRadius: 16,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      ),
    );
  }
}

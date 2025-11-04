import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Rainbow Glow Efekti Widget - Yenilendi!
/// Spiral wave + Morphing shape + Flowing colors
class RainbowGlowEffect extends StatefulWidget {
  const RainbowGlowEffect({super.key});

  @override
  State<RainbowGlowEffect> createState() => _RainbowGlowEffectState();
}

class _RainbowGlowEffectState extends State<RainbowGlowEffect>
    with TickerProviderStateMixin {
  late AnimationController _spiralController;
  late AnimationController _morphController;
  late AnimationController _flowController;

  @override
  void initState() {
    super.initState();
    
    // Spiral rotation (10 saniye)
    _spiralController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();

    // Morph animation (5 saniye - şekil değişimi)
    _morphController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat(reverse: true);

    // Color flow (8 saniye)
    _flowController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _spiralController.dispose();
    _morphController.dispose();
    _flowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _spiralController,
          _morphController,
          _flowController,
        ]),
        builder: (context, child) {
          // Spiral rotation angle
          final spiralAngle = _spiralController.value * 2 * math.pi;
          
          // Morph scale (0.85 - 1.15)
          final morphScale = 0.85 + (_morphController.value * 0.3);
          
          // Flow offset (renk akışı için)
          final flowOffset = _flowController.value;

          return ClipRect(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children: [
                // Dış spiral halka
                Transform.rotate(
                  angle: spiralAngle,
                  child: Transform.scale(
                    scale: morphScale.clamp(0.85, 1.05), // Scale'i sınırlandır
                    child: Opacity(
                      opacity: 0.6 + (math.sin(_morphController.value * math.pi) * 0.15), // Opaklığı azalt
                      child: CustomPaint(
                        size: const Size(180, 180),
                        painter: RainbowSpiralPainter(
                          flowOffset: flowOffset,
                          isOuter: true,
                        ),
                      ),
                    ),
                  ),
                ),

                // İç spiral halka - ters yönde
                Transform.rotate(
                  angle: -spiralAngle * 0.7,
                  child: Transform.scale(
                    scale: (morphScale * 0.75).clamp(0.65, 0.8), // Scale'i sınırlandır
                    child: Opacity(
                      opacity: 0.5 + (math.cos(_morphController.value * math.pi) * 0.15), // Opaklığı azalt
                      child: CustomPaint(
                        size: const Size(135, 135),
                        painter: RainbowSpiralPainter(
                          flowOffset: flowOffset + 0.3,
                          isOuter: false,
                        ),
                      ),
                    ),
                  ),
                ),

              // Parlayan parçacıklar (6 adet)
              ...List.generate(6, (index) {
                final angle = spiralAngle + (index * math.pi / 3);
                final radius = 55.0 + (math.sin(_morphController.value * math.pi + index) * 12);
                final x = math.cos(angle) * radius;
                final y = math.sin(angle) * radius;
                
                // Her parçacığın kendi rengi (rainbow)
                final particleColor = _getRainbowColor((flowOffset + index / 6) % 1.0);
                
                return Transform.translate(
                  offset: Offset(x, y),
                  child: Container(
                    width: 8 + (math.sin(_flowController.value * 2 * math.pi + index) * 2),
                    height: 8 + (math.sin(_flowController.value * 2 * math.pi + index) * 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.alphaBlend(const Color(0x1A000000), particleColor),
                      boxShadow: [
                        BoxShadow(
                          color: Color.alphaBlend(const Color(0x66000000), particleColor),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Merkez glow - pulse efekti
              Transform.scale(
                scale: 1.0 + (math.sin(_flowController.value * 4 * math.pi) * 0.15),
                child: Opacity(
                  opacity: 0.5 + (math.sin(_flowController.value * 4 * math.pi) * 0.25),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _getRainbowColor(flowOffset),
                          Color.alphaBlend(const Color(0x66000000), _getRainbowColor((flowOffset + 0.2) % 1.0)),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
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

  // Rainbow rengini döngüsel olarak al
  Color _getRainbowColor(double position) {
    final colors = [
      const Color(0xFFef4444), // Kırmızı
      const Color(0xFFfb923c), // Turuncu
      const Color(0xFFfacc15), // Sarı
      const Color(0xFF22c55e), // Yeşil
      const Color(0xFF3b82f6), // Mavi
      const Color(0xFF9333ea), // Mor
    ];

    final index = (position * colors.length).floor() % colors.length;
    final nextIndex = (index + 1) % colors.length;
    final t = (position * colors.length) % 1.0;

    return Color.lerp(colors[index], colors[nextIndex], t)!;
  }
}

/// Rainbow Spiral Painter - Custom painter for spiral effect
class RainbowSpiralPainter extends CustomPainter {
  final double flowOffset;
  final bool isOuter;

  RainbowSpiralPainter({
    required this.flowOffset,
    required this.isOuter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Rainbow renkleri - akışkan
    final List<Color> colors = [
      const Color(0xCCef4444), // Kırmızı
      const Color(0xCCfb923c), // Turuncu
      const Color(0xCCfacc15), // Sarı
      const Color(0xCC22c55e), // Yeşil
      const Color(0xCC3b82f6), // Mavi
      const Color(0xCC9333ea), // Mor
      const Color(0xCCef4444), // Kırmızı (döngü)
    ];

    // Spiral path çiz (6 adet yay)
    for (var i = 0; i < 6; i++) {
      final startAngle = (i / 6) * 2 * math.pi + (flowOffset * 2 * math.pi);
      final sweepAngle = math.pi / 4; // 45 derece yay
      
      final gradient = SweepGradient(
        colors: colors,
        stops: List.generate(colors.length, (i) => i / (colors.length - 1)),
        startAngle: startAngle,
        endAngle: startAngle + (2 * math.pi),
      );

      final rect = Rect.fromCircle(center: center, radius: radius);
      final paint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isOuter ? 16 : 12
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, isOuter ? 20 : 16);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RainbowSpiralPainter oldDelegate) {
    return oldDelegate.flowOffset != flowOffset;
  }
}

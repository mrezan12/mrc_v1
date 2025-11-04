import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Buhar/Sis Animasyonu Widget - YENİ TASARIM
/// Arkada renkli sis bulutu efekti, mod durumuna göre renk değişir
class MistAnimation extends StatefulWidget {
  final bool isContinuous; // true: Sürekli, false: Aralıklı
  final bool isDarkMode;
  final int lightMode; // 0: Kapalı, 1: RGB, 2: Rainbow
  final int rgbColorIndex; // RGB modunda hangi renk (0-5)

  const MistAnimation({
    super.key,
    required this.isContinuous,
    required this.isDarkMode,
    required this.lightMode,
    required this.rgbColorIndex,
  });

  @override
  State<MistAnimation> createState() => _MistAnimationState();
}

class _MistAnimationState extends State<MistAnimation>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _waveController;
  late AnimationController _colorController;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Yukarı yükselme animasyonu (sürekli mod: 5s, aralıklı: 7s)
    _floatController = AnimationController(
      duration: Duration(
        milliseconds: widget.isContinuous ? 5000 : 7000,
      ),
      vsync: this,
    )..repeat();

    // Dalga/genişleme efekti (3 saniye)
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    // Renk değişimi (rainbow için, 8 saniye)
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(MistAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mod değiştiğinde animasyon hızını ayarla
    if (oldWidget.isContinuous != widget.isContinuous) {
      _floatController.duration = Duration(
        milliseconds: widget.isContinuous ? 5000 : 7000,
      );
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _waveController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // RGB renk paleti
  static const List<List<Color>> rgbColors = [
    [Color(0x663b82f6), Color(0x9960a5fa)], // Mavi
    [Color(0x669333ea), Color(0x99a855f7)], // Mor
    [Color(0x66ef4444), Color(0x99f87171)], // Kırmızı
    [Color(0x6622c55e), Color(0x994ade80)], // Yeşil
    [Color(0x66fb923c), Color(0x99fbbf24)], // Turuncu
    [Color(0x66ec4899), Color(0x99f472b6)], // Pembe
  ];

  // Rainbow rengi al
  Color _getRainbowColor(double position) {
    final colors = [
      const Color(0x66ef4444), // Kırmızı
      const Color(0x66fb923c), // Turuncu
      const Color(0x66facc15), // Sarı
      const Color(0x6622c55e), // Yeşil
      const Color(0x663b82f6), // Mavi
      const Color(0x669333ea), // Mor
    ];

    final index = (position * colors.length).floor() % colors.length;
    final nextIndex = (index + 1) % colors.length;
    final t = (position * colors.length) % 1.0;

    return Color.lerp(colors[index], colors[nextIndex], t)!;
  }

  // Sis rengi belirle - daha yumuşak geçişler için
  List<Color> _getMistColors() {
    if (widget.lightMode == 0) {
      // Kapalı - sadece beyaz/gri sis
      return widget.isDarkMode
          ? [
              const Color(0x4DFFFFFF), // Hafif beyaz
              const Color(0x33FFFFFF),
              const Color(0x1AFFFFFF),
              Colors.transparent,
            ]
          : [
              const Color(0x6693C5FD), // Açık mavi
              const Color(0x4D60A5FA),
              const Color(0x333B82F6),
              Colors.transparent,
            ];
    } else if (widget.lightMode == 1) {
      // RGB - seçili renk
      final colors = rgbColors[widget.rgbColorIndex % 6];
      return [
        colors[1],
        colors[0],
        Color.alphaBlend(const Color(0x66000000), colors[0]),
        Colors.transparent,
      ];
    } else {
      // Rainbow - dönen renkler
      final baseColor = _getRainbowColor(_colorController.value);
      final nextColor = _getRainbowColor((_colorController.value + 0.2) % 1.0);
      final midColor = Color.lerp(baseColor, nextColor, 0.5)!;
      return [
        baseColor,
        midColor,
        nextColor,
        Colors.transparent,
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatController,
        _waveController,
        _colorController,
      ]),
      builder: (context, child) {
        final mistColors = _getMistColors();
        
        // Opacity - aralıklı modda pulse (dark mode'da daha düşük opaklık)
        final baseOpacity = widget.isContinuous 
            ? (widget.isDarkMode ? 0.7 : 0.9)
            : (widget.isDarkMode ? 0.5 : 0.6);
        final pulseOpacity = widget.isContinuous
            ? 1.0
            : 0.4 + (math.sin(_waveController.value * 2 * math.pi) * 0.6);

        return SizedBox(
          width: 280,
          height: 240,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.hardEdge,
            children: [
              // Ana buhar akımları - yukarı doğru yükselen
              ...List.generate(5, (index) {
                // Her akım farklı gecikmeyle başlar ve farklı hızda yükselir
                final delay = index * 0.15;
                final speed = 0.8 + (index * 0.1); // Farklı hızlar
                final progress = ((_floatController.value + delay) * speed) % 1.0;
                
                // Yukarı doğru yükselme (0: altta, 1: üstte)
                final bottomPosition = progress * 180;
                
                // Yükseklik arttıkça opaklık azalır (dağılma efekti)
                final heightOpacity = (1.0 - progress) * 0.8;
                
                // Yükseklik arttıkça genişler (dağılma)
                final scale = 0.6 + (progress * 0.8);
                
                // Yatay offset (hafif sağa-sola kayma)
                final horizontalOffset = math.sin(progress * math.pi * 2 + index) * 15;
                
                // Yatay pozisyon (farklı başlangıç pozisyonları)
                final startX = 140 + (index - 2) * 20;
                
                // Opaklık hesaplama
                final opacity = baseOpacity * pulseOpacity * heightOpacity;
                
                // Şekil genişliği/yüksekliği (eliptik - daha gerçekçi)
                final width = 80 * scale;
                final height = 100 * scale;

                return Positioned(
                  left: startX + horizontalOffset - width / 2,
                  bottom: bottomPosition,
                  child: Transform.scale(
                    scale: 0.95 + (math.sin(_waveController.value * math.pi + index) * 0.05),
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width / 2),
                          gradient: RadialGradient(
                            center: Alignment.bottomCenter,
                            colors: mistColors.length == 4
                                ? mistColors
                                : [
                                    mistColors[0],
                                    mistColors[1],
                                    Colors.transparent,
                                  ],
                            stops: mistColors.length == 4
                                ? const [0.0, 0.3, 0.6, 1.0]
                                : const [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Küçük ince buhar parçacıkları (daha gerçekçi detay)
              ...List.generate(8, (index) {
                final delay = index * 0.12;
                final speed = 0.6 + (index % 3) * 0.15;
                final progress = ((_floatController.value + delay) * speed) % 1.0;
                
                final bottomPosition = progress * 200;
                final heightOpacity = (1.0 - progress) * 0.6;
                final scale = 0.3 + (progress * 0.4);
                final horizontalOffset = math.cos(progress * math.pi * 3 + index) * 25;
                final startX = 140 + (index % 4 - 1.5) * 30;
                
                final opacity = baseOpacity * pulseOpacity * heightOpacity * 0.7;
                final size = 40 * scale;

                return Positioned(
                  left: startX + horizontalOffset - size / 2,
                  bottom: bottomPosition,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: size,
                      height: size * 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 2),
                        gradient: RadialGradient(
                          center: Alignment.bottomCenter,
                          colors: [
                            mistColors[0],
                            Color.alphaBlend(const Color(0x80000000), mistColors[0]),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Küçük parçacıklar (sadece light mode açıksa)
              if (widget.lightMode > 0)
                ...List.generate(6, (index) {
                  final delay = index * 0.2;
                  final speed = 1.0 + (index % 2) * 0.2;
                  final progress = ((_floatController.value + delay) * speed) % 1.0;
                  
                  final bottomPosition = progress * 160;
                  final heightOpacity = (1.0 - progress) * 0.8;
                  final angle = (_waveController.value * 2 * math.pi) + (index * math.pi / 3);
                  final radius = 30.0 + (progress * 40);
                  final x = 140 + (math.cos(angle) * radius);
                  final y = bottomPosition + (math.sin(angle) * 10);

                  return Positioned(
                    left: x - 4,
                    bottom: y,
                    child: Opacity(
                      opacity: baseOpacity * pulseOpacity * heightOpacity * 0.9,
                      child: Container(
                        width: 6 + (progress * 2),
                        height: 6 + (progress * 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: mistColors[0],
                          boxShadow: [
                            BoxShadow(
                              color: mistColors[0],
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}

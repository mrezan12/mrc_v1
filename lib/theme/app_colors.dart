import 'package:flutter/material.dart';

/// EVISTAL Smart Home App - Renk Kütüphanesi
/// Tüm renk tanımları ve helper metodlar
/// Dark ve Light mode renk paletleri
class AppColors {
  // ============ DARK MODE RENK PALETİ ============
  static const Color darkBackground = Color(0xFF000000); // Siyah
  static const Color darkCardBackground1 = Color(0xFF1a1a1a);
  static const Color darkCardBackground2 = Color(0xFF2a2a2a);
  static const Color darkCardBackground3 = Color(0xFF3a3a3a);
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // Beyaz
  static const Color darkTextSecondary = Color(0xFF9ca3af); // gray-400
  static const Color darkTextSecondary2 = Color(0xFFd1d5db); // gray-300
  static const Color darkBorder = Color(0xFFFFFFFF);
  static const Color darkIconBackground = Color(0x1AFFFFFF); // rgba(255,255,255,0.1)
  static const Color darkButtonActive = Color(0xFFFFFFFF);
  static const Color darkButtonActiveText = Color(0xFF000000);
  static const Color darkButtonInactive = Color(0xFF111827); // gray-900
  static const Color darkButtonInactiveText = Color(0xFFFFFFFF);

  // ============ LIGHT MODE RENK PALETİ ============
  static const Color lightBackground = Color(0xFFe8e8e8); // Açık gri
  static const Color lightCardBackground1 = Color(0xFFf5f5f5);
  static const Color lightCardBackground2 = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1f2937); // gray-800
  static const Color lightTextSecondary = Color(0xFF4b5563); // gray-600
  static const Color lightTextSecondary2 = Color(0xFF6b7280); // gray-500
  static const Color lightBorder = Color(0xFF374151); // gray-700
  static const Color lightBorder2 = Color(0xFFd1d5db); // gray-300
  static const Color lightIconBackground = Color(0xFFe5e7eb); // gray-200
  static const Color lightIconBackground2 = Color(0xFFf3f4f6); // gray-100
  static const Color lightButtonActive = Color(0xFF111827); // gray-900
  static const Color lightButtonActiveText = Color(0xFFFFFFFF);
  static const Color lightButtonInactive = Color(0xFFd1d5db); // gray-300
  static const Color lightButtonInactiveText = Color(0xFFFFFFFF);

  // ============ ORTAK RENKLER ============
  static const Color blue400 = Color(0xFF60a5fa);
  static const Color blue600 = Color(0xFF2563eb);
  static const Color blue700 = Color(0xFF3b82f6);
  static const Color gray300 = Color(0xFFd1d5db);
  static const Color gray400 = Color(0xFF9ca3af);
  static const Color gray500 = Color(0xFF6b7280);
  static const Color gray600 = Color(0xFF4b5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1f2937);
  static const Color gray900 = Color(0xFF111827);

  // ============ GRADIENT RENKLER (Hava Durumu Kartı) ============
  static const List<Color> weatherGradient = [
    Color(0xFF374151), // gray-700
    Color(0xFF1f2937), // gray-800
  ];

  // ============ RGB MOD RENK PALETİ (6 renk döngüsü) ============
  static const List<List<Color>> rgbColors = [
    // Mavi
    [
      Color(0x993b82f6), // rgba(59, 130, 246, 0.6) - outer
      Color(0xB360a5fa), // rgba(96, 165, 250, 0.7) - middle
      Color(0xCC93c5fd), // rgba(147, 197, 253, 0.8) - inner
    ],
    // Mor
    [
      Color(0x999333ea), // rgba(147, 51, 234, 0.6)
      Color(0xB3a855f7), // rgba(168, 85, 247, 0.7)
      Color(0xCCc084fc), // rgba(192, 132, 252, 0.8)
    ],
    // Kırmızı
    [
      Color(0x99ef4444), // rgba(239, 68, 68, 0.6)
      Color(0xB3f87171), // rgba(248, 113, 113, 0.7)
      Color(0xCCfca5a5), // rgba(252, 165, 165, 0.8)
    ],
    // Yeşil
    [
      Color(0x9922c55e), // rgba(34, 197, 94, 0.6)
      Color(0xB34ade80), // rgba(74, 222, 128, 0.7)
      Color(0xCC86efac), // rgba(134, 239, 172, 0.8)
    ],
    // Turuncu
    [
      Color(0x99fb923c), // rgba(251, 146, 60, 0.6)
      Color(0xB3fbbf24), // rgba(251, 191, 36, 0.7)
      Color(0xCCfde047), // rgba(253, 224, 71, 0.8)
    ],
    // Pembe
    [
      Color(0x99ec4899), // rgba(236, 72, 153, 0.6)
      Color(0xB3f472b6), // rgba(244, 114, 182, 0.7)
      Color(0xCCf9a8d4), // rgba(249, 168, 212, 0.8)
    ],
  ];

  // ============ RAINBOW MOD RENK PALETİ ============
  static const List<Color> rainbowColors = [
    Color(0xB3ef4444), // Kırmızı - rgba(239, 68, 68, 0.7)
    Color(0xB3fb923c), // Turuncu - rgba(251, 146, 60, 0.7)
    Color(0xB3facc15), // Sarı - rgba(250, 204, 21, 0.7)
    Color(0xB322c55e), // Yeşil - rgba(34, 197, 94, 0.7)
    Color(0xB33b82f6), // Mavi - rgba(59, 130, 246, 0.7)
    Color(0xB39333ea), // Mor - rgba(147, 51, 234, 0.7)
  ];

  static const List<Color> rainbowColorsReverse = [
    Color(0x999333ea), // Mor - rgba(147, 51, 234, 0.6)
    Color(0x993b82f6), // Mavi - rgba(59, 130, 246, 0.6)
    Color(0x9922c55e), // Yeşil - rgba(34, 197, 94, 0.6)
    Color(0x99facc15), // Sarı - rgba(250, 204, 21, 0.6)
    Color(0x99fb923c), // Turuncu - rgba(251, 146, 60, 0.6)
    Color(0x99ef4444), // Kırmızı - rgba(239, 68, 68, 0.6)
  ];

  // ============ HELPER METODLAR ============
  // Dark/Light mode'a göre renk döndüren metodlar

  /// Arka plan rengi (Scaffold background)
  static Color getBackground(bool isDarkMode) {
    return isDarkMode ? darkBackground : lightBackground;
  }

  /// Kart arka plan rengi (1. seviye)
  static Color getCardBackground1(bool isDarkMode) {
    return isDarkMode ? darkCardBackground1 : lightCardBackground1;
  }

  /// Kart arka plan rengi (2. seviye)
  static Color getCardBackground2(bool isDarkMode) {
    return isDarkMode ? darkCardBackground2 : lightCardBackground2;
  }

  /// Ana metin rengi
  static Color getTextPrimary(bool isDarkMode) {
    return isDarkMode ? darkTextPrimary : lightTextPrimary;
  }

  /// İkincil metin rengi
  static Color getTextSecondary(bool isDarkMode) {
    return isDarkMode ? darkTextSecondary : lightTextSecondary;
  }

  /// İkincil metin rengi (2. varyasyon)
  static Color getTextSecondary2(bool isDarkMode) {
    return isDarkMode ? darkTextSecondary2 : lightTextSecondary2;
  }

  /// Border rengi
  static Color getBorder(bool isDarkMode) {
    return isDarkMode ? darkBorder : lightBorder;
  }

  /// Border rengi (2. varyasyon - daha açık)
  static Color getBorder2(bool isDarkMode) {
    return isDarkMode ? darkBorder : lightBorder2;
  }

  /// İkon arka plan rengi
  static Color getIconBackground(bool isDarkMode) {
    return isDarkMode ? darkIconBackground : lightIconBackground;
  }

  /// İkon arka plan rengi (2. varyasyon)
  static Color getIconBackground2(bool isDarkMode) {
    return isDarkMode ? darkIconBackground : lightIconBackground2;
  }

  /// Aktif buton arka plan rengi
  static Color getButtonActive(bool isDarkMode) {
    return isDarkMode ? darkButtonActive : lightButtonActive;
  }

  /// Aktif buton metin rengi
  static Color getButtonActiveText(bool isDarkMode) {
    return isDarkMode ? darkButtonActiveText : lightButtonActiveText;
  }

  /// Pasif buton arka plan rengi
  static Color getButtonInactive(bool isDarkMode) {
    return isDarkMode ? darkButtonInactive : lightButtonInactive;
  }

  /// Pasif buton metin rengi
  static Color getButtonInactiveText(bool isDarkMode) {
    return isDarkMode ? darkButtonInactiveText : lightButtonInactiveText;
  }

  /// Primary mavi rengi (bilgi, vurgu için)
  static Color getPrimaryBlue(bool isDarkMode) {
    return isDarkMode ? blue400 : blue600;
  }

  /// Primary mavi rengi (orta ton)
  static Color getPrimaryBlueMid() {
    return blue700;
  }
}

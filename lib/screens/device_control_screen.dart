import 'package:flutter/material.dart';
import '../widgets/humidifier_visual.dart';
import '../widgets/control_button.dart';
import '../theme/app_theme.dart';

/// Kontrol Sayfası - Hava Nemlendirici Kontrolü
/// Cihaz görseli ve kontrol butonları
class DeviceControlScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onBack;

  const DeviceControlScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onBack,
  });

  @override
  State<DeviceControlScreen> createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  // Cihaz durumları
  bool _isDeviceOn = true;
  int _mistMode = 1; // 0: Kapalı, 1: Sürekli, 2: Aralıklı
  int _lightMode = 1; // 0: Kapalı, 1: RGB, 2: Rainbow
  int _rgbColorIndex = 0; // 0-5 arası (6 renk döngüsü)

  void _togglePower() {
    setState(() {
      _isDeviceOn = !_isDeviceOn;
    });
  }

  void _cycleMistMode() {
    if (!_isDeviceOn) return;
    setState(() {
      _mistMode = (_mistMode + 1) % 3;
    });
  }

  void _cycleLightMode() {
    if (!_isDeviceOn) return;
    setState(() {
      _lightMode = (_lightMode + 1) % 3;
      if (_lightMode == 1) {
        // RGB moduna geçerken renk indeksi değiştir
        _rgbColorIndex = (_rgbColorIndex + 1) % 6;
      }
    });
  }

  void _showDeviceInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF1a1a1a)
                  : const Color(0xFFf5f5f5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.isDarkMode
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF374151),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: widget.isDarkMode
                            ? const Color(0xFF60a5fa)
                            : const Color(0xFF2563eb),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Cihaz Bilgileri',
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF1f2937),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildInfoRow('Cihaz Adı', 'Hava Nemlendirici'),
                        const SizedBox(height: 12),
                        _buildInfoRow('Model', 'MRC-HM-2024'),
                        const SizedBox(height: 12),
                        _buildInfoRow('Versiyon', 'v1.0.0'),
                        const SizedBox(height: 12),
                        _buildInfoRow('Durum', _isDeviceOn ? 'Açık' : 'Kapalı'),
                        const SizedBox(height: 12),
                        _buildInfoRow('Buhar Modu', _getMistModeLabel()),
                        const SizedBox(height: 12),
                        _buildInfoRow('Işık Modu', _getLightModeLabel()),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          'Açıklama',
                          'Hava nemlendirici cihazı, ortamın nem seviyesini kontrol ederek sağlıklı bir yaşam alanı oluşturmanıza yardımcı olur. RGB ve Rainbow ışık efektleri ile ortamınızı kişiselleştirebilirsiniz.',
                        ),
                      ],
                    ),
                  ),
                ),
                // Button
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isDarkMode
                            ? const Color(0xFF60a5fa)
                            : const Color(0xFF2563eb),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Tamam',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.isDarkMode
                ? const Color(0xFF9ca3af)
                : const Color(0xFF6b7280),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: widget.isDarkMode
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF1f2937),
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  String _getMistModeLabel() {
    switch (_mistMode) {
      case 0:
        return 'Kapalı';
      case 1:
        return 'Sürekli';
      case 2:
        return 'Aralıklı';
      default:
        return 'Kapalı';
    }
  }

  String _getLightModeLabel() {
    switch (_lightMode) {
      case 0:
        return 'Kapalı';
      case 1:
        return 'RGB';
      case 2:
        return 'Rainbow';
      default:
        return 'Kapalı';
    }
  }

  Color? _getLightModeIconBackground() {
    if (_lightMode == 0) return null;
    if (_lightMode == 1) {
      // RGB mode - seçili rengin outer katmanı
      return AppTheme.rgbColors[_rgbColorIndex][0];
    }
    // Rainbow mode - gradient (basit bir renk seçelim)
    return const Color(0xFF3b82f6); // Mavi
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode
        ? const Color(0xFF000000)
        : const Color(0xFFe8e8e8);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Geri butonu (X)
                  GestureDetector(
                    onTap: widget.onBack,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: widget.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF1f2937),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Dark/Light mode toggle
                  GestureDetector(
                    onTap: widget.onToggleTheme,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isDarkMode
                            ? const Color(0x1AFFFFFF)
                            : const Color(0xFFe5e7eb),
                      ),
                      child: Icon(
                        widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                        size: 20,
                        color: widget.isDarkMode
                            ? const Color(0xFFd1d5db)
                            : const Color(0xFF374151),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Cihaz görseli
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Center(
                child: const HumidifierVisual(),
              ),
            ),
          ),
          
          // Kontrol butonları (2x2 Grid)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                // Mist Mode (üst sol)
                ControlButton(
                  icon: Icons.water_drop,
                  label: _getMistModeLabel(),
                  isDarkMode: widget.isDarkMode,
                  isDisabled: !_isDeviceOn,
                  onTap: _cycleMistMode,
                ),
                
                // Light Mode (üst sağ)
                ControlButton(
                  icon: Icons.auto_awesome,
                  label: _getLightModeLabel(),
                  isDarkMode: widget.isDarkMode,
                  isDisabled: !_isDeviceOn,
                  onTap: _cycleLightMode,
                  iconBackgroundColor: _getLightModeIconBackground(),
                ),
                
                // Power (alt sol)
                ControlButton(
                  icon: Icons.power_settings_new,
                  label: _isDeviceOn ? 'Açık' : 'Kapalı',
                  isDarkMode: widget.isDarkMode,
                  isDisabled: false, // Power butonu her zaman aktif
                  onTap: _togglePower,
                ),
                
                // Cihaz Bilgileri (alt sağ)
                ControlButton(
                  icon: Icons.info_outline,
                  label: 'Bilgiler',
                  isDarkMode: widget.isDarkMode,
                  isDisabled: false, // Bilgi butonu her zaman aktif
                  onTap: _showDeviceInfo,
                ),
              ],
            ),
          ),
          
          // Alt boşluk
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}


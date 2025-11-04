import 'package:flutter/material.dart';
import '../widgets/weather_card.dart';
import '../widgets/device_card.dart';

/// Ana Sayfa - Cihaz Seçimi
/// Hava durumu kartı, cihaz listesi ve bluetooth tarama butonu
class DeviceSelectionScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Function(String) onSelectDevice;
  final VoidCallback onScanDevices;

  const DeviceSelectionScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onSelectDevice,
    required this.onScanDevices,
  });

  @override
  State<DeviceSelectionScreen> createState() => _DeviceSelectionScreenState();
}

class _DeviceSelectionScreenState extends State<DeviceSelectionScreen> {
  // Cihaz durumları
  final Map<String, bool> _deviceStates = {
    'humidifier-1': false,
    'smart-tv': false,
    'lighting': false,
    'air-purifier': false,
  };

  bool _showComingSoon = false;

  void _toggleDeviceState(String deviceId) {
    if (deviceId == 'humidifier-1') {
      setState(() {
        _deviceStates[deviceId] = !_deviceStates[deviceId]!;
      });
    } else {
      // Diğer cihazlar için "Coming Soon" modal göster
      setState(() {
        _showComingSoon = true;
      });
    }
  }

  void _onDeviceCardTap(String deviceId) {
    if (deviceId == 'humidifier-1') {
      widget.onSelectDevice(deviceId);
    } else {
      // Diğer cihazlar için "Coming Soon" modal göster
      setState(() {
        _showComingSoon = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode
        ? const Color(0xFF000000)
        : const Color(0xFFe8e8e8);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Ana içerik
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  
                  const SizedBox(height: 24),
                  
                  // Bluetooth Tarama Butonu
                  _buildBluetoothButton(),
                  
                  const SizedBox(height: 20),
                  
                  // Hava Durumu Kartı
                  const WeatherCard(),
                  
                  const SizedBox(height: 20),
                  
                  // Cihaz Listesi (2x2 Grid)
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        DeviceCard(
                          deviceId: 'humidifier-1',
                          deviceName: 'Hava Nemlendirici',
                          deviceIcon: Icons.water_drop,
                          isOn: _deviceStates['humidifier-1']!,
                          isAvailable: true,
                          isDarkMode: widget.isDarkMode,
                          onTap: () => _onDeviceCardTap('humidifier-1'),
                          onToggle: () => _toggleDeviceState('humidifier-1'),
                        ),
                        DeviceCard(
                          deviceId: 'smart-tv',
                          deviceName: 'Smart TV',
                          deviceIcon: Icons.tv,
                          isOn: _deviceStates['smart-tv']!,
                          isAvailable: false,
                          isDarkMode: widget.isDarkMode,
                          onTap: () => _onDeviceCardTap('smart-tv'),
                          onToggle: () => _toggleDeviceState('smart-tv'),
                        ),
                        DeviceCard(
                          deviceId: 'lighting',
                          deviceName: 'Akıllı Aydınlatma',
                          deviceIcon: Icons.lightbulb_outline,
                          isOn: _deviceStates['lighting']!,
                          isAvailable: false,
                          isDarkMode: widget.isDarkMode,
                          onTap: () => _onDeviceCardTap('lighting'),
                          onToggle: () => _toggleDeviceState('lighting'),
                        ),
                        DeviceCard(
                          deviceId: 'air-purifier',
                          deviceName: 'Hava Temizleyici',
                          deviceIcon: Icons.air,
                          isOn: _deviceStates['air-purifier']!,
                          isAvailable: false,
                          isDarkMode: widget.isDarkMode,
                          onTap: () => _onDeviceCardTap('air-purifier'),
                          onToggle: () => _toggleDeviceState('air-purifier'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Dark Mode Toggle (sağ üst)
          Positioned(
            top: 24,
            right: 24,
            child: SafeArea(
              child: GestureDetector(
                onTap: widget.onToggleTheme,
                child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.isDarkMode
                        ? const Color(0x1AFFFFFF)
                        : const Color(0x1A000000),
                  ),
                  child: Icon(
                    widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                    size: 24,
                    color: widget.isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          
          // "Coming Soon" Modal
          if (_showComingSoon) _buildComingSoonModal(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final textColor = widget.isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF1f2937);
    
    final subtextColor = widget.isDarkMode
        ? const Color(0xFF9ca3af)
        : const Color(0xFF4b5563);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Merhaba!',
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Evinizi kontrol edin',
          style: TextStyle(
            color: subtextColor,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBluetoothButton() {
    final borderColor = widget.isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF111827);
    
    final backgroundColor = widget.isDarkMode
        ? const Color(0xFF1a1a1a)
        : const Color(0xFFf5f5f5);
    
    final textColor = widget.isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF111827);

    return Center(
      child: GestureDetector(
        onTap: widget.onScanDevices,
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
              color: backgroundColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bluetooth,
                  size: 20,
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cihazları Tara',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoonModal() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showComingSoon = false;
        });
      },
      child: Container(
        color: const Color(0xCC000000), // rgba(0,0,0,0.8)
        child: Stack(
          children: [
            // Kapat butonu (X)
            Positioned(
              top: 32,
              right: 32,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showComingSoon = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: const Color(0xFF9ca3af),
                    ),
                  ),
                ),
              ),
            ),
            
            // Modal içerik
            Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                constraints: const BoxConstraints(maxWidth: 320),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: widget.isDarkMode
                      ? const Color(0xFF2a2a2a)
                      : const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // İkon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: widget.isDarkMode
                            ? const Color(0xFF3a3a3a)
                            : const Color(0xFFf3f4f6),
                      ),
                      child: const Center(
                        child: Text(
                          '⏳',
                          style: TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Başlık
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF111827),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Açıklama
                    Text(
                      'Bu özellik yakında kullanıma sunulacak!',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? const Color(0xFF9ca3af)
                            : const Color(0xFF4b5563),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Tamam butonu
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showComingSoon = false;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: widget.isDarkMode
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF111827),
                        ),
                        child: Text(
                          'Tamam',
                          style: TextStyle(
                            color: widget.isDarkMode
                                ? const Color(0xFF000000)
                                : const Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


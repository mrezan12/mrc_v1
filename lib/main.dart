import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/device_selection_screen.dart';
import 'screens/device_control_screen.dart';
import 'screens/bluetooth_scan_screen.dart';

void main() {
  runApp(const EvistalApp());
}

/// EVISTAL Smart Home App
/// Ana uygulama giriş noktası
class EvistalApp extends StatefulWidget {
  const EvistalApp({super.key});

  @override
  State<EvistalApp> createState() => _EvistalAppState();
}

class _EvistalAppState extends State<EvistalApp> {
  // Global state
  bool _isDarkMode = true; // Başlangıçta dark mode
  String? _selectedDevice; // Seçili cihaz ID'si
  bool _isScanning = false; // Bluetooth tarama durumu

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectDevice(String deviceId) {
    setState(() {
      _selectedDevice = deviceId;
    });
  }

  void _goBack() {
    setState(() {
      _selectedDevice = null;
      _isScanning = false;
    });
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVISTAL Smart Home',
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: _buildPhoneFrame(),
    );
  }

  /// iPhone benzeri frame ile uygulama görünümü
  Widget _buildPhoneFrame() {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          width: 430,
          height: 932,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            border: Border.all(
              color: Colors.black,
              width: 14,
            ),
            color: _isDarkMode
                ? const Color(0xFF000000)
                : const Color(0xFFe8e8e8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 30,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              children: [
                // Uygulama içeriği
                _buildCurrentScreen(),
                
                // iPhone notch
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 160,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigasyon logic - hangi ekranı göstereceğine karar ver
  Widget _buildCurrentScreen() {
    if (_isScanning) {
      // Bluetooth Scan Sayfası
      return BluetoothScanScreen(
        isDarkMode: _isDarkMode,
        onBack: _goBack,
      );
    } else if (_selectedDevice != null) {
      // Device Control Sayfası
      return DeviceControlScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
        onBack: _goBack,
      );
    } else {
      // Device Selection Sayfası (Ana Sayfa)
      return DeviceSelectionScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
        onSelectDevice: _selectDevice,
        onScanDevices: _startScanning,
      );
    }
  }
}

import 'package:flutter/material.dart';
import '../models/bluetooth_device.dart';
import 'dart:async';

/// Bluetooth Tarama Sayfası
/// Bluetooth cihazları tarama ve bağlanma
class BluetoothScanScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onBack;

  const BluetoothScanScreen({
    super.key,
    required this.isDarkMode,
    required this.onBack,
  });

  @override
  State<BluetoothScanScreen> createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  bool _isScanning = true;
  final List<BluetoothDevice> _devices = [];
  Timer? _scanTimer;
  int _deviceIndex = 0;

  @override
  void initState() {
    super.initState();
    _startScanning();
  }

  void _startScanning() {
    // Mock cihazları al
    final mockDevices = BluetoothDevice.getMockDevices();
    
    // Her 0.8 saniyede bir cihaz ekle
    _scanTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_deviceIndex < mockDevices.length) {
        setState(() {
          _devices.add(mockDevices[_deviceIndex]);
          _deviceIndex++;
        });
      } else {
        // Tüm cihazlar eklendi, taramayı durdur
        timer.cancel();
        setState(() {
          _isScanning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    super.dispose();
  }

  void _onConnectDevice(BluetoothDevice device) {
    // Bağlantı simülasyonu
    debugPrint('Cihaza bağlanılıyor: ${device.name}');
    widget.onBack();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode
        ? const Color(0xFF000000)
        : const Color(0xFFe8e8e8);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
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
                  
                  const SizedBox(width: 8),
                  
                  // Başlık
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.bluetooth,
                          size: 20,
                          color: widget.isDarkMode
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF1f2937),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Bluetooth Cihazları',
                          style: TextStyle(
                            color: widget.isDarkMode
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF1f2937),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 40), // Sağ boşluk (hizalama için)
                ],
              ),
            ),
            
            // Tarama durumu banner
            if (_isScanning)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.isDarkMode
                      ? const Color(0x0DFFFFFF)
                      : const Color(0x80e5e7eb),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.isDarkMode
                              ? const Color(0xFF60a5fa)
                              : const Color(0xFF2563eb),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Cihazlar taranıyor...',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? const Color(0xFFd1d5db)
                            : const Color(0xFF374151),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            
            // Cihaz listesi
            Expanded(
              child: _devices.isEmpty && !_isScanning
                  ? Center(
                      child: Text(
                        'Hiç cihaz bulunamadı',
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? const Color(0xFF9ca3af)
                              : const Color(0xFF6b7280),
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        final device = _devices[index];
                        return _buildDeviceCard(device, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BluetoothDevice device, int index) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTap: () => _onConnectDevice(device),
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.isDarkMode
                      ? const Color(0x33FFFFFF)
                      : const Color(0xFFd1d5db),
                  width: 2,
                ),
                color: widget.isDarkMode
                    ? const Color(0xFF1a1a1a)
                    : const Color(0xFFf5f5f5),
              ),
              child: Row(
                children: [
                  // Bluetooth ikonu
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: widget.isDarkMode
                          ? const Color(0x333b82f6)
                          : const Color(0x1A3b82f6),
                    ),
                    child: Icon(
                      Icons.bluetooth,
                      size: 24,
                      color: widget.isDarkMode
                          ? const Color(0xFF60a5fa)
                          : const Color(0xFF2563eb),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Cihaz bilgisi
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cihaz adı
                        Text(
                          device.name,
                          style: TextStyle(
                            color: widget.isDarkMode
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF1f2937),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Sinyal gücü
                        _buildSignalStrength(device.signalStrength),
                      ],
                    ),
                  ),
                  
                  // Bağlan badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.isDarkMode
                          ? const Color(0x1AFFFFFF)
                          : const Color(0xFFe5e7eb),
                    ),
                    child: Text(
                      'Bağlan',
                      style: TextStyle(
                        color: widget.isDarkMode
                            ? const Color(0xFFd1d5db)
                            : const Color(0xFF374151),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignalStrength(int strength) {
    // Sinyal gücüne göre aktif bar sayısı
    int activeBars = 1;
    if (strength >= 80) {
      activeBars = 4;
    } else if (strength >= 60) {
      activeBars = 3;
    } else if (strength >= 40) {
      activeBars = 2;
    }

    final activeColor = widget.isDarkMode
        ? const Color(0xFF60a5fa)
        : const Color(0xFF2563eb);
    
    final inactiveColor = widget.isDarkMode
        ? const Color(0xFF374151)
        : const Color(0xFFd1d5db);

    return Row(
      children: [
        // 4 adet sinyal çubuğu
        ...List.generate(4, (index) {
          final heights = [7.0, 10.0, 13.0, 16.0];
          return Container(
            width: 4,
            height: heights[index],
            margin: const EdgeInsets.only(right: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: index < activeBars ? activeColor : inactiveColor,
            ),
          );
        }),
        const SizedBox(width: 8),
        // Yüzde
        Text(
          '$strength%',
          style: TextStyle(
            color: widget.isDarkMode
                ? const Color(0xFF9ca3af)
                : const Color(0xFF6b7280),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}


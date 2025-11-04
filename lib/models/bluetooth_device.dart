/// Bluetooth cihaz modeli
/// Bluetooth tarama sayfasında gösterilecek cihaz bilgileri
class BluetoothDevice {
  final String id;
  final String name;
  final int signalStrength; // 0-100 arası
  final String type; // 'humidifier', 'tv', 'light'

  const BluetoothDevice({
    required this.id,
    required this.name,
    required this.signalStrength,
    required this.type,
  });

  /// Mock cihaz verileri (test için)
  static List<BluetoothDevice> getMockDevices() {
    return const [
      BluetoothDevice(
        id: 'evh-001',
        name: 'EVISTAL Humidifier #001',
        signalStrength: 95,
        type: 'humidifier',
      ),
      BluetoothDevice(
        id: 'evh-002',
        name: 'EVISTAL Humidifier #002',
        signalStrength: 78,
        type: 'humidifier',
      ),
      BluetoothDevice(
        id: 'evh-003',
        name: 'EVISTAL Humidifier #003',
        signalStrength: 62,
        type: 'humidifier',
      ),
      BluetoothDevice(
        id: 'evt-001',
        name: 'EVISTAL TV Control',
        signalStrength: 88,
        type: 'tv',
      ),
      BluetoothDevice(
        id: 'evl-001',
        name: 'EVISTAL Smart Light',
        signalStrength: 71,
        type: 'light',
      ),
    ];
  }
}


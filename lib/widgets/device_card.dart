import 'package:flutter/material.dart';

/// Cihaz Kartı Widget
/// Ana sayfada gösterilen cihaz kartları (2x2 grid)
class DeviceCard extends StatelessWidget {
  final String deviceId;
  final String deviceName;
  final IconData deviceIcon;
  final bool isOn;
  final bool isAvailable; // true: humidifier, false: coming soon
  final bool isDarkMode;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const DeviceCard({
    super.key,
    required this.deviceId,
    required this.deviceName,
    required this.deviceIcon,
    required this.isOn,
    required this.isAvailable,
    required this.isDarkMode,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Renk paletleri
    final backgroundColor = isDarkMode
        ? const Color(0xFF1a1a1a)
        : const Color(0xFFf5f5f5);
    
    final borderColor = isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF374151);
    
    final iconBackgroundColor = isDarkMode
        ? const Color(0x1AFFFFFF) // rgba(255,255,255,0.1)
        : const Color(0xFFe5e7eb);
    
    final iconColor = isDarkMode
        ? const Color(0xFFd1d5db)
        : const Color(0xFF374151);
    
    final textColor = isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF1f2937);
    
    final statusTextColor = isDarkMode
        ? const Color(0xFF9ca3af)
        : const Color(0xFF6b7280);
    
    // Power button renkleri
    final powerButtonBgActive = isDarkMode
        ? const Color(0xFFFFFFFF)
        : (isAvailable ? const Color(0xFF111827) : const Color(0xFF9ca3af));
    
    final powerButtonIconActive = isDarkMode
        ? const Color(0xFF000000)
        : const Color(0xFFFFFFFF);
    
    final powerButtonBgInactive = isDarkMode
        ? const Color(0xFF111827)
        : const Color(0xFFd1d5db);
    
    final powerButtonIconInactive = const Color(0xFFFFFFFF);
    
    // Status dot rengi
    final statusDotColor = (isAvailable && isOn)
        ? const Color(0xFF111827)
        : const Color(0xFF9ca3af);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst kısım: İkon ve Power butonu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cihaz ikonu
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: iconBackgroundColor,
                  ),
                  child: Icon(
                    deviceIcon,
                    size: 24,
                    color: iconColor,
                  ),
                ),
                
                // Power butonu
                GestureDetector(
                  onTap: onToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOn
                          ? powerButtonBgActive
                          : powerButtonBgInactive,
                    ),
                    child: Icon(
                      Icons.power_settings_new,
                      size: 20,
                      color: isOn
                          ? powerButtonIconActive
                          : powerButtonIconInactive,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 6),
            
            // Alt kısım: Cihaz adı ve durum
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cihaz adı
                  Flexible(
                    child: Text(
                      deviceName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 6),
                
                // Durum göstergesi
                Row(
                  children: [
                    // Durum noktası
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: statusDotColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Durum metni
                    Text(
                      (isAvailable && isOn) ? 'Açık' : 'Kapalı',
                      style: TextStyle(
                        color: statusTextColor,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}


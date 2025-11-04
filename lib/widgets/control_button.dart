import 'package:flutter/material.dart';

/// Kontrol Butonu Widget
/// Device Control sayfasındaki 2x2 grid butonları
class ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;
  final bool isDisabled;
  final VoidCallback onTap;
  final Color? iconBackgroundColor; // RGB/Rainbow modları için özel arka plan

  const ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isDarkMode,
    required this.isDisabled,
    required this.onTap,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Renk paletleri
    final backgroundColor = isDarkMode
        ? const Color(0xFF2a2a2a)
        : const Color(0xFFf5f5f5);
    
    final borderColor = isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF374151);
    
    final defaultIconBgColor = isDarkMode
        ? const Color(0x1AFFFFFF)
        : const Color(0xFFe5e7eb);
    
    final iconColor = isDarkMode
        ? const Color(0xFF9ca3af)
        : const Color(0xFF374151);
    
    final textColor = isDarkMode
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF1f2937);

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedOpacity(
        opacity: isDisabled ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
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
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // İkon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBackgroundColor ?? defaultIconBgColor,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconBackgroundColor != null
                      ? Colors.white
                      : iconColor,
                ),
              ),
              
              const SizedBox(height: 6),
              
              // Label
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


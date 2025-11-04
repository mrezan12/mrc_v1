import 'package:flutter/material.dart';

/// Hava Durumu Kartı Widget
/// Ana sayfada gösterilen hava durumu bilgisi
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF374151), // gray-700
            Color(0xFF1f2937), // gray-800
          ],
        ),
      ),
      child: Stack(
        children: [
          // Arka planda büyük bulut ikonu (sağda)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.cloud,
              size: 96,
              color: const Color(0x4DFFFFFF), // rgba(255,255,255,0.3)
            ),
          ),
          
          // İçerik
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Durum satırı
              Row(
                children: [
                  const Icon(
                    Icons.cloud,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Bulutlu',
                    style: const TextStyle(
                      color: Color(0xE6FFFFFF), // rgba(255,255,255,0.9)
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 4),
              
              // Sıcaklık
              const Text(
                '28°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Detaylar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Yağmur
                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 16,
                        color: Color(0xE6FFFFFF), // rgba(255,255,255,0.9)
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Yağmur: 35%',
                        style: const TextStyle(
                          color: Color(0xE6FFFFFF), // rgba(255,255,255,0.9)
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Rüzgar
                  Row(
                    children: [
                      const Icon(
                        Icons.air,
                        size: 16,
                        color: Color(0xE6FFFFFF), // rgba(255,255,255,0.9)
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Rüzgar: 10 km/s',
                        style: const TextStyle(
                          color: Color(0xE6FFFFFF), // rgba(255,255,255,0.9)
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


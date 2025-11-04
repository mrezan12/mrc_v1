EVISTAL Smart Home

Akıllı ev cihazlarını yönetmek için geliştirilmiş modern Flutter uygulaması. Dark/Light mode desteği, cihaz kontrolü ve Bluetooth entegrasyonu ile kullanıcı dostu bir deneyim sunar.

📱 Özellikler

- **Dark/Light Mode**: Tema geçişi desteği
- **Cihaz Yönetimi**: Akıllı cihazları seçme ve kontrol etme
- **Bluetooth Tarama**: Bluetooth cihazları tarama ve bağlanma (simüle)
- **Hava Nemlendirici Kontrolü**: 
  - Buhar modu kontrolü (Kapalı/Sürekli/Aralıklı)
  - Işık modu kontrolü (Kapalı/RGB/Rainbow)
  - Açma/Kapama kontrolü
  - Cihaz bilgileri görüntüleme
- **Hava Durumu Kartı**: Güncel hava durumu bilgisi
- **Modern UI**: Material Design 3 ile tasarlanmış arayüz

🛠 Teknolojiler

- **Flutter SDK**: 3.9.2+
- **Dart**: Modern Dart dil özellikleri
- **Material Design 3**: Güncel tasarım sistemi

📋 Gereksinimler

- Flutter SDK 3.9.2 veya üzeri
- Dart SDK
- Android Studio / VS Code (önerilen)
- iOS Simulator veya Android Emulator (test için)

🚀 Kurulum

1. **Projeyi klonlayın:**
   ```bash
   git clone <repository-url>
   cd mrc_v1
   ```

2. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

 📁 Proje Yapısı

```
lib/
├── main.dart                          # Uygulama giriş noktası
├── models/
│   └── bluetooth_device.dart          # Bluetooth cihaz modeli
├── screens/
│   ├── device_selection_screen.dart   # Ana sayfa - cihaz seçimi
│   ├── device_control_screen.dart     # Cihaz kontrol ekranı
│   └── bluetooth_scan_screen.dart     # Bluetooth tarama ekranı
├── widgets/
│   ├── control_button.dart            # Kontrol butonu widget'ı
│   ├── device_card.dart               # Cihaz kartı widget'ı
│   ├── humidifier_visual.dart         # Hava nemlendirici görseli
│   ├── weather_card.dart              # Hava durumu kartı
│   ├── mist_animation.dart            # Buhar animasyonu
│   ├── rgb_glow_effect.dart           # RGB glow efekti
│   └── rainbow_glow_effect.dart       # Rainbow glow efekti
└── theme/
    ├── app_colors.dart                 # Renk kütüphanesi
    └── app_theme.dart                  # Tema yapılandırması
```

 🎨 Renk Sistemi

Proje, merkezi bir renk yönetim sistemi kullanır:

- **`app_colors.dart`**: Tüm renk tanımları ve helper metodlar
- **`app_theme.dart`**: Flutter ThemeData yapılandırmaları

 Kullanım Örneği:

```dart
import '../theme/app_colors.dart';

// Helper metodlar ile:
color: AppColors.getBackground(isDarkMode)
color: AppColors.getTextPrimary(isDarkMode)
color: AppColors.getBorder(isDarkMode)

// Direkt renk erişimi:
color: AppColors.darkBackground
color: AppColors.blue400
```

 📱 Ekranlar

 1. Device Selection Screen (Ana Sayfa)
- Cihaz listesi (2x2 grid)
- Bluetooth tarama butonu
- Hava durumu kartı
- Dark/Light mode toggle

 2. Device Control Screen
- Cihaz görseli
- Kontrol butonları (Buhar modu, Işık modu, Güç, Bilgiler)
- Cihaz bilgileri dialog'u

 3. Bluetooth Scan Screen
- Bluetooth cihaz tarama
- Cihaz listesi
- Bağlanma simülasyonu

 🎯 Kullanım

1. **Ana Sayfa**: Cihaz listesinden bir cihaz seçin
2. **Cihaz Kontrolü**: Seçilen cihazın kontrol ekranında:
   - Buhar modunu değiştirin (Sürekli/Aralıklı)
   - Işık modunu seçin (RGB/Rainbow)
   - Cihazı açıp kapatın
   - Bilgiler butonuna tıklayarak cihaz detaylarını görüntüleyin
3. **Bluetooth Tarama**: Bluetooth butonuna tıklayarak cihazları tarayın

🔧 Geliştirme

 Yeni Renk Ekleme
Renkleri `lib/theme/app_colors.dart` dosyasına ekleyin ve helper metodlar oluşturun.

 Yeni Ekran Ekleme
1. `lib/screens/` klasörüne yeni dosya ekleyin
2. `main.dart` içinde navigasyon mantığını güncelleyin

 Yeni Widget Ekleme
1. `lib/widgets/` klasörüne yeni widget dosyası ekleyin
2. Gerekirse `AppColors` kütüphanesinden renkleri kullanın

 📝 Notlar

- Bluetooth tarama şu anda simüle edilmiş durumda (mock data)
- Animasyonlar isteğe bağlı olarak kaldırılabilir
- Tüm renkler merkezi `AppColors` kütüphanesinden yönetilir

 📄 Lisans

Bu proje özel bir projedir.

 👥 Geliştirici

EVISTAL Smart Home ekibi

---

**Not**: Bu uygulama geliştirme aşamasındadır ve bazı özellikler simüle edilmiş durumdadır.

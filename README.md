# 🐦 Tweety Translator

**Modern ve kullanıcı dostu AI destekli çeviri uygulaması**

Tweety Translator, Google Gemini AI teknolojisi ile desteklenen, güzel arayüzlü ve kolay kullanımlı bir çeviri uygulamasıdır. Çevirilerinizi hem orijinal yazılışında hem de Türkçe telaffuzunda görebilirsiniz.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini_AI-4285F4?style=for-the-badge&logo=google&logoColor=white)

## ✨ Özellikler

### 🎯 Temel Özellikler
- **AI Destekli Çeviri**: Google Gemini AI ile doğru ve doğal çeviriler
- **Çift Görünüm**: Hem yazılış hem de Türkçe telaffuz gösterimi
- **Çoklu Dil Desteği**: 15+ dil desteği
- **Güzel Arayüz**: Sarı tonlarda modern Material Design 3
- **Kullanıcı Dostu**: Basit ve anlaşılır kullanım

### 🌍 Desteklenen Diller
- **Türk Dilleri**: Türkçe, Azerbaycan Türkçesi, Kazakça, Kırgızca, Özbekçe, Tatarca, Türkmence, Uygurca
- **Avrupa Dilleri**: İngilizce, Almanca, Fransızca, İspanyolca, İtalyanca, Rusça
- **Asya Dilleri**: Çince, Japonca

### 💫 Gelişmiş Özellikler
- **Animasyonlu Geçişler**: Akıcı ve etkileyici animasyonlar
- **Hata Yönetimi**: Kullanıcı dostu hata mesajları
- **Kopyalama**: Çeviri sonuçlarını kolayca kopyalama
- **Hızlı Eylemler**: Temizleme ve örnek metin özellikleri

## 🚀 Kurulum

### Ön Gereksinimler
- Flutter SDK (3.9.2 veya üzeri)
- Dart SDK
- Android Studio / VS Code
- Google Gemini API anahtarı

### 1. Projeyi Klonlayın
```bash
git clone https://github.com/abdullah-eksi/tweety_translator.git
cd tweety_translator
```

### 2. Bağımlılıkları Yükleyin
```bash
flutter pub get
```

### 3. Ortam Değişkenlerini Ayarlayın
Proje kök dizininde `.env` dosyası oluşturun:
```env
GEMINI_API_KEY=your_gemini_api_key_here
```

### 4. API Anahtarı Alın
1. [Google AI Studio](https://makersuite.google.com/app/apikey) adresine gidin
2. Yeni API anahtarı oluşturun
3. Anahtarı `.env` dosyasına ekleyin

### 5. Uygulamayı Çalıştırın
```bash
flutter run
```

## 📱 Kullanım

### Temel Çeviri
1. Uygulamayı açın
2. Hedef dili seçin
3. Çevirmek istediğiniz metni girin
4. "Çevir" butonuna tıklayın
5. Sonuçları hem yazılış hem telaffuz olarak görün

### Hızlı Eylemler
- **Temizle**: Tüm alanları sıfırlar
- **Örnek**: Örnek metin ekler
- **Kopyala**: Çeviri sonucunu kopyalar

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                 # Ana uygulama girişi
├── routes.dart              # Rota tanımlamaları
├── controller/              # MVC Controller katmanı
│   └── home_controller.dart # Ana sayfa kontrolcüsü
├── model/                   # Model katmanı
│   └── translate_model.dart # Çeviri modeli
├── service/                 # Servis katmanı
│   └── aiService.dart       # Google Gemini AI servisi
├── view/                    # Görünüm katmanı
│   ├── components.dart      # Bileşen export dosyası
│   ├── page.dart           # Sayfa export dosyası
│   ├── components/         # UI Bileşenleri
│   │   ├── custom_app_bar.dart
│   │   ├── welcome_card.dart
│   │   ├── language_selector.dart
│   │   ├── input_card.dart
│   │   ├── translate_button.dart
│   │   ├── result_card.dart
│   │   └── quick_actions_card.dart
│   └── pages/              # Sayfalar
│       ├── home_view.dart  # Ana sayfa
│       └── splash_view.dart # Başlangıç sayfası
└── assets/                 # Görseller ve kaynaklar
    ├── icon.png
    └── tweety.png
```

## 🎨 Tasarım Felsefesi

### Renk Paleti
- **Ana Renk**: Sarı tonları (#FFC107, #FF8F00)
- **Arka Plan**: Gradient sarı (#FFFDE7 → #FFF8E1)
- **Metin**: Koyu gri (#2E2E2E)
- **Başarı**: Yeşil (#4CAF50)
- **Hata**: Kırmızı (#F44336)

### UI/UX Prensipleri
- **Minimal**: Sade ve temiz tasarım
- **Duyarlı**: Mobil öncelikli responsive tasarım
- **Erişilebilir**: Yüksek kontrast ve büyük dokunma alanları
- **Tutarlı**: Tüm bileşenlerde tutarlı stil

## 🔧 Teknik Detaylar

### Mimari
- **Desen**: MVC (Model-View-Controller)
- **State Management**: Provider pattern (ChangeNotifier)
- **API**: Google Gemini AI REST API
- **HTTP Client**: Dart http paketi

### Bağımlılıklar
```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8
  animate_do: ^4.2.0        # Animasyonlar
  flutter_dotenv: ^6.0.0   # Ortam değişkenleri
  http: ^1.5.0              # HTTP istekleri
```

### Önemli Sınıflar

#### TranslationResult
```dart
class TranslationResult {
  final String translation;    // Çeviri metni
  final String pronunciation; // Türkçe telaffuz
}
```

#### HomeController
```dart
class HomeController extends ChangeNotifier {
  String inputText;          // Kullanıcı girişi
  String translatedText;     // Çeviri sonucu
  String pronunciation;      // Telaffuz
  TranslateState state;      // Durum (idle/loading/success/error)
}
```



## 📦 Build

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```





## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.


## 🙏 Teşekkürler

- [Google Gemini AI](https://ai.google.dev/) - AI çeviri servisi
- [Flutter Team](https://flutter.dev/) - Harika framework
- [Material Design](https://material.io/) - Tasarım sistemi

**Made with ❤️ and Flutter**

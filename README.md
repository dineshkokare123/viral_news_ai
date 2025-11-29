# 📰 Viral News AI

**An AI-powered news content generator for creating engaging social media posts**

Viral News AI is a Flutter application that scans trending news from around the world, analyzes their viral potential using AI, and generates optimized social media content for multiple platforms. Perfect for content creators, marketers, and social media managers.

---

## ✨ Features

### 🌍 **Real-Time Global News**
- Fetches live news from **NewsAPI.org** covering global headlines
- **7 Categories**: General, Business, Entertainment, Health, Science, Sports, Technology
- Real-time updates with beautiful category filtering chips
- Mock data fallback for offline development

### 🤖 **AI-Powered Analysis**
- **Viral Potential Score**: AI analyzes each article's potential to go viral (0-100%)
- **Sentiment Analysis**: Breaks down emotional tone into 5 categories:
  - Excitement 🔥
  - Fear 😨
  - Joy 😊
  - Controversy ⚡
  - Trust 🤝
- Powered by **Google Gemini AI**

### 📱 **Multi-Platform Content Generation**
Generate optimized posts for:
- **Twitter** (X)
- **LinkedIn**
- **Instagram**
- **Facebook**

AI creates platform-specific content with:
- Engaging hooks
- Optimal length
- Relevant hashtags
- Professional tone

### 🎥 **Multimedia Features**
- **Video Streaming**: Watch news-related videos using Chewie player
- **Text-to-Speech**: Listen to articles with built-in TTS
- **Image Loading**: Beautiful article images with error handling

### 🔐 **Authentication**
- **Email/Password Login**
- **Biometric Authentication** (Face ID / Fingerprint)
- **Google Sign-In** (OAuth)
- **Apple Sign-In**
- Animated splash screen & onboarding

### 🎨 **Premium UI/UX**
- Modern **dark theme** with glassmorphism
- Smooth animations using `flutter_animate`
- Custom fonts (Inter & Outfit via Google Fonts)
- Responsive design
- Loading states & shimmer effects

---

## 🛠️ Tech Stack

### **Frontend**
- **Flutter** (Dart)
- **Provider** (State Management)
- **Material Design 3**

### **AI & APIs**
- **Google Gemini AI** (`google_generative_ai`)
- **NewsAPI.org** (News Data)

### **Multimedia**
- `video_player` & `chewie` (Video)
- `flutter_tts` (Text-to-Speech)

### **Authentication**
- `local_auth` (Biometric)
- `google_sign_in` (Google OAuth)
- `sign_in_with_apple` (Apple OAuth)

### **UI Libraries**
- `flutter_animate` (Animations)
- `google_fonts` (Typography)
- `shimmer` (Loading effects)
- `timeago` (Relative timestamps)

---

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (3.0+)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- **API Keys** (see below)

### **Installation**

1. **Clone the repository**
   ```bash
   cd viral_news_ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Keys**
   
   **a. NewsAPI Key**
   - Get a free key from [newsapi.org](https://newsapi.org/)
   - Update `lib/services/news_service.dart`:
     ```dart
     static const String _apiKey = 'YOUR_NEWS_API_KEY';
     ```

   **b. Gemini AI Key**
   - Get a key from [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Update `lib/services/gemini_service.dart`:
     ```dart
     static const String _apiKey = 'YOUR_GEMINI_API_KEY';
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
viral_news_ai/
├── lib/
│   ├── models/
│   │   └── news_article.dart          # News data model
│   ├── providers/
│   │   └── app_provider.dart          # State management
│   ├── screens/
│   │   ├── splash_screen.dart         # Animated splash
│   │   ├── login_screen.dart          # Authentication
│   │   ├── signup_screen.dart         # Registration
│   │   ├── home_screen.dart           # News feed
│   │   ├── news_detail_screen.dart    # Article details
│   │   └── content_generator_screen.dart  # AI content gen
│   ├── services/
│   │   ├── news_service.dart          # NewsAPI integration
│   │   ├── gemini_service.dart        # Gemini AI service
│   │   └── auth_service.dart          # Social auth
│   ├── widgets/
│   │   ├── news_card.dart             # News article card
│   │   └── sentiment_analysis_widget.dart  # Emotion viz
│   ├── theme/
│   │   └── app_theme.dart             # Dark theme config
│   └── main.dart                      # App entry point
├── android/                           # Android config
├── ios/                               # iOS config
├── pubspec.yaml                       # Dependencies
└── README.md                          # This file
```

---

## 🔑 API Configuration

### **NewsAPI Setup**
1. Sign up at [newsapi.org](https://newsapi.org/)
2. Copy your API key
3. Paste in `lib/services/news_service.dart`

**Free Tier Limits:**
- 100 requests/day
- Development only (not for production)

### **Google Gemini AI Setup**
1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Paste in `lib/services/gemini_service.dart`

**Model:** `gemini-pro` (stable, widely available)

---

## 📱 Platform-Specific Setup

### **iOS**
1. **Face ID Permission**: Already configured in `Info.plist`
   ```xml
   <key>NSFaceIDUsageDescription</key>
   <string>Authenticate to access your viral content dashboard</string>
   ```

2. **Apple Sign-In**: Enable in Xcode Signing & Capabilities

### **Android**
1. **Biometric Permission**: Already configured in `AndroidManifest.xml`
   ```xml
   <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
   ```

2. **Internet Access**: Already configured

---

## 🎯 Usage

1. **Launch the app** → Animated splash screen
2. **Login** with email/password, biometrics, or social login
3. **Browse news** by category (swipe chips at the top)
4. **Tap an article** to view details
5. **See AI sentiment analysis** automatically
6. **Generate content** by tapping "Generate Viral Content"
7. **Select platform** (Twitter, LinkedIn, etc.)
8. **Copy or share** the AI-generated post

---

## 🧪 Development

### **Run in Debug Mode**
```bash
flutter run
```

### **Build for Production**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

### **Run Tests**
```bash
flutter test
```

### **Code Analysis**
```bash
flutter analyze
```

---

## 🔮 Future Enhancements

- [ ] **Real-time video fetching** from YouTube/Twitter
- [ ] **Scheduling posts** with calendar integration
- [ ] **Analytics dashboard** for post performance
- [ ] **Multi-language support**
- [ ] **Dark/Light theme toggle**
- [ ] **Save favorites** locally with Hive
- [ ] **Share to platforms directly** (Twitter API, etc.)
- [ ] **AI image generation** for posts (DALL-E integration)

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Dinesh Kokare**

---

## 🙏 Acknowledgments

- **NewsAPI.org** for news data
- **Google Gemini AI** for content generation
- **Flutter Team** for the amazing framework
- **Open Source Community** for packages and inspiration

---

## 📞 Support

If you encounter any issues or have questions:
- Open an issue on GitHub
- Check existing issues for solutions
- Refer to the [Flutter Documentation](https://docs.flutter.dev/)

---

**Made with ❤️ using Flutter & AI**
# viral_news_ai

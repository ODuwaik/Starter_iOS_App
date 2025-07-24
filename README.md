# 🚀 iOS Starter App

![Swift](https://img.shields.io/badge/Swift-5.5-orange) ![iOS](https://img.shields.io/badge/iOS-15.0%2B-blue) ![License](https://img.shields.io/badge/License-MIT-green)

```
  ___ ___  ___   ___ _            _            _             
 |_ _/ _ \/ __| / __| |_ __ _ _ _| |_ ___ _ _ /_\  _ __ _ __ 
  | | (_) \__ \ \__ \  _/ _` | '_|  _/ -_) '_/ _ \| '_ \ '_ \
 |___\___/|___/ |___/\__\__,_|_|  \__\___|_|/_/ \_\ .__/ .__/
                                                  |_|  |_|   
```

A modern iOS starter app with authentication, onboarding, and multilingual support. Perfect for kickstarting your next iOS project! ✨

> "Why spend days setting up auth when you could be building the next big thing?" - Wise Developer

## 👋 Welcome to the Ultimate iOS Starter App!

Tired of setting up the same authentication boilerplate for every new app? Wish you had a solid foundation to build upon? **Look no further!** 🎉

This modern, production-ready iOS app template is built with SwiftUI and Firebase, featuring a comprehensive authentication system, sleek onboarding flow, and multilingual support. It's like having a personal iOS development assistant who's already done the boring stuff for you! 🧙‍♂️

## Overview

This starter app provides a complete authentication system with email/password and Apple Sign In, a customizable onboarding flow, and multilingual support for English and Arabic with RTL layout. Built with SwiftUI and Firebase, it follows MVVM architecture and includes a tab-based navigation system with Home and Settings screens.

## Technical Stack

- SwiftUI, Firebase, MVVM Architecture
- iOS 15.0+, Xcode 14.0+, Swift 5.5+

## Setup

### 🛠️ Prerequisites

- Xcode 14.0+
- iOS 15.0+ target deployment
- Swift 5.5+
- Apple Developer account (for Apple Sign In)

## 🚀 Getting Started

### Step 1: Clone the Repository 📋

```bash
# Clone the repo
git clone https://github.com/ODuwaik/Starter_iOS_App.git
cd Starter_iOS_App
```

### Step 2: Firebase Setup 🔥

```
┌─────────────────────────┐
│                         │
│    Firebase Console     │
│    ⬇️                   │
│    Project Setup        │
│    ⬇️                   │
│    iOS App Registration │
│    ⬇️                   │
│    Download Config File │
│                         │
└─────────────────────────┘
```

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Create a project"** or select an existing one
3. From the project overview, click the iOS icon (🍎) to add an app
4. Register your app with your Bundle ID (e.g., `com.yourcompany.StarterApp`)
5. Download the `GoogleService-Info.plist` file
6. Add it to the `StarterApp` directory in Xcode (drag & drop)
7. Enable Authentication methods in Firebase console:
   - Email/Password
   - Apple Sign In

### Step 3: Apple Sign In Setup 🍎

```
┌─────────────────────────────┐
│                             │
│    Apple Developer Portal   │
│    ⬇️                       │
│    Certificates & IDs       │
│    ⬇️                       │
│    Enable Sign In with Apple│
│                             │
└─────────────────────────────┘
```

1. Go to [Apple Developer Portal](https://developer.apple.com/)
2. Navigate to **Certificates, IDs & Profiles**
3. Select your App ID and enable **Sign In with Apple** capability
4. In Xcode, select your project target and enable **Sign In with Apple** in Signing & Capabilities
5. Follow instructions in `apple-auth-secret/README.md` to set up the secret key

### Step 4: Run the App 🏃‍♂️

1. Open the `.xcodeproj` file in Xcode
2. Select your development team in the Signing & Capabilities tab
3. Build and run the app (⌘+R)

## 🏠 Project Structure

```
📚 StarterApp
 ├── 📁 Core/                  # Foundation components
 │   ├── 📁 Common/            # Shared utilities
 │   ├── 🌐 Language/          # Localization
 │   └── 🛠️ Navigation/        # App navigation
 ├── 📁 Features/              # App features
 │   ├── 🔒 Auth/              # Authentication
 │   ├── 🏠 Home/              # Main screens
 │   └── 👋 Onboarding/        # User onboarding
 ├── 🌈 Resources/             # Assets & resources
 └── 📱 StarterApp/            # Main app target
```

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models**: Data structures and business logic
- **Views**: SwiftUI interface components
- **ViewModels**: State management and business logic

## 🎨 Customization Guide

### 📝 Changing the App Identity

```
┌─────────────────────────────┐
│                             │
│   1. Open Xcode Project     │
│   2. Select Project in       │
│      Navigator              │
│   3. Change Display Name    │
│   4. Update Bundle ID       │
│   5. Replace App Icon       │
│                             │
└─────────────────────────────┘
```

### 💫 Customizing the Onboarding Flow

Modify these files to create your perfect onboarding experience:

- `Features/Onboarding/ViewModels/OnboardingViewModel.swift` - Add/remove pages and content
- `Features/Onboarding/Views/OnboardingContainerView.swift` - Customize UI and animations
- `Features/Onboarding/Views/OnboardingPage.swift` - Design individual pages

### 🔧 Adding New Features

Follow these steps to extend the app with your own features:

1. Create a new directory in the `Features` folder (e.g., `Features/MyFeature/`)
2. Add `Views` and `ViewModels` subdirectories
3. Create your feature following the MVVM pattern
4. Connect to the navigation in `Core/Navigation/MainTabView.swift`

## 📖 Documentation

```
📓 Key Documents
 ├── 🏠 ARCHITECTURE.md  # App structure & patterns
 └── 🚀 DEPLOYMENT.md   # App Store submission guide
```

Additional documentation is available to help you understand and extend the app:

- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed explanation of app architecture and components
- [DEPLOYMENT.md](DEPLOYMENT.md) - Step-by-step guide for App Store submission

## 👥 Contributing

Contributions are welcome! Feel free to submit pull requests or create issues for bugs and feature requests.

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👏 Acknowledgments

- [Firebase](https://firebase.google.com/) for authentication services
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the UI framework
- [Apple Authentication Services](https://developer.apple.com/documentation/authenticationservices) for Sign in with Apple

## 📈 Executive Summary

```
┌──────────────────────────────────────────────────┐
│                                                       │
│  💰 Business Value                                  │
│  • Reduce time-to-market by 4-6 weeks                 │
│  • Save $15,000-25,000 in development costs           │
│  • Enterprise-grade security & authentication         │
│  • Scalable architecture for future growth            │
│                                                       │
│  📆 Implementation Timeline                           │
│  • Day 1: Clone and configure                         │
│  • Day 2-3: Customize branding and features          │
│  • Day 4-5: Add business logic                        │
│  • Week 2+: Focus on unique value proposition        │
│                                                       │
└──────────────────────────────────────────────────┘
```

## ❤️ Support & Connect

If this starter app saved you time and helped kickstart your project, consider showing some love!

- ⭐ Star this repository on GitHub
- 👍 Share it with fellow developers
- 💬 Follow me for more iOS development content:
  - [🐦 Twitter](https://x.com/oduwaik)
  - [💼 LinkedIn](https://www.linkedin.com/in/oduwaik/)

> "Great apps start with solid foundations. Happy coding!" 💪

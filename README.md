# 🚀 iOS Starter App

[![Swift](https://img.shields.io/badge/Swift-5.5%2B-orange)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0%2B-blue)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## 👋 Welcome to the Ultimate iOS Starter App!

Tired of setting up the same authentication boilerplate for every new app? Wish you had a solid foundation to build upon? **Look no further!** 🎉

This modern, production-ready iOS app template is built with SwiftUI and Firebase, featuring a comprehensive authentication system, sleek onboarding flow, and multilingual support. It's like having a personal iOS development assistant who's already done the boring stuff for you! 🧙‍♂️

> "Why spend days setting up auth when you could be building the next big thing?" - Wise Developer

## Overview

This starter app provides a complete authentication system with email/password and Apple Sign In, a customizable onboarding flow, and multilingual support for English and Arabic with RTL layout. Built with SwiftUI and Firebase, it follows MVVM architecture and includes a tab-based navigation system with Home and Settings screens.

## Technical Stack

- SwiftUI, Firebase, MVVM Architecture
- iOS 15.0+, Xcode 14.0+, Swift 5.5+

## Setup

### Prerequisites
- Xcode 14.0+
- iOS 15.0+ target deployment
- Swift 5.5+
- CocoaPods (for Firebase dependencies)
- A Firebase project

### 🔥 Quick Start

```bash
# Clone the repo
git clone https://github.com/ODuwaik/Starter_iOS_App.git
cd Starter_iOS_App

# Install dependencies
pod install
```

1. Get your `GoogleService-Info.plist` from [Firebase Console](https://console.firebase.google.com/)
2. Add it to the `StarterApp` directory
3. Open the `.xcworkspace` file and run the app

## Project Structure

The app follows a modular structure with MVVM architecture:

- **Core**: Common components, language support, and navigation
- **Features**: Auth, Home, and Onboarding modules
- **Resources**: Assets and localization files
- **StarterApp**: Main app target and services

## Customization

The app is designed to be easily customizable:

- **App Name**: Change Display Name and Bundle Identifier in Xcode project settings
- **Onboarding**: Modify `OnboardingViewModel.swift` and `OnboardingContainerView.swift`
- **New Features**: Follow the MVVM pattern in the Features directory

## Documentation

Additional documentation is available to help you understand and extend the app:

- [ARCHITECTURE.md](ARCHITECTURE.md) - App architecture and key components
- [DEPLOYMENT.md](DEPLOYMENT.md) - App Store deployment guide

## Contributing

Contributions are welcome! Feel free to submit pull requests or create issues for bugs and feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Firebase](https://firebase.google.com/) for authentication services
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the UI framework
- [Apple Authentication Services](https://developer.apple.com/documentation/authenticationservices) for Sign in with Apple

## ❤️ Support & Connect

If this starter app saved you time and helped kickstart your project, consider showing some love!

- ⭐ Star this repository on GitHub
- 👍 Share it with fellow developers
- 💬 Follow me for more iOS development content:
  - [🐦 Twitter](https://x.com/oduwaik)
  - [💼 LinkedIn](https://www.linkedin.com/in/oduwaik/)

> "Great apps start with solid foundations. Happy coding!" 💪

# Changelog

All notable changes to the iOS Starter App will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2023-06-01

### Added
- Initial release of the iOS Starter App
- Comprehensive authentication system
  - Email/password sign-up and sign-in
  - Apple Sign In integration
  - Password reset functionality
  - Account deletion
  - Session persistence
  - Error handling and loading states
- Onboarding flow
  - Multi-page onboarding screens
  - Skip option for returning users
  - Onboarding state management using UserDefaults
- Multilingual support
  - English and Arabic languages
  - Right-to-left layout support for Arabic
- Navigation
  - Splash screen
  - Tab-based navigation (Home and Settings)
  - Authentication flow
- MVVM architecture
- Firebase integration for authentication
- SwiftUI implementation

### Known Issues
- Unit tests and UI tests are not implemented yet
- User profile management is minimal
- No data persistence beyond authentication state

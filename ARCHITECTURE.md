# iOS Starter App Architecture

This document provides an overview of the architecture and key components of the iOS Starter App.

## Overview

The iOS Starter App follows the MVVM (Model-View-ViewModel) architecture pattern, which separates the user interface from the business logic. This separation makes the code more maintainable, testable, and scalable.

## Project Structure

The project is organized into the following main directories:

### Core

Contains core components and utilities that are used throughout the app:

- **Common**: Shared views, utilities, and managers
  - `OnboardingManager.swift`: Manages the onboarding state
  - `SplashView.swift`: Initial view shown when the app launches
  - `SettingsView.swift`: Settings screen with language selection and account management

- **Language**: Localization support
  - `LanguageManager.swift`: Manages the app's language settings
  - `LanguageSelectorView.swift`: UI for selecting the app language
  - Localization files in `en.lproj` and `ar.lproj`

- **Navigation**: Navigation components
  - `MainTabView.swift`: Tab-based navigation for the main app flow

### Features

Contains feature modules, each following the MVVM pattern:

- **Auth**: Authentication feature
  - **ViewModels**: 
    - `AuthViewModel.swift`: Manages authentication state and operations
  - **Views**: 
    - `SignInView.swift`: Email/password and Apple sign-in
    - `SignUpView.swift`: New user registration
    - `ForgotPasswordView.swift`: Password reset

- **Home**: Home feature
  - **ViewModels**:
    - `HomeViewModel.swift`: Manages home screen data
  - **Views**: 
    - `HomeView.swift`: Main home screen
    - `MainHomeView.swift`: Content of the home tab

- **Onboarding**: Onboarding feature
  - **ViewModels**: 
    - `OnboardingViewModel.swift`: Manages onboarding flow
  - **Views**:
    - `OnboardingContainerView.swift`: Container for onboarding screens
    - `OnboardingPage.swift`: Individual onboarding page

### Resources

Contains assets and resources:
- Images and icons
- Localization files
- Color and style definitions

### StarterApp

Contains the main app target files:
- `StarterApp.swift`: App entry point
- `ContentView.swift`: Root view
- `Services`: Firebase and other service integrations
  - `FirebaseService.swift`: Firebase authentication service
  - `FirebaseTest.swift`: Firebase configuration test

## Key Components

### Authentication Flow

The authentication flow is managed by `AuthViewModel` and `FirebaseService`:

1. User opens the app → `SplashView` is displayed
2. If the user hasn't completed onboarding → `OnboardingContainerView` is displayed
3. After onboarding (or if already completed) → `SignInView` is displayed
4. After successful authentication → `MainTabView` is displayed

Authentication options:
- Email/password sign-in
- Apple sign-in
- Guest mode
- Account deletion

### Multilingual Support

The app supports English and Arabic languages with right-to-left (RTL) layout for Arabic:

1. `LanguageManager` handles language selection and persistence
2. Localized strings are accessed via `languageManager.localizedString("key")`
3. RTL support is implemented using SwiftUI's `environment(\.layoutDirection, ...)`

### Onboarding Flow

The onboarding flow is managed by `OnboardingManager` and `OnboardingViewModel`:

1. First-time users see the onboarding screens
2. Users can skip onboarding or navigate through the pages
3. Onboarding state is persisted using `@AppStorage`

## Design Patterns

### Singleton Pattern

Used for managers that need to be accessed globally:
- `LanguageManager.shared`
- `OnboardingManager.shared`
- `FirebaseService.shared`

### Observer Pattern

Implemented using SwiftUI's `@Published` and `@StateObject`:
- View models publish state changes
- Views observe and react to these changes

### Dependency Injection

Used to provide dependencies to views and view models:
- `@EnvironmentObject` for view models
- `@StateObject` for managers

## Firebase Integration

Firebase is integrated for authentication services:

1. `FirebaseService` handles authentication operations
2. `FirebaseApp.configure()` is called in `StarterApp.swift`
3. Authentication state is observed and published to the app

## Extending the App

To add new features:

1. Create a new directory in the Features folder
2. Follow the MVVM pattern with ViewModels and Views subdirectories
3. Integrate with existing navigation and state management

## Testing

The app is designed to be testable:
- Business logic is separated from UI
- Dependencies are injectable
- State management is centralized

## Security Considerations

- API keys are stored in `GoogleService-Info.plist` (not included in the repository)
- User authentication is handled securely by Firebase
- Token management is handled by Firebase Authentication
- Sensitive user data should be stored securely (e.g., using Keychain)

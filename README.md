# Learn French - A2 Article Generator

An iOS app that displays French A2 level articles with vocabulary notes. The app now works completely offline with pre-loaded sample articles.

## Features

- 📚 Display French A2 level articles (120 words)
- 📖 Pre-loaded sample articles with vocabulary notes
- 🎨 Modern iOS UI with SwiftUI
- 🔄 Generate random articles from sample pool
- 📱 Native iOS experience
- 🚫 No internet connection required

## Project Structure

```
learn-french/
└── learn-french/          # iOS App (SwiftUI)
    ├── ContentView.swift  # Main UI
    ├── FrenchArticle.swift # Data model
    └── ArticleService.swift # Mock data service
```

## Setup Instructions

### iOS App Setup

1. **Open the project in Xcode**
   ```bash
   open learn-french/learn-french.xcodeproj
   ```

2. **Build and run the app**
   - Select your iOS device or simulator
   - Press `Cmd+R` to build and run

3. **Test the app**
   - Tap "Generate New Article" button
   - The app will display a random article from the sample pool
   - View the French article with vocabulary notes

## Article Format

Each article includes:

```swift
struct FrenchArticle {
    let id: Int
    let title: String
    let content: String
    let vocabularyNotes: String
}
```

## Sample Articles

The app includes 5 pre-loaded French A2 level articles:

1. **Le Petit Chat** - About a little cat named Minou
2. **La Belle Jardin** - About a beautiful garden
3. **Mon École** - About school life
4. **Le Week-end** - About weekend activities
5. **Les Saisons** - About the four seasons

## Development

### iOS Development
- The app uses SwiftUI and async/await for modern iOS development
- Mock data is managed in `ArticleService.swift`
- UI updates are managed with `@Published` properties
- No network dependencies required

## Requirements

- **iOS**: Xcode 14+, iOS 15+
- **Network**: No internet connection required

## License

This project is for educational purposes. 
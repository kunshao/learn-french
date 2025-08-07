# Learn French - iOS App

A simple iOS app that provides random French A2 level articles to help you learn French vocabulary and reading comprehension.

## Features

- **Random French Articles**: Get a new random A2 level French article each time you tap the "Article Suivant" button
- **Vocabulary Help**: Toggle to show/hide French vocabulary with English translations
- **Beautiful UI**: Clean, modern interface designed with SwiftUI
- **A2 Level Content**: All articles are written at the A2 (Elementary) level, perfect for beginners

## Articles Included

The app includes 5 different articles covering everyday topics:

1. **Ma Famille** - About family members and relationships
2. **Ma Maison** - Describing an apartment and its rooms
3. **Mon Travail** - Work life and daily routine
4. **Mes Loisirs** - Hobbies and free time activities
5. **Le Petit Déjeuner** - Morning routine and breakfast

## How to Use

1. **Open the App**: Launch the app to see a random French article
2. **Read the Article**: The article is displayed in a clean, readable format
3. **View Vocabulary**: Tap "Afficher" to see French words with English translations
4. **Get New Article**: Tap "Article Suivant" to get a completely different article
5. **Hide Vocabulary**: Tap "Masquer" to hide the vocabulary section

## Technical Details

- **Framework**: SwiftUI
- **iOS Version**: iOS 17.0+
- **Language**: Swift
- **Architecture**: MVVM with ObservableObject

## Project Structure

```
LearnFrench/
├── LearnFrenchApp.swift          # Main app entry point
├── ContentView.swift             # Main UI view
├── FrenchArticle.swift           # Data model for articles
├── ArticleManager.swift          # Manages article collection and random selection
├── Assets.xcassets/             # App icons and colors
└── Preview Content/             # Preview assets for SwiftUI previews
```

## Building and Running

1. Open `LearnFrench.xcodeproj` in Xcode
2. Select your target device (iPhone or iPad)
3. Press Cmd+R to build and run the app
4. The app will launch and show a random French article

## Learning Benefits

- **Reading Practice**: Improve your French reading skills with authentic A2 level content
- **Vocabulary Building**: Learn new words with immediate English translations
- **Grammar Exposure**: See French grammar structures in context
- **Cultural Content**: Learn about French daily life and culture

## Future Enhancements

Potential features that could be added:
- Audio pronunciation of articles
- Interactive vocabulary quizzes
- Progress tracking
- More articles and topics
- Different difficulty levels (A1, B1, etc.)
- Offline storage of favorite articles

## Requirements

- Xcode 15.0 or later
- iOS 17.0 or later
- macOS for development

---

**Note**: This is a basic implementation focused on providing A2 level French reading material. The articles are designed to be accessible to French learners while providing useful vocabulary and cultural context. 
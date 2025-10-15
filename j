lib/
│
├── main.dart                         // App entry point
│
├── core/                             // App-wide reusable code
│   ├── constants/
│   │   ├── colors.dart               // App color palette
│   │   ├── strings.dart              // App-wide strings
│   │   └── app_sizes.dart            // Margins, paddings, font sizes
│   ├── theme/
│   │   └── app_theme.dart            // Light/Dark themes
│   └── utils/
│       ├── helpers.dart              // Helper functions (e.g. random word)
│       └── error_handler.dart        // Error handling or network helpers
│
├── data/                             // Handles API + Models
│   ├── models/
│   │   ├── word_model.dart           // Model for word, phonetics, meanings
│   │   └── definition_model.dart     // (optional) if you split word parts
│   └── services/
│       └── api_service.dart          // Handles API calls (get word, random word)
│
├── providers/                        // State management (Provider)
│   ├── word_provider.dart            // Handles current word search
│   └── random_word_provider.dart     // Handles random word of the day logic
│
├── features/                         // Group by app feature
│   ├── home/
│   │   ├── screens/
│   │   │   └── home_screen.dart      // Word of the day + search field
│   │   ├── viewmodels/
│   │   │   └── home_viewmodel.dart   // Logic for home screen (optional)
│   │   └── widgets/
│   │       └── word_card.dart        // Display card for word/definition
│   │
│   ├── search/
│   │   ├── screens/
│   │   │   └── search_screen.dart    // Word search results
│   │   └── widgets/
│   │       └── search_field.dart     // Search input widget
│   │
│   ├── detail/
│   │   ├── screens/
│   │   │   └── word_detail_screen.dart // Word meanings, phonetics, examples
│   │   └── widgets/
│   │       └── meaning_tile.dart     // Shows each meaning or part of speech
│   │
│   └── favorites/
│       ├── screens/
│       │   └── favorites_screen.dart // Saved/favorited words
│       └── widgets/
│           └── favorite_tile.dart
│
├── widgets/                          // Reusable UI components (global)
│   ├── app_button.dart
│   ├── app_bar.dart
│   └── loading_indicator.dart
│
└── routes/
    └── app_routes.dart               // Centralized navigation setup

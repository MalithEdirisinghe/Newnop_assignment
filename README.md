# Product Catalog Application 📱🛒

A production-ready Flutter product catalog mobile application built for the **Associate Flutter Developer Practical Assessment** at **Newnop**.

This application demonstrates clean architecture principles, reactive state management using **Bloc/Cubit**, real-time search filtering, persistent user favorites, Material 3 dynamic light/dark theme switching, Material 3 Bottom Navigation Bar, offline resilience, and robust error handling.

---

## 🌟 Features

- **Material 3 Bottom Navigation Bar**: Seamless tab switching between **Catalog**, **Favorites** (with real-time item count badge), and **Settings/Info** using `IndexedStack` to preserve scroll positions and active search states.
- **Product Catalogue Display**: Clean Grid & List view layout options displaying product image, name, price, category, and interactive favourite button.
- **Product Details View**: Dedicated view featuring `Hero` image transitions, rating score, category badge, full product description, and "Add to Cart" interaction.
- **Real-Time Instant Search**: Substring matching search bar with automatic debouncing (`300ms`) updating the list dynamically as you type.
- **Category Filter Chips**: Interactive horizontal category selector (All, Electronics, Jewelery, Men's Clothing, Women's Clothing).
- **Favourites & Local Persistence (Bonus)**: Add and remove items from favorites with real-time UI synchronization across List, Detail, and Favorites screens. Favorites persist locally across app restarts using `shared_preferences`.
- **Material 3 Light & Dark Themes (Bonus)**: Dynamic theme switcher supporting custom HSL-tailored color palettes for crisp Light and Dark modes. Saved to local storage.
- **API Integration & Resilience**: Live REST API fetching from [FakeStoreAPI](https://fakestoreapi.com/products) with automatic offline fallback dataset if the network is unavailable or times out.
- **Loading & Error Handling**:
  - **Shimmer Skeleton Loading**: Polished shimmer effect while fetching product data.
  - **User-Friendly Error Card**: Clear error messaging with a **Retry** button when fetching fails.
  - **Empty States**: Customized empty states for empty search results and category filters.

---

## 📁 Project Architecture & Folder Structure

This application follows a **Clean Architecture / Feature-First** layer separation:

```
lib/
├── core/
│   ├── constants/       # App Constants (API URLs, Storage Keys, UI Constants)
│   ├── theme/           # AppTheme (Material 3 Light & Dark design tokens)
│   └── utils/           # Debouncer utility for real-time search
├── data/
│   ├── models/          # Product and Rating data models with JSON parsing & Equatable
│   ├── repositories/    # ProductRepository (REST API integration & fallback data)
│   └── services/        # LocalStorageService (SharedPreferences for Favorites & Theme)
├── logic/
│   ├── product/         # ProductCubit & ProductState (loading, search, category filter, view mode)
│   ├── favorites/       # FavoritesCubit & FavoritesState (favorites toggle & persistence)
│   └── theme/           # ThemeCubit (Light & Dark mode switching)
└── presentation/
    ├── screens/
    │   ├── main_screen.dart            # Root screen featuring Material 3 NavigationBar & IndexedStack
    │   ├── product_list_screen.dart    # Main Catalog Screen (Grid/List, Search, Filters)
    │   ├── product_detail_screen.dart  # Detailed Product View with Hero Animation
    │   ├── favorites_screen.dart       # Dedicated Favorited Products Screen
    │   └── settings_screen.dart        # Settings & Theme Toggle Screen
    └── widgets/
        ├── product_card.dart           # Grid view product card
        ├── product_list_tile.dart      # List view product tile
        ├── search_bar_widget.dart      # Debounced search bar with clear button
        ├── category_chips.dart         # Horizontal category filter selector
        ├── loading_shimmer.dart        # Skeleton shimmer loading state
        ├── error_view.dart             # Connection error card with Retry option
        └── empty_state_view.dart       # Empty state graphic for no search matches
```

### State Management Approach
State management is implemented using **`flutter_bloc` / `Cubit`**:
- `ProductCubit`: Manages catalog loading states (`initial`, `loading`, `loaded`, `error`), string search filtering, category selection, and grid/list view toggles.
- `FavoritesCubit`: Manages favorited product IDs, syncs across all screens instantly, and persists to local storage.
- `ThemeCubit`: Controls the global `ThemeMode` (Light vs Dark) and saves user preference.

### API Integration Approach
- Primary data source: HTTP GET requests to `https://fakestoreapi.com/products`.
- Network timeout handling (`10 seconds`).
- Offline fallback: If the device is offline or the server fails, `ProductRepository` gracefully serves a local mock dataset, ensuring zero app crashes or infinite loading loops.

---

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK `^3.11.5` or higher
- Dart SDK `^3.11.5` or higher
- Android Studio / VS Code with Flutter extension
- Android Device or Emulator (API 21+)

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Tests
Execute unit and widget tests:
```bash
flutter test
```

### 3. Run the Project
To launch the app in debug mode on a connected device/emulator:
```bash
flutter run
```

### 4. Build APK
To compile the release APK file:
```bash
flutter build apk --release
```
The output APK file will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 💡 Assumptions

1. **Network Availability & Mock Fallback**: Assuming real-world mobile connectivity varies, the app incorporates a local mock fallback dataset to maintain full usability even when network requests time out or fail.
2. **Product Categories**: Assuming categories from FakeStoreAPI (electronics, jewelery, men's clothing, women's clothing) remain fixed during runtime, category chips are generated dynamically from fetched products.
3. **Local Storage**: Assuming single-user local storage, `shared_preferences` is used for storing favorite product IDs and theme mode.

---

## ⚡ Challenges & Solutions

1. **Synchronizing Favorite State Across Screens**:
   - *Challenge*: Keeping the favorite icon state in sync between the product list, detail screen, and dedicated favorites screen without manual refresh.
   - *Solution*: Leveraged `FavoritesCubit` at the root of the widget tree via `MultiBlocProvider`, allowing any screen to rebuild reactively when favorites change.

2. **Smooth Real-time Search without UI Stutter**:
   - *Challenge*: Rapid typing in the search bar triggering expensive list filtering on every keystroke.
   - *Solution*: Implemented a custom `Debouncer` class (`300ms`), delaying search filter execution until typing pauses.

3. **Preserving Tab State across Navigation**:
   - *Challenge*: Tab switches resetting scroll position or active search text.
   - *Solution*: Implemented `IndexedStack` inside `MainScreen` with `NavigationBar`.

---

## 🚀 Future Improvements

- **Pagination & Infinite Scroll**: Implement lazy loading / pagination for large product catalogs.
- **Cart & Checkout Flow**: Add a functional cart repository with quantity management and checkout simulation.
- **Price Range Filter**: Add a dual slider filter for price ranges.
- **Sorting Options**: Add sorting by price (low to high, high to low) and rating.

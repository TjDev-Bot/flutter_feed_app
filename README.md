
# Flutter Product Feed

This Flutter project demonstrates how to build a modular and maintainable Flutter app for fetching and displaying product data.

## Features
- Fetch categories and products from an API.
- Sort products by price (low to high, high to low).
- Filter products by category.

## Setup and Run Instructions

### Prerequisites
1. Install Flutter SDK ([installation guide](https://flutter.dev/docs/get-started/install)).
2. Ensure you have an active internet connection for API calls.

### Steps
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch dependencies.
4. Run the app using `flutter run`.

## APIs Used
- **Categories:** `https://fakestoreapi.com/products/categories`
- **Products:** `https://fakestoreapi.com/products?limit=50`
- **Category-specific products:** `https://fakestoreapi.com/products/category/{category}`

## Directory Structure
```plaintext
lib/
├── main.dart                # Entry point
├── screens/                 # Contains UI screens
│   ├── home_screen.dart     # Main screen for displaying categories and products
├── widgets/                 # Custom reusable widgets
│   ├── category_item.dart   # Widget for individual category
│   ├── product_card.dart    # Widget for individual product
│   ├── glass_loading_effect.dart # Reusable loading effect
├── services/                # Handles API integrations
│   ├── api_services.dart    # API service for fetching categories and products
```

## Future Enhancements
- Add pagination for product lists.
- Implement caching for API responses.

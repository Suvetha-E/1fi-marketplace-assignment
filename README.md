# 1Fi Marketplace - Flutter SDE Assignment

A fully functional, production-ready implementation of the **1Fi Marketplace** and **Shop** module built using Flutter, adhering to clean architecture principles, asynchronous data repositories, robust state management, and modern fintech UI/UX standards.

---

## Features Implemented

* **Shop Page Module (`ShopPage`)**:
  * **Top Brands**: Dynamic repository-driven partner brands featuring No-Cost EMI availability.
  * **Nearby Stores**: Authorized retail outlets with distance metrics and customer ratings loaded asynchronously.
  * **1Fi Marketplace**: Interactive entry point leading to the credit/EMI product catalog.
* **1Fi Marketplace Flow (`MarketplaceHomeScreen`)**:
  * Dynamic product listing with category badges and images.
  * Product details screen with configuration/variant selection chips.
  * Comprehensive **EMI Plan Selection** screen breaking down tenure durations, monthly installments, interest rates (including No-Cost EMI options), and secure confirmation flows.
* **Engineering Standards & Architecture**:
  * **Separation of Concerns**: Clean data layer featuring strongly-typed models and decoupled asynchronous repositories (`ShopRepository`, `MarketplaceRepository`) simulating backend network operations.
  * **State Management**: Robust handling of asynchronous states (`Loading`, `Success`, `Error` with retry support, and `Empty` states) using `FutureBuilder`.
  * **Responsive UI**: Polished Material 3 design system customized with deep slate and rich indigo fintech color palettes.

---

## Project Directory Structure

```text
lib/
├── models/
│   ├── product_model.dart          # Strongly-typed product and EMI data structures
│   └── shop_models.dart            # Strongly-typed brand and store data structures
├── repositories/
│   ├── marketplace_repository.dart # Mock repository simulating backend product telemetry
│   └── shop_repository.dart        # Mock repository simulating top brands and nearby stores data
├── screens/
│   ├── shop_page.dart              # Main shop container with dynamic segmented tabs
│   ├── marketplace_home_screen.dart# Product catalog listing view
│   ├── product_details_screen.dart # Product specifications & variant toggling
│   └── emi_selection_screen.dart   # Interactive EMI tenure breakdown & confirmation
├── widgets/
│   └── state_views.dart            # Reusable Loading, Error, and Empty state UI components
└── main.dart                       # App entry point with custom Material 3 theme configuration

---

**Complete Terminal Commands Reference:**

Use the following commands in your terminal for development, testing, building, and version control:

1. Project Setup & Dependencies
Bash
# Clone the repository
git clone [https://github.com/your-username/1fi-marketplace-assignment.git](https://github.com/your-username/1fi-marketplace-assignment.git)
cd 1fi-marketplace-assignment

# Fetch all required Flutter packages and dependencies
flutter pub get

# Clean build cache if experiencing compilation issues
flutter clean
flutter pub get
2. Running the Application
Bash
# Run the app in debug mode on Chrome (Web)
flutter run -d chrome

# Run the app on Windows Desktop
flutter run -d windows

# Interactive device selection prompt
flutter run
3. Testing & Analysis
Bash
# Run automated widget/unit tests
flutter test

# Analyze code for static errors, linter warnings, or bad formatting
flutter analyze
4. Building for Production
Bash
# Build production-ready web release bundle
flutter build web --release

# Build Windows desktop release bundle
flutter build windows --release
5. Git Version Control Workflow
Bash
# Initialize local repository (if not already done)
git init

# Stage all modified files
git add .

# Commit changes with a descriptive message
git commit -m "Update implementation details"

# Link remote origin (first time only)
git remote add origin [https://github.com/your-username/1fi-marketplace-assignment.git](https://github.com/your-username/1fi-marketplace-assignment.git)

# Push changes to GitHub main branch
git branch -M main
git push -u origin main

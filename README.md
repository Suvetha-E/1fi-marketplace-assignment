# 1Fi Marketplace - Flutter SDE Assignment

A fully functional, production-ready implementation of the **1Fi Marketplace** and **Shop** module built using Flutter, following clean architecture principles, robust state management, and modern fintech UI/UX design standards.

---

## Features Implemented

* **Shop Page Tabs (`ShopPage`)**:
  * **Top Brands**: Statically populated partner brands showcasing No-Cost EMI availability.
  * **Nearby Stores**: Authorized retail outlets with distance and customer ratings.
  * **1Fi Marketplace**: Fully interactive marketplace entry point.
* **1Fi Marketplace Flow (`MarketplaceHomeScreen`)**:
  * Dynamic product listing with category badges and images.
  * Product details screen with configuration/variant selection chips.
  * Comprehensive **EMI Plan Selection** screen breaking down tenure durations, monthly installments, interest rates (including No-Cost EMI options), and secure confirmation triggers.
* **Engineering Standards**:
  * **Separation of Concerns**: Clean data layer featuring strongly-typed models (`Product`, `ProductVariant`, `EMIPlan`) and a decoupled `MarketplaceRepository` simulating network operations.
  * **State Management**: Robust handling of asynchronous states (`Loading`, `Success`, `Error` with retry support, and `Empty` states).
  * **Responsive UI**: Polished Material 3 design system customized with deep slate and rich indigo fintech color palettes.

---

## Project Structure

```text
lib/
├── models/
│   └── product_model.dart          # Strongly-typed data structures (Product, Variant, EMIPlan)
├── repositories/
│   └── marketplace_repository.dart # Mock repository simulating backend telemetry and network latency
├── screens/
│   ├── shop_page.dart              # Main shop container with 3 segmented tabs
│   ├── marketplace_home_screen.dart# Product catalog listing view
│   ├── product_details_screen.dart # Product specifications & variant toggling
│   └── emi_selection_screen.dart   # Interactive EMI tenure breakdown & confirmation
├── widgets/
│   └── state_views.dart            # Reusable Loading, Error, and Empty state UI components
└── main.dart                       # App entry point with custom Material 3 theme configuration

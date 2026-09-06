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

# 1Fi Marketplace - Flutter SDE Assignment

A fully functional, production-ready implementation of the **1Fi Marketplace** and **Shop** module built using Flutter, adhering to clean architecture principles, asynchronous data repositories, robust state management, and modern fintech UI/UX standards.

---

## Assignment Requirements & Implementation Status

| Requirement Category | Specific Feature / Scope | Status | Implementation Details |
| :--- | :--- | :--- | :--- |
| **Shop Module Tabs** | **Top Brands** | **Successfully Implemented** | Dynamic repository-driven partner brands featuring No-Cost EMI details. |
| | **Nearby Stores** | **Successfully Implemented** | Authorized retail outlets with distance metrics and ratings loaded asynchronously. |
| | **1Fi Marketplace Entry** | **Successfully Implemented** | Interactive entry card linking directly to the credit/EMI catalog. |
| **Marketplace Flow** | **Product Listing** | **Successfully Implemented** | Dynamic grid with category badges, pricing, and network images. |
| | **Product Details & Variants** | **Successfully Implemented** | Detailed specifications screen with interactive configuration chips. |
| | **EMI Plan Selection** | **Successfully Implemented** | Breakdown of tenure durations, monthly installments, interest rates, and confirmation triggers. |
| **Engineering Standards** | **Clean Architecture & Data Layer** | **Successfully Implemented** | Strongly-typed models (`Product`, `ShopModels`) and decoupled asynchronous repositories (`ShopRepository`, `MarketplaceRepository`). |
| | **State Management** | **Successfully Implemented** | Explicit asynchronous handling via `FutureBuilder` for `Loading`, `Success`, `Error` (with retry), and `Empty` states. |

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

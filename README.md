# 1Fi Consumer FinTech & Marketplace Application

A production-ready, multi-screen Flutter application built for the **1Fi SDE Intern Assignment**, implementing the **1Fi Marketplace** within the **Shop** page and integrating a complete consumer fintech ecosystem (Credit Line, EMI Financing, Product Catalog, Store Locator, and Activity Tracking).

Designed with **Clean Architecture**, **Material 3 Design System**, and a **Deep Slate & Rich Indigo FinTech Aesthetic**.

---

## 📋 1Fi Assignment Requirements Compliance Matrix

| Assignment Requirement | Exact Terminology / Scope | Implementation Status | Features & Technical Details |
| :--- | :--- | :--- | :--- |
| **Main Shop Container** | **`Shop`** | **Completed** | Main tabbed screen titled **Shop** with 3 top segmented tabs. |
| **Option A** | **`Top Brands`** | **Completed** | Partner brands grid (Apple, Samsung, Sony, OnePlus, Bose, Dell Pro) with 0% No-Cost EMI badges & instant discounts. |
| **Option B** | **`Nearby Stores`** | **Completed** | Authorized retail outlets with live distance metrics (`1.2 km away`), ratings, store categories, search bar, and open/closed status. |
| **Option C** | **`1Fi Marketplace`** | **Completed** | End-to-end marketplace experience: search filters, category chips, dynamic pricing, variants, EMI breakdown, and instant booking CTA. |
| **Product Browsing** | **Product Listing** | **Completed** | Search queries & category filter chips ('Smartphones', 'Laptops', 'Audio', 'Wearables', 'Gaming'). |
| **Product Details** | **Details & Variants** | **Completed** | Multi-image gallery carousel, specs table, and variant selection chips (Storage/RAM/Color) updating total price. |
| **EMI Financing** | **EMI Options & CTA** | **Completed** | Tenure breakdown (3 to 24m), No-Cost EMI highlights vs standard rates, down payment selector, and instant confirmation sheet. |
| **Data & APIs** | **Decoupled Telemetry** | **Completed** | Mock repositories (`UserRepository`, `ShopRepository`, `MarketplaceRepository`) simulating async backend latency. |
| **State Handling** | **Async View States** | **Completed** | Explicit `LoadingView`, `ErrorView` (with retry button), and `EmptyView` (with reset filter CTA). |
| **Quality & Polish** | **Zero Errors & Lints** | **Completed** | `flutter analyze` passed with **0 errors, 0 warnings**, and zero layout overflow issues. |

---

## 🎨 Visual & Theme Design System

- **Theme Palette**: Deep Slate (`#0B0F19` backdrop, `#0F172A` headers, `#1E293B` cards), Rich Violet (`#6B21A8` / `#9333EA`), and Emerald Green (`#059669` / `#10B981` credit badges).
- **Typography**: Clean hierarchy with bold price formatting and pill badges.
- **Responsiveness**: Fluid layout scrolling wrapped in `SafeArea` and `SingleChildScrollView` preventing bottom overflow on all screen sizes.

---

## 🚀 Full Application Modules & Features

### 1. Authentication & Onboarding Flow
- **Animated Splash Screen** ([`splash_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/splash_screen.dart)): Deep slate ambient glows, glowing 1Fi emblem logo, and spring physics transition.
- **Phone & OTP Login** ([`auth_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/auth_screen.dart)): Phone number input with live 10-digit validation, 6 individual OTP digit boxes (auto-filled `123456`), resend timer countdown, and pre-approved credit check banner.

### 2. Main FinTech Dashboard
- **Dashboard Header & Credit Line** ([`main_dashboard_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/main_dashboard_screen.dart)): Custom greeting (`Hello, Suvetha 👋`), notification count badge, and `CreditLimitCard` displaying total (`₹2,50,000`) vs available (`₹1,85,000`) credit line.
- **Quick Action Grid**: 5 core financial action tiles (Shop, Instant Loan, Pay Bills, Credit Score Check, Rewards).
- **Active EMI Loan Tracker**: Active loan progress cards with monthly installment amount (`₹11,241/mo`), due date, and one-tap "Pay EMI" trigger.
- **Promotional Carousels**: Interactive gradient banners highlighting 1Fi 0% EMI campaigns.

### 3. Shop & 1Fi Marketplace Module
- **Shop Container** ([`shop_page.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/shop_page.dart)): Segmented TabBar with `Top Brands`, `Nearby Stores`, and `1Fi Marketplace`.
- **Standalone Catalog** ([`marketplace_home_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/marketplace_home_screen.dart)): Product catalog with search bar and category chips.

### 4. Product Details & EMI Selection Flow
- **Product Details Page** ([`product_details_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/product_details_screen.dart)): Image gallery, dynamic variant chips, specifications table, and sticky "Select EMI Plan" CTA.
- **EMI Selection Screen** ([`emi_selection_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/emi_selection_screen.dart)): 3, 6, 9, 12, 18, 24-month tenure plans, No-Cost EMI badges, down payment selector, loan breakdown summary, and instant pre-approved booking modal.

### 5. User Profile & Activity Hub
- **User Profile** ([`user_profile_screen.dart`](file:///c:/Users/Devi%20Mukepshene/OneDrive/Documents/trying_flutter/lib/screens/user_profile_screen.dart)): User info header, Credit Score gauge (`782 Excellent`), 1Fi reward points (`1,450 pts`), active orders tab, EMI repayment history tab, and expandable support FAQs.

---

## 📂 Codebase Directory Architecture

```text
lib/
├── models/
│   ├── user_model.dart             # User profile, notifications, credit limit data structures
│   ├── loan_model.dart             # Active loan tracking & EMI repayment progress structures
│   ├── order_model.dart            # User order & booked item structures
│   ├── product_model.dart          # Product, variant, and EMI plan structures
│   └── shop_models.dart            # Partner brand and nearby store structures
├── repositories/
│   ├── user_repository.dart        # User profile, active loans, and notification telemetry
│   ├── shop_repository.dart        # Partner brands and nearby store telemetry
│   └── marketplace_repository.dart # Marketplace catalog products and search telemetry
├── screens/
│   ├── splash_screen.dart          # Animated brand splash screen
│   ├── auth_screen.dart            # Phone OTP login & credit check onboarding
│   ├── main_dashboard_screen.dart  # Central FinTech dashboard hub
│   ├── shop_page.dart              # Main Shop page with Top Brands, Nearby Stores, & 1Fi Marketplace tabs
│   ├── marketplace_home_screen.dart# Full marketplace product catalog screen
│   ├── product_details_screen.dart # Specifications, gallery & variant selection
│   ├── emi_selection_screen.dart   # Interactive EMI tenure breakdown & instant booking modal
│   └── user_profile_screen.dart    # User activity, orders, EMI history, & support FAQs
├── widgets/
│   ├── state_views.dart            # Reusable LoadingView, ErrorView (with retry), EmptyView
│   └── fintech_widgets.dart        # CreditLimitCard, QuickActionGrid, ActiveEmiCard, PromoCarousel
└── main.dart                       # App entry point with Material 3 ThemeData & desktop shell container
```

---

## 🛠️ How to Run the Application

### 1. Run in Web Browser (Chrome)
```bash
flutter run -d chrome
```

### 2. Build Android APK
- **Debug APK**:
  ```bash
  flutter build apk --debug
  ```
- **Release APK**:
  ```bash
  flutter build apk --release
  ```

### 📍 Generated APK Location
```text
build/app/outputs/flutter-apk/app-debug.apk
```

---

## ✅ Code Quality & Verification

Static analysis run via `flutter analyze`:
```bash
Analyzing trying_flutter...                                     
No issues found! (ran in 1.3s)
```
- **0 errors**, **0 warnings**, **0 deprecation issues**.

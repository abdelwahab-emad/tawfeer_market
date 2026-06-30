# 🛒 Tawfeer Market

**Tawfeer Market** (تطبيق توفير ماركت) is a cross-platform grocery / mini-market e-commerce app built with **Flutter** and **Firebase**. It provides a complete shopping experience for customers — browsing products by category, searching, managing a cart and favorites, and tracking orders — alongside a full **Admin Dashboard** for store owners to manage products, categories, orders, and users.

The app is built with a clean **BLoC/Cubit** architecture and runs on **Android, iOS, Web, Windows, Linux, and macOS** from a single codebase.

---

## ✨ Features

### 👤 Customer
- Email/password authentication (sign up, login, change password) via **Firebase Auth**
- Browse products by category, view daily needs, offers, and top-selling items
- Product search with live results
- Product details page with discount/old-price display
- Add to cart, update quantities, and view a full cart summary
- Add/remove favorites and view a dedicated favorites list
- Place orders and track order history with order details
- Light, responsive UI with a bottom navigation bar (`persistent_bottom_nav_bar_v2`)

### 🛠️ Admin
- Admin Hub with a live **Dashboard** (charts powered by `fl_chart`) for sales/orders overview
- Product management: add, edit, delete products with image upload (`image_picker` + `Cloudinary`/Firebase Storage)
- Category management: add, edit, delete categories
- Order management: view and update customer orders
- User management: view and manage registered users

### ⚙️ Technical Highlights
- **State management:** `flutter_bloc` (Cubit pattern) — a dedicated cubit/state pair per feature (cart, favorites, products, categories, orders, auth, dashboard, language, etc.)
- **Backend:** Firebase (Authentication, Cloud Firestore, Firebase Storage)
- **Image hosting:** Cloudinary integration for product images
- **Local persistence:** `shared_preferences` for saved language and lightweight local state
- **Reactive streams:** `rxdart` for combining/streaming Firestore data (e.g., live dashboard updates)

---

## 🧰 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | flutter_bloc (Cubit) |
| Backend / Database | Firebase Cloud Firestore |
| Authentication | Firebase Auth |
| File Storage | Firebase Storage / Cloudinary |
| Charts | fl_chart |
| Local Storage | shared_preferences |
| Fonts | google_fonts |

---

## 📁 Project Structure

```
lib/
├── cubits/          # State management (Cubit + State) per feature
│   ├── cart/
│   ├── category_cubit/
│   ├── product_cubit/
│   ├── favorite/
│   ├── login_cubit/
│   ├── register_cubit/
│   ├── orders/
│   ├── admin_orders/
│   ├── dashboard/
│   ├── users_cubit/
│   └── language/
├── models/          # Data models (Product, Category, Order, User)
├── pages/           # All UI screens (customer + admin)
├── widgets/         # Reusable UI components
├── constants.dart   # App-wide constants
├── firebase_options.dart
└── main.dart        # App entry point & route configuration
```

---

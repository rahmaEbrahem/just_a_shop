# 🛍️ Just a Shop
**Just a Shop** is a Flutter-based e-commerce mobile application designed to provide a simple and user-friendly online shopping experience. The project focuses on building a modern UI, reusable components, localization, and maintainable code, with plans to integrate product APIs and authentication services.

## ✨ Features

- Onboarding screens with automatic page navigation and indicators.

- Registration and login UI.

- Arabic and English localization.

- Light and dark theme support.

## 🛠️ Technologies Used

- **Flutter & Dart** — Cross-platform mobile application development.
- **Easy Localization** — Arabic and English localization.
- **Flutter ScreenUtil** — Responsive UI adaptation.
- **Hive** — Local data storage.
- **Git & GitHub** — Version control and team collaboration.
## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/rahmaEbrahem/just_a_shop.git
```

### 2. Navigate to the Project Directory

```bash
cd just_a_shop
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Generate Required Files

Generate the required code files when needed.

**Hive and other generated files:**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Localization keys:**

```bash
dart run easy_localization:generate --source-dir ./assets/translation -f keys -o locale_keys.g.dart -O lib/gen
```

# First Flutter Project 🚀

This project is a comprehensive Flutter application developed as part of a multi-phase learning path, covering everything from project setup to advanced concepts like localization and animations.

## 📌 Project Overview

The application includes a multi-step journey:
1.  **Onboarding Screen**: Displays images from assets and the web with custom typography.
2.  **Sign Up Screen**: A fully validated form with secure navigation.
3.  **Shopping Screen**: A responsive dashboard featuring product carousels, grids, and offer lists.

---

## 🛠 Phase 1: Project Setup

The project was initialized using the Flutter Command Line Interface (CLI).

### Commands Used:
```bash
# Create the project
flutter create first_flutter_project

# Navigate to the project directory
cd first_flutter_project

# Verify Flutter installation
flutter --version
```

---

## 🎨 Phase 2: Stateless Widgets & UI Basics
- Implementation of a clean UI using **StatelessWidgets**.
- Integration of local assets and network images.
- Custom typography using the **Suwannaphum** font family.
- Modular widget architecture (separate files for each component).

---

## 🛒 Phase 3: Stateful Widgets & Responsive Shopping UI
- Built a responsive Shopping Screen using **MediaQuery**.
- **PageView**: For featured product highlights.
- **GridView**: Displaying products in a 2-column layout with interactive "Add to Cart" functionality via SnackBar.
- **ListView.builder**: Used for a performance-optimized list of "Hot Offers".
- Fully scrollable interface with optimized layouts.

---

## 📝 Phase 4: Form Validation & Navigation
- Created a robust **Sign Up Page**.
- **Field Validations**:
    - **Full Name**: Ensures the first letter is capitalized.
    - **Email**: Validates the presence of '@'.
    - **Password**: Minimum length of 6 characters.
    - **Confirm Password**: Matches the primary password field.
- Interactive dialogs on successful account creation.

---

## 🎬 Phase 5: Animations
- Smooth **Fade Transition** implemented between the Sign Up success dialog and the Shopping Screen.
- Enhanced UX through natural-feeling navigation transitions.

---

## 🌍 Phase 6: Localization (i18n)
- Full support for **Arabic (AR)** and **English (EN)**.
- Integrated `flutter_localizations` and `intl` packages.
- Zero hard-coded strings: All UI text is managed through `.arb` files.
- Dynamic language switching capability.

---

## 📂 Project Structure
- `lib/l10n/`: Localization files (`.arb`) and generated code.
- `lib/screens/`: Main page widgets (Onboarding, Sign Up, Shopping).
- `lib/widgets/`: Reusable UI components (Product Cards, Text Fields, etc.).
- `assets/`: Contains custom fonts and local images.

---

## 🚀 How to Run
1.  Ensure Flutter is installed.
2.  Clone the repository.
3.  Run `flutter pub get` to fetch dependencies.
4.  Run `flutter run` on your preferred device.

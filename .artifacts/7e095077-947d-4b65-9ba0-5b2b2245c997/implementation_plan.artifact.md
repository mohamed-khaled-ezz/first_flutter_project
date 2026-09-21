# Firebase Authentication and Firestore Integration Plan

This plan outlines the steps to integrate Firebase Authentication (Login/Sign Up) and Cloud Firestore (Data Entry/Display) into the existing shopping app.

## User Review Required

> [!IMPORTANT]
> - The user must ensure that **Firebase Authentication** (Email/Password) and **Cloud Firestore** are enabled in the Firebase Console for this project.
> - The project already contains `firebase_options.dart`, which simplifies the initialization process.

## Proposed Changes

### 1. Project Initialization & Localization

#### [MODIFY] [main.dart](file:///D:/sprints/first_flutter_project/lib/main.dart)
- Initialize Firebase using `Firebase.initializeApp` and `DefaultFirebaseOptions`.

#### [MODIFY] [app_en.arb](file:///D:/sprints/first_flutter_project/lib/l10n/app_en.arb)
#### [MODIFY] [app_ar.arb](file:///D:/sprints/first_flutter_project/lib/l10n/app_ar.arb)
- Add missing localization strings for:
    - Login page (Title, Button, "Don't have an account?")
    - Firestore form (Name, Age, Hobby, Save Button, View Records Button)
    - Firestore display (Title, No data message)
    - Authentication errors (Wrong password, User not found, etc.)

---

### 2. Phase 1: Firebase Authentication

#### [NEW] [login_screen.dart](file:///D:/sprints/first_flutter_project/lib/screens/login_screen.dart)
- Create a `LoginScreen` with Email and Password fields.
- Implement "Sign In" logic using `FirebaseAuth.instance.signInWithEmailAndPassword`.
- Add a button to navigate to the `SignUpPage`.
- Navigate to `ShoppingScreen` upon successful login.

#### [MODIFY] [sign_up_screen.dart](file:///D:/sprints/first_flutter_project/lib/screens/sign_up_screen.dart)
- Replace the dummy `createAccount` logic with `FirebaseAuth.instance.createUserWithEmailAndPassword`.
- Navigate to `ShoppingScreen` upon successful registration.

#### [MODIFY] [on_bording.dart](file:///D:/sprints/first_flutter_project/lib/screens/on_bording.dart)
- Update the "Skip" button to navigate to the new `LoginScreen` instead of `SignUpPage`.

---

### 3. Phase 2: Cloud Firestore

#### [NEW] [firestore_form_screen.dart](file:///D:/sprints/first_flutter_project/lib/screens/firestore_form_screen.dart)
- Create a form with three fields: Name, Age, and Favourite Hobby.
- Implement "Save" button to write data to a `users_data` collection in Firestore.
- Implement "View Records" button to navigate to `FirestoreDisplayScreen`.

#### [NEW] [firestore_display_screen.dart](file:///D:/sprints/first_flutter_project/lib/screens/firestore_display_screen.dart)
- Create a page that displays a list of records fetched from Firestore using a `StreamBuilder`.

#### [MODIFY] [shopping_screen.dart](file:///D:/sprints/first_flutter_project/lib/screens/shopping_screen.dart)
- Add a FloatingActionButton or a menu item to navigate to the `FirestoreFormScreen`.

---

## Verification Plan

### Automated Tests
- N/A (Focusing on manual verification for Firebase integration)

### Manual Verification
1. **Authentication:**
   - Attempt to sign up with a new email/password. Verify the user is created in the Firebase Console.
   - Attempt to log in with the created credentials. Verify navigation to `ShoppingScreen`.
   - Attempt to log in with wrong credentials and verify error handling.
2. **Firestore:**
   - Open the Firestore Form and enter data.
   - Click "Save" and verify the data appears in the Firestore Console under the `users_data` collection.
   - Click "View Records" and verify the list shows the newly added data.

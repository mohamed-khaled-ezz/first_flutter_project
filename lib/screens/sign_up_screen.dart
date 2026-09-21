import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/language_icon_button.dart';
import 'shopping_screen.dart';

/// Phase 4 & 5: Sign Up Page with form validation and animated navigation.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Global key for the form to trigger validation
  final _formKey = GlobalKey<FormState>();

  // Controllers to retrieve text field values
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles account creation logic and shows success dialog
  Future<void> createAccount() async {
    final l10n = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(l10n.success),
                content: Text(l10n.accountCreated),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Phase 5: Fade transition to Shopping Screen
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 600),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return const ShoppingScreen();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(l10n.ok),
                  ),
                ],
              );
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = l10n.errorWeakPassword;
        } else if (e.code == 'email-already-in-use') {
          message = l10n.errorEmailAlreadyInUse;
        } else {
          message = e.message ?? "An error occurred";
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signUp),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: const [LanguageIconButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Icon(
                  Icons.person_add,
                  size: 80,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  l10n.createAccount,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Full Name field with capitalization validation
              CustomTextField(
                label: l10n.fullName,
                hintText: l10n.fullNameHint,
                prefixIcon: Icons.person,
                controller: fullNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.errorFullNameRequired;
                  }
                  String name = value.trim();
                  if (name[0] != name[0].toUpperCase()) {
                    return l10n.errorFullNameCapital;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Email field with '@' symbol validation
              CustomTextField(
                label: l10n.email,
                hintText: l10n.emailHint,
                prefixIcon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.errorEmailRequired;
                  }
                  if (!value.contains('@')) {
                    return l10n.errorEmailInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password field with min length validation
              CustomTextField(
                label: l10n.password,
                hintText: l10n.passwordHint,
                prefixIcon: Icons.lock,
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.errorPasswordRequired;
                  }
                  if (value.length < 6) {
                    return l10n.errorPasswordTooShort;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Confirm Password field with match validation
              CustomTextField(
                label: l10n.confirmPassword,
                hintText: l10n.confirmPasswordHint,
                prefixIcon: Icons.lock_outline,
                controller: confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.errorConfirmPasswordRequired;
                  }
                  if (value != passwordController.text) {
                    return l10n.errorPasswordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              // Sign Up Action Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : createAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10n.signUp,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

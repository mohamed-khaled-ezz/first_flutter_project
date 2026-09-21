import 'package:first_flutter_project/screens/login_screen.dart';
import 'package:first_flutter_project/widgets/custom_network_image.dart';
import 'package:first_flutter_project/widgets/language_icon_button.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Phase 2: Onboarding screen demonstrating stateless widgets,
/// local assets, and network images.
class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: const [
          LanguageIconButton(), // Reusable language switcher
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row containing two images as per Phase 2 requirements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomNetworkImage(
                imageUrl: 'https://picsum.photos/id/1080/300/300',
                width: 140,
                height: 140,
              ),
              Image.asset(
                'assets/images/on_bording_image.png',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ],
          ),
          // Styled text using the Suwannaphum font
          Text(
            l10n.imagesDisplayed,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Suwannaphum',
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Button to navigate to the Login page
          MaterialButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            color: Colors.blue,
            child: Text(
              l10n.skip,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

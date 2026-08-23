import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/product_card.dart';
import '../widgets/hot_offer_card.dart';

/// Phase 3: Main Shopping Screen featuring a responsive UI.
/// Displays products in PageView and GridView, and special offers in a ListView.
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  // List of images for the top PageView banner
  final List<String> productImages = [
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
    'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=800',
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800',
  ];

  /// Utility to show a SnackBar when an item is added to the cart
  void addToCart() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.itemAddedToCart),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Phase 3 Requirement: Use MediaQuery for responsive UI
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive height calculations
    final double pageViewHeight = screenWidth * 0.55;
    final double cardHeight = screenWidth * 1;

    // Localized product data for GridView
    final List<Map<String, dynamic>> products = [
      {
        'name': l10n.wirelessHeadphones,
        'price': '\$59.99',
        'image':
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      },
      {
        'name': l10n.smartWatch,
        'price': '\$39.99',
        'image':
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      },
      {
        'name': l10n.stylishBackpack,
        'price': '\$49.99',
        'image':
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
      },
      {
        'name': l10n.runningShoes,
        'price': "\$54.99",
        'image':
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
      },
      {
        'name': l10n.sunglasses,
        'price': '\$19.99',
        'image':
            'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500',
      },
      {
        'name': l10n.baseballCap,
        'price': '\$14.99',
        'image':
            'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=500',
      },
    ];

    // Localized offer data for Hot Offers section
    final List<Map<String, dynamic>> hotOffers = [
      {
        'name': l10n.premiumEarbuds,
        'description': l10n.earbudsDescription,
        'price': '\$29.99',
        'image':
            'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=500',
      },
      {
        'name': l10n.digitalCamera,
        'description': l10n.cameraDescription,
        'price': '\$199.99',
        'image':
            'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=500',
      },
      {
        'name': l10n.portableSpeaker,
        'description': l10n.speakerDescription,
        'price': '\$24.99',
        'image':
            'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500',
      },
      {
        'name': l10n.laptopPro,
        'description': l10n.laptopDescription,
        'price': '\$899.99',
        'image':
            'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
      },
      {
        'name': l10n.gamingController,
        'description': l10n.controllerDescription,
        'price': '\$45.99',
        'image':
            'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?w=500',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          l10n.shoppingApp,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      // Requirement: Entire page must be vertically scrollable
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.ourProducts,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Horizontal carousel for product images
              SizedBox(
                height: pageViewHeight,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: productImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        productImages[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // 2x2 Grid display for products
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Requirement: 2 cards per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: screenWidth / cardHeight,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onAddToCart: addToCart,
                    cardWidth: screenWidth / 2,
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                l10n.hotOffers,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // List display for hot offers
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hotOffers.length,
                itemBuilder: (context, index) {
                  return HotOfferCard(offer: hotOffers[index]);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

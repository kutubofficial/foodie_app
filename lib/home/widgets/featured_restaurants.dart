import 'package:flutter/material.dart';
import 'package:foodie/home/widgets/restaurant_cards.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedRestaurantsSection extends StatelessWidget {
  const FeaturedRestaurantsSection({super.key});

  static const _restaurants = [
    RestaurantData(
      name: "Domino's Pizza",
      // imagePath: 'assets/categories/mc_donald.png',
      imagePath: 'assets/categories/piz.jpg',
      rating: 4.4,
      reviewCount: '8.3K+',
      distanceKm: 1.0,
      cuisines: 'Pizzas, Italian',
      priceForTwo: 400,
      location: 'Vasundhara Enclave',
      deliveryTime: '20-25 mins',
      discountTag: 'Items at ₹59',
    ),
    RestaurantData(
      name: 'KFC',
      imagePath: 'assets/categories/kfc_home.jpg',
      rating: 4.3,
      reviewCount: '12K+',
      distanceKm: 2.0,
      cuisines: 'Burgers, Fast Food',
      priceForTwo: 400,
      location: 'Noida Sector 18',
      deliveryTime: '15-20 mins',
      discountTag: '50% off',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Featured Restaurants',
            style: GoogleFonts.inter(fontSize: 20,color: Color(0xFF2D2B2B), fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _restaurants.length,
          separatorBuilder: (_, _) => const SizedBox(height: 18),
          itemBuilder: (context, index) => RestaurantCards(data: _restaurants[index]),
        ),
      ],
    );
  }
}

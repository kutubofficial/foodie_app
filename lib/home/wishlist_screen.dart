import 'package:flutter/material.dart';
import 'package:foodie/home/widgets/restaurant_cards.dart';
import 'package:google_fonts/google_fonts.dart';
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

static const _restaurants = [
    RestaurantData(
      name: "Shree Sai Bhojnalya",
      imagePath: 'assets/categories/chhole.jpg',
      rating: 3.8,
      reviewCount: '7.3K+',
      distanceKm: 2.6,
      cuisines: 'Pizzas, Italian',
      priceForTwo: 400,
      location: 'Mayur Vihar Extension',
      deliveryTime: '15-20 mins',
      discountTag: 'Items at ₹59',
    ),
    RestaurantData(
      name: 'Desi Paratha Hub',
      imagePath: 'assets/categories/alo_paratha.jpg',
      rating: 4.3,
      reviewCount: '11.6K+',
      distanceKm: 4.0,
      cuisines: 'Burgers, Fast Food',
      priceForTwo: 400,
      location: 'Noida Sector 6',
      deliveryTime: '25-30 mins',
      discountTag: '50% off',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
    backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  elevation: 3,
  shadowColor: Color.fromRGBO(0, 0, 0, 0.15),
  centerTitle: true,
  title: Text('Wish List',
    style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black,),
  ),
),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 26),
            child: Text(
              'Favourite Restaurants & Foods',
              style: GoogleFonts.inter(fontSize: 22,color: Color(0xFF2D2B2B), fontWeight: FontWeight.w500),
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
            ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:foodie/home/home_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Object> _cartItems = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
    backgroundColor: Colors.white,
  surfaceTintColor: Colors.white,
  elevation: 3,
  shadowColor: Color.fromRGBO(0, 0, 0, 0.15),
  centerTitle: true,
  title: Text('Cart',
    style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black,),
  ),
),
      body: _cartItems.isEmpty ? _buildEmptyState() : _buildCartList(),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) => const SizedBox.shrink(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( "Uh Oh! You don't have any food orders",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black,),
            ),
            const SizedBox(height: 8),
            Text( 'Order now to avail great discounts!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.textDarkGrey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeWrapper()),);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secColor,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                ),
                child: Text('Order Now',
                  style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white,letterSpacing: 1.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

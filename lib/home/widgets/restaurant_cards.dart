
import 'package:flutter/material.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:foodie/home/widgets/restaurant_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantData {
  const RestaurantData({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.cuisines,
    required this.location,
    required this.priceForTwo,
    required this.deliveryTime,
    this.discountTag,
  });

  final String name;
  final String imagePath;
  final double rating;
  final String reviewCount;
  final double distanceKm;
  final String cuisines;
  final String location;
  final int priceForTwo;
  final String deliveryTime;
  final String? discountTag;
}


class RestaurantCards extends StatefulWidget {
   final RestaurantData data;
  const RestaurantCards({super.key, required this.data});
@override
State<RestaurantCards>createState()=> _RestaurantCards();
}
class _RestaurantCards extends State<RestaurantCards>{
bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
        RestaurantDetailScreen(name: widget.data.name, rating: widget.data.rating, deliveryTime: widget.data.deliveryTime,
        distance: widget.data.distanceKm, location:widget.data.location)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: AppColors.primary),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(255, 141, 99, 0.11),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.asset(widget.data.imagePath,fit: BoxFit.contain,width: double.infinity,),
                      
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          },
                          child: _iconButton(isFavourite? Icons.favorite: Icons.favorite_border, isRed:isFavourite)),
                      ),
                      if (widget.data.discountTag != null)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: _tag(widget.data.discountTag!),
                        ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: _tag(widget.data.deliveryTime, dark: true),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( widget.data.name,
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF267E3E),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, size: 11, color: Colors.white),
                                const SizedBox(width: 2),
                                Text(
                                  widget.data.rating.toString(),
                                  style: GoogleFonts.inter(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white,),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              // '(${widget.data.reviewCount}) • ${widget.data.distanceKm} km',
                              '(${widget.data.reviewCount}) • ${widget.data.location} • ${widget.data.distanceKm} km',
                              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textDarkGrey,fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.data.cuisines} • ₹${widget.data.priceForTwo} for two',
                        style: GoogleFonts.inter(fontSize: 12, color: AppColors.textDarkGrey,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon,{bool isRed=false}) {
    return SizedBox(
      width: 30,
      height: 30,
      // decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
      child: Icon(icon, size: 24, color: isRed? Colors.red:  Colors.white),
    );
  }

  Widget _tag(String text, {bool dark = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: dark ? Colors.white : AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: dark? Colors.black : Colors.white),
      ),
    );
  }
}
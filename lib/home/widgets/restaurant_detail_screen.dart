import 'package:flutter/material.dart';
import 'package:foodie/home/cart/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';

class _DishItem {
  const _DishItem({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.highlyReordered = false,
  }) : isVeg = true;

  final String name;
  final int price;
  final String description;
  final String imagePath;
  final bool isVeg;
  final bool highlyReordered;
}

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({
    super.key,
    required this.name,
    required this.rating,
    required this.deliveryTime,
    required this.distance,
    required this.location,
  });

  final String name;
  final double rating;
  final String deliveryTime;
  final String location;
  final double distance;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  
  static const _filters = ['Filters', 'Veg', 'Non-veg', 'Highly reordered',"Kid's choice"];
  int _selectedFilter = 1;

  static const _dishes = [
    _DishItem(
      name: 'Og Cheese Burger',
      price: 380,
      description:
          'A crispy mozzarella patty topped with spicy jalapeños and fresh lettuce, finished with zesty honey mustard',
      imagePath: 'assets/categories/burger.png',
      highlyReordered: true,
    ),
    _DishItem(
      name: 'Manohar Bikkaneri Ice-cream',
      price: 390,
      description:
          'A crispy ice patty topped with a gooey cream slice, caramelized onions, zesty gherkins, and fresh lettuce',
      imagePath: 'assets/categories/ice_cream.png',
      highlyReordered: true,
    ),
    _DishItem(
      name: 'Dirty Saucy Fries Pulao',
      price: 240,
      description: 'Loaded fries tossed in our signature dirty sauce',
      imagePath: 'assets/categories/pulao.png',
      highlyReordered: true,
    ),
    _DishItem(
      name: 'Shawarma & Rolls',
      price: 360,
      description:
          'A crispy mozzarella patty topped with spicy jalapeños and fresh lettuce, finished with zesty honey mustard',
      imagePath: 'assets/categories/shawarma.png',
      highlyReordered: true,
    ),
    _DishItem(
      name: 'Premium Cake And Dessert',
      price: 180,
      description:
          'A crispy mozzarella patty topped with spicy jalapeños and fresh lettuce, finished with zesty honey mustard',
      imagePath: 'assets/categories/dessert.png',
      highlyReordered: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 5,),
                      _buildTopBar(),
                // SizedBox(height: 5,),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildTitleRow(),
                        const SizedBox(height: 2),
                        _buildLocationRow(),
                        const SizedBox(height: 6),
                        _buildDeliveryRow(),
                        const SizedBox(height: 14),
                        const Divider(height: 1),
                        _buildOfferRow(),
                        const Divider(height: 1),
                        const SizedBox(height: 12),
                        _buildFilterChips(),
                        const SizedBox(height: 20),
                        _buildSectionHeader('Recommended for you'),
                        const SizedBox(height: 12),
                        ..._dishes.map(_buildDishTile),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleIconButton(Icons.arrow_back, onTap: () => Navigator.of(context).maybePop()),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text('Search', style: GoogleFonts.inter(color: AppColors.textGrey,fontSize: 16, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _circleIconButton(Icons.more_vert, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton(IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(widget.name,
                style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700,color: Color(0xFF000000)),
              ),
              const SizedBox(width: 6),
              Icon(Icons.info_outline, size: 18, color: Colors.grey.shade500),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF267E3E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 13, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      widget.rating.toString(),
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text('By 300+', style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text('${widget.distance} · ${widget.location}', style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade700)),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDeliveryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.bolt, size: 16, color: Color(0xFF267E3E)),
          const SizedBox(width: 2),
          Text(
            '${widget.deliveryTime} · Schedule for later',
            style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF267E3E), fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF267E3E)),
        ],
      ),
    );
  }

  Widget _buildOfferRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Flat ₹80 OFF above ₹899', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            children: [
              Text('2 offers', style: GoogleFonts.inter(fontSize: 13, color: AppColors.primary)),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool active = index == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                // border: Border.all(color: active ? AppColors.primary : Colors.grey.shade300),
                border: active? Border.all(color: const Color(0xFFFF8D63)): null,
                 color: active ?  Colors.white : const Color(0xFFFF8D63),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_filters[index] == 'Veg' || _filters[index] == 'Non-veg')
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        _filters[index] == 'Veg' ? Icons.circle : Icons.change_history,
                        size: 12,
                        color: _filters[index] == 'Veg' ? const Color(0xFF267E3E) : active ?Colors.red: Colors.white,
                      ),
                    ),
                  Text( _filters[index],
                    style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w600,
                      color: active ? AppColors.primary : Colors.white,
                    ),
                  ),
                  if (_filters[index] == 'Filters' || _filters[index] == 'Highly reordered')
                    Icon(Icons.keyboard_arrow_down, size: 16, color: active ?AppColors.primary: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.inter(
               fontSize: 16,fontWeight: FontWeight.w700,letterSpacing: 0.6,color: Color(0xFFFF7F51),),),
        ],
      ),
    );
  }

  Widget _buildDishTile(_DishItem dish) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dish.name, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    if (dish.highlyReordered) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(width: 26, height: 3, color: const Color(0xFF267E3E)),
                          const SizedBox(width: 6),
                          Text(
                            'Highly reordered',
                            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textDark),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text('₹${dish.price}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(
                      '${dish.description} ',
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.bookmark_border, size: 20, color: AppColors.primary),
                        const SizedBox(width: 16),
                        Icon(Icons.share_outlined, size: 20, color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 130,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 110,
                            width: 130,
                            color: Colors.grey.shade300,
                            // child: Icon(Icons.fastfood, color: Colors.grey.shade500),
                            child: Image.asset(dish.imagePath, fit: BoxFit.cover,)
                          ),
                        ),
                        Positioned(
                          bottom: -14,
                          left: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CartScreen(
                                restaurantName: widget.name, 
                                initialItem : CartItemInput(name: dish.name, price: dish.price.toDouble(), imagePath: dish.imagePath)
                              )));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE9E4),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.primary),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'ORDER NOW',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  // const SizedBox(width: 4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:foodie/home/search_screen.dart';
import 'package:foodie/home/widgets/featured_restaurants.dart';
import 'package:foodie/home/widgets/promo_banner_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _Category {
  const _Category(this.label, this.imagePath);
  final String label;
  final String imagePath;
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = [
  _Category('Burger', 'assets/categories/burger.png'),
  _Category('Halwa puri', 'assets/categories/halwa_puri.png'),
  _Category('Pizza', 'assets/categories/pizza.png'),
  _Category('Biryani', 'assets/categories/biryanii.png'),
  _Category('Noodles', 'assets/icons/maggie.png'),
  _Category('Pulao', 'assets/categories/pulao.png'),
  _Category('Qorma', 'assets/categories/qorma.png'),
  _Category('Dessert', 'assets/categories/dessert.png'),
  _Category('Ice Cream', 'assets/categories/ice_cream.png'),
  _Category('Pasta', 'assets/categories/pasta.png'),
  _Category('Shawarma', 'assets/categories/shawarma.png'),
  _Category('Paratha', 'assets/categories/paratha.png'),
];
int _selectedFilterIndex = -1;


  static const _filterPills = ['Popular Brands', 'Free Delivery', 'Offers','Veg Meal','Rating 4.0+','Non Veg'];

@override
void initState() {
  super.initState();
}
@override
void dispose() {
  super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        // backgroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 28),
                _buildSearchBar(context),
                const SizedBox(height: 20),
                _buildCategoriesSection(),
                const SizedBox(height: 20),
                _buildFilterPills(),
                const SizedBox(height: 20),
                FeaturedRestaurantsSection(),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      );
    }

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
    // padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    decoration: BoxDecoration(
      color: Color(0xFFFF7B4B),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Aibak',
                    style: GoogleFonts.inter(
                      fontSize: 20,letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on,size: 16,color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'New Delhi, India',
                        style: GoogleFonts.inter(
                          fontSize: 12,fontWeight: FontWeight.w700,letterSpacing: 1.2,color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.11),
                      blurRadius: 4,spreadRadius: 0,
                      offset: const Offset(4,4),
                    ),
                  ],
                ),
                child: Text('Change address',
                  style: GoogleFonts.inter(
                    fontSize: 12,fontWeight: FontWeight.w500,letterSpacing: 1.2,
                    color: Color(0xFFDE4D17),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

         PromoBannerCarousel(slides: [_buildPromoCard(),_buildSecPromoCard()],),
      ],
    ),
  );
}

Widget _buildPromoCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(10, 12, 12, 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'assets/icons/title_img.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Next Delicious Meal\nIs Just A Click Away',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color:  AppColors.secColor,
                      height: 1.25, letterSpacing: 0.9
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text( 'Order now and satisfy your\ncravings!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11,fontWeight: FontWeight.w300,color: AppColors.secColor,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/icons/maggie.png',
                width: 82,
                height: 82,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Order Now',
                  style: GoogleFonts.inter(
                    fontSize: 14,fontWeight: FontWeight.w800,
                    color: Colors.white,letterSpacing: 1.1
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Explore Menu',
                  style: GoogleFonts.inter(
                    fontSize: 14,fontWeight: FontWeight.w800,
                    color: AppColors.primary,letterSpacing: 1.1
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSecPromoCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.10),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/icons/maggie.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: 12,
            top: 16,
            bottom: 16,
            child: Container(
              width: 105,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '50% OFF YOUR\nFIRST ORDER',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w800,color: Colors.white,height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Don't believe us?\nTry it yourself!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 7,fontWeight: FontWeight.w400,color: Colors.white,height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 65,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 142, 3),
                      boxShadow: [
                    BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                       ),
                      ],
                    ),
                    child: Text( 'ENJOY',
                      style: GoogleFonts.inter(fontSize: 7,fontWeight: FontWeight.w700,color: Colors.white,letterSpacing: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 14,
            top: 62,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text( 'NEW TASTE',
                  style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w900,letterSpacing: 0.5,color: Color.fromARGB(255, 181, 104, 3),),
                ),
                Text('EVERY DAY',
                  style: GoogleFonts.inter(fontSize: 12,fontWeight: FontWeight.w900,letterSpacing: 0.5,color:Color.fromARGB(255, 181, 104, 3),),
                ),
                const SizedBox(height: 2),
                Text(
                  '100+ Unique Dishes',
                  style: GoogleFonts.inter(fontSize: 7,fontWeight: FontWeight.w600,color: AppColors.textDarkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchScreen()),);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
               BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.11),offset: const Offset(4, 4),
                blurRadius: 10,spreadRadius: 1)
            ]
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: AppColors.primary,size: 26,),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Restaurant name or a dish...',
                  style: GoogleFonts.inter(color: AppColors.textGrey,fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Icon(Icons.mic_none, color: AppColors.primary, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Categories',
            style: GoogleFonts.inter(fontSize: 20,color: Color(0xFF2D2B2B), fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Image.asset(_categories[index].imagePath,width: 80,height: 80,fit: BoxFit.cover,)),
                  const SizedBox(height: 10),
                  Text(
                    _categories[index].label,
                    style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xFF000000)),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPills() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterPills.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                _selectedFilterIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _selectedFilterIndex ==index ?  Colors.white : const Color(0xFFFF8D63),
                borderRadius: BorderRadius.circular(22),
                border: _selectedFilterIndex == index?  Border.all(color: const Color(0xFFFF8D63)): null,
              ),
              alignment: Alignment.center,
              child: Text(
                _filterPills[index],
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600,
                color:_selectedFilterIndex == index ?const Color(0xFFFF8D63): Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';

class _DishItem {
  const _DishItem(this.label, this.imagePath);
  final String label;
  final String imagePath;
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _previousSearches = ['Burger', 'Pizza', 'KFC'];
  static const _dishGrid = [
    _DishItem('Pizza', 'assets/dishes/pizza_dish.png'),
    _DishItem('Cake', 'assets/dishes/cake_dish.png'),
    _DishItem('Burger', 'assets/dishes/burger_dish.png'),
    _DishItem('Biryani', 'assets/dishes/biryani_dish.png'),
    _DishItem('Chole Bhature', 'assets/dishes/chole_dish.png'),
    _DishItem('Aloo Paratha', 'assets/dishes/aloo_dish.png'),
    _DishItem('Chilli Potato', 'assets/dishes/chilli_dish.png'),
    _DishItem('Rolls', 'assets/dishes/rolls_dish.png'),
    _DishItem('Tacos', 'assets/dishes/tacos_dish.png'),
    _DishItem('Fried Rice', 'assets/dishes/rice_dish.png'),
    _DishItem('Paratha', 'assets/dishes/paratha_dish.png'),
    _DishItem('Thali', 'assets/dishes/thali_dish.png'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectSuggestion(String query) {
    setState(() => _searchController.text = query);
    // trigger your actual search here.
  }

  void _removePreviousSearch(String query) {
    setState(() => _previousSearches.remove(query));
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _buildSearchBar()),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_previousSearches.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text('PREVIOUS SEARCHES',
                          style: GoogleFonts.inter(
                            fontSize: 12,fontWeight: FontWeight.w700,letterSpacing: 0.6,color: Color(0xFFFF7F51),),
                        ),
                        const SizedBox(height: 6),
                        ..._previousSearches.map(_buildPreviousSearchTile),
                      ],
                      const SizedBox(height: 24),
                      Text("WHAT'S ON YOUR MIND?",
                        style: GoogleFonts.inter(
                          fontSize: 12,fontWeight: FontWeight.w700,letterSpacing: 0.9,color: Color(0xFFFF7F51),),
                      ),
                      const SizedBox(height: 14),
                      _buildDishGrid(),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
               BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.11),offset: const Offset(4, 4),
                blurRadius: 10,spreadRadius: 1)
            ]
      ),
      child: Row(
        children: [
          IconButton(
            // icon: Icon(Icons.chevron_left, color: AppColors.primary, size: 26),
             icon: Icon(Icons.search, color: AppColors.primary,size: 26,),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Restaurant name or a dish...',
                // hintStyle: GoogleFonts.inter(color: Colors.grey.shade500, fontSize: 15),
                  hintStyle: GoogleFonts.inter(color: AppColors.textGrey,fontSize: 16, fontWeight: FontWeight.w400),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Icon(Icons.mic_none, color: AppColors.primary, size: 22),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildPreviousSearchTile(String query) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(Icons.history, color: Colors.grey.shade500, size: 20),
      title: Text(query, style: GoogleFonts.inter(fontSize: 14)),
      trailing: IconButton(
        icon: Icon(Icons.close, color: Colors.grey.shade400, size: 16),
        onPressed: () => _removePreviousSearch(query),
      ),
      onTap: () => _selectSuggestion(query),
    );
  }

  Widget _buildDishGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _dishGrid.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 22,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final dish = _dishGrid[index];
        return GestureDetector(
          onTap: () => _selectSuggestion(dish.label),
          child: Column(
            children: [
              Image.asset(
                dish.imagePath,
                width: 96,
                height:96,
              ),
              const SizedBox(height: 1),
              Text(
                dish.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xFF2D3142),),
              ),
            ],
          ),
        );
      },
    );
  }

}
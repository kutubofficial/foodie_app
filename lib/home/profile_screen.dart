import 'package:flutter/material.dart';
import 'package:foodie/auth/login.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text( 'Account',
          style: GoogleFonts.inter(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.black,),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1,color: const Color(0xFFD4CACA),)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Text('Aibak',
              style: GoogleFonts.inter(fontSize: 32,fontWeight: FontWeight.w600,color: AppColors.textDark,letterSpacing: 1.2),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {},
              child: Text(
                'View profile',
                style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400, color: AppColors.textDark,letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 42),
            Row(
              children: [
                _quickActionCard(icon: Icons.description_outlined, label: 'Orders'),
                const SizedBox(width: 12),
                _quickActionCard(icon: Icons.favorite_border, label: 'Favourites'),
                const SizedBox(width: 12),
                _quickActionCard(icon: Icons.location_on_outlined, label: 'Addresses'),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'General',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 12),
            buildTile(
              icon: Icons.person_outline,
              title: 'Profile setting',
              onTap: () {},
            ),
            buildTile(
              icon: Icons.help_outline,
              title: 'Help center',
              onTap: () {},
            ),
            buildTile(
              icon: Icons.confirmation_number_outlined,
              title: 'Vouchers',
              onTap: () {},
            ),
            buildTile(
              icon: Icons.article_outlined,
              title: 'Terms & policies',
              onTap: () {},
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const Login()));
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Color(0xFF7D7676)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Log out',
                  style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w500,letterSpacing: 1.2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Version 1.0.0',
                style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF676161),letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _quickActionCard({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 38,),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFF5F3F3)),
          boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFF242121), size: 24),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF242121),letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Color iconColor = Colors.black,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: Color(0xFF595353)),
        title: Text( title,
          style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF595353),letterSpacing: 1.2),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Color(0xFF595353),
        ),
        onTap: onTap,
      ),
    );
  }
}

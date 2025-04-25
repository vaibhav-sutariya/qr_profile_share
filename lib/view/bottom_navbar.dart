import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view/contacts/contacts_screen.dart';
import 'package:qr_profile_share/view/home/home_screen.dart';
import 'package:qr_profile_share/view/my_qr/my_qr_screen.dart';
import 'package:qr_profile_share/view/profile/profile_screen.dart';
import 'package:qr_profile_share/view/scan/scan_screen.dart';
import 'package:qr_profile_share/view_model/services/bottom_navbar/bottom_navbar_provider.dart';

class BottomNavBar extends StatelessWidget {
  // final QrCodeDataViewModel qrCodeDataViewModel;
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // log("BottomNavBar : ${qrCodeDataViewModel.id} ");
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: PageView(
            controller: provider.pageController,
            onPageChanged: provider.onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ScanScreen(),
              MyQrScreen(),
              ContactsScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 12,
              currentIndex: provider.currentIndex,
              onTap: provider.updateIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.lightColor,
              showUnselectedLabels: true,
              elevation: 0,
              items: [
                _buildNavItem(provider, 0, Feather.home, 'Home'),
                _buildNavItem(provider, 1, AntDesign.scan1, 'Scan'),
                _buildNavItem(provider, 2, AntDesign.qrcode, 'My QR'),
                _buildNavItem(provider, 3, AntDesign.contacts, 'Contacts'),
                _buildNavItem(provider, 4, AntDesign.user, 'Profile'),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BottomNavBarProvider provider,
    int index,
    IconData icon,
    String label,
  ) {
    bool isSelected = provider.currentIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? AppColors.primaryColor : AppColors.lightColor,
          ),
          const SizedBox(height: 4),
        ],
      ),
      label: label,
    );
  }
}

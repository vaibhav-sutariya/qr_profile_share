import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/back_button_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool isBackButtonVisible;
  final VoidCallback? onPressed;
  final bool isActionButtonVisible;
  final IconData icon;
  @override
  Size get preferredSize => const Size.fromHeight(58.0); // Default AppBar height

  const CustomAppBar({
    super.key,
    required this.text,
    this.isBackButtonVisible = false,
    this.onPressed,
    this.isActionButtonVisible = false,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * -50), // Slide from top
            child: child,
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.gradientColor,

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),

        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: isActionButtonVisible ? false : true,
          leading:
              isBackButtonVisible
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BackButtonWidget(),
                  )
                  : null,
          title: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions:
              isActionButtonVisible
                  ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                            icon,
                            size: 25,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ]
                  : null,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

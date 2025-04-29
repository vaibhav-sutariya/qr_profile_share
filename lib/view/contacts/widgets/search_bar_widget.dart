import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/view_model/controller/contact/contact_view_model.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, contactVM, child) {
        return Row(
          children: [
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 100.0, end: 0.0),
                duration: Duration(milliseconds: 600),

                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(-value, 0), // Slide from left to right
                    child: Opacity(
                      opacity: 1 - (value / 100), // fade in effect
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  child: CustomTextField(
                    bgColor: AppColors.whiteColor,
                    isBoxShadow: true,
                    icon: Feather.search,
                    text: 'Search Contacts',
                    onChanged: (value) {
                      contactVM.onSearchChanged(value);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 100.0, end: 0.0),
              duration: Duration(milliseconds: 600),

              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0), // X-axis slide
                  child: Opacity(
                    opacity: 1 - (value / 100), // fade in effect
                    child: child,
                  ),
                );
              },
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Feather.filter, color: Colors.blue, size: 20),
                  onPressed:
                      () => contactVM.onFilterPressed(
                        'filterValue',
                      ), // Pass the filter value as needed
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

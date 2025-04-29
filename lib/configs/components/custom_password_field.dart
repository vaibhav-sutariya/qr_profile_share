import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool? isConfirm;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.isConfirm = false,
    this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 100.0, end: 0.0),
      duration: const Duration(milliseconds: 550),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: Opacity(opacity: 1 - (value / 100), child: child),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              keyboardType: TextInputType.visiblePassword,
              onChanged: widget.onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Feather.lock,
                  color: AppColors.darkColor,
                  size: 20,
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppColors.lightColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.darkColor,
                  ),
                  onPressed: _toggleVisibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

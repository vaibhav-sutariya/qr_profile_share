import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/back_button_widget.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/configs/components/tappable_text.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/forgot_password_view_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordViewModel>(
      builder: (context, forgotPasswordViewModel, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.gradientColor),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    BackButtonWidget(),
                    SizedBox(height: 50),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 100.0, end: 0.0),
                      duration: Duration(milliseconds: 500),

                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value, 0), // X-axis slide
                          child: Opacity(
                            opacity: 1 - (value / 100), // fade in effect
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 100.0, end: 0.0),
                      duration: Duration(milliseconds: 500),

                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value, 0), // X-axis slide
                          child: Opacity(
                            opacity: 1 - (value / 100), // fade in effect
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        'Enter your email address and we\'ll send you instruction to reset your password.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 100.0, end: 0.0),
                      duration: Duration(milliseconds: 550),

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
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: Column(
                            spacing: 20,
                            children: [
                              CustomTextField(
                                onChanged: (value) {
                                  forgotPasswordViewModel.updateEmail(value);
                                },
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                                text: 'Email',
                              ),

                              forgotPasswordViewModel.forgotPasswordLoading
                                  ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                  : // Custom Elevated Button
                                  CustomElevatedButton(
                                    duration: 600,
                                    text: 'Send Reset Instructions',
                                    onPress: () {
                                      forgotPasswordViewModel.forgotPassword(
                                        context,
                                      );
                                    },
                                  ),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 100.0, end: 0.0),
                                duration: Duration(milliseconds: 550),

                                builder: (context, value, child) {
                                  return Transform.translate(
                                    offset: Offset(-value, 0), // X-axis slide
                                    child: Opacity(
                                      opacity:
                                          1 - (value / 100), // fade in effect
                                      child: child,
                                    ),
                                  );
                                },
                                child: TappableText(
                                  alignmet: Alignment.centerLeft,

                                  text: 'Back to Sign In',
                                  onPress:
                                      () => Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesName.loginScreen,
                                        (route) => false,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

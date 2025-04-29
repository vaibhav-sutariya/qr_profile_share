import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/assets/icons_assets.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/auth/social_login/widgets/custom_social_button.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/social_login_view_model.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialLoginViewModel>(
      builder: (context, value, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.gradientColor),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          'Continue with Social',
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
                        duration: Duration(milliseconds: 530),

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
                          'Choose your preferred social login method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      value.googleSignInLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                            ),
                          )
                          : CustomSocialButton(
                            duration: 500,
                            text: 'Sign in with Google',
                            imagePath: IconsAssets.google,
                            onPressed: () {
                              value.googleSignIn(context);
                            },
                          ),
                      SizedBox(height: 8),

                      CustomSocialButton(
                        duration: 600,
                        text: 'Sign in with Facebook',
                        imagePath: IconsAssets.facebook,
                        onPressed: () {},
                      ),
                      SizedBox(height: 8),

                      CustomSocialButton(
                        duration: 700,
                        text: 'Sign in with Apple',
                        imagePath: IconsAssets.apple,
                        onPressed: () {},
                      ),
                      SizedBox(height: 8),

                      CustomSocialButton(
                        duration: 800,
                        text: 'Continue with Email',
                        imagePath: IconsAssets.email,
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.loginScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

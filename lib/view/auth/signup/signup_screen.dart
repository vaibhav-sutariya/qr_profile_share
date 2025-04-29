import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/back_button_widget.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/custom_password_field.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/auth/signup/widgets/pass_req_widget.dart';
import 'package:qr_profile_share/view/auth/widgets/have_account_text.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/signup_view_model.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, signupViewModel, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: AppColors.gradientColor),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32),
                      BackButtonWidget(),
                      SizedBox(height: 15),
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
                          'Create Account',
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
                          'Join our community of professionals',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                                  onChanged:
                                      (value) =>
                                          signupViewModel.updateName(value),
                                  keyboardType: TextInputType.name,
                                  icon: Feather.user,
                                  text: 'Full Name',
                                ),
                                CustomTextField(
                                  onChanged:
                                      (value) =>
                                          signupViewModel.updateEmail(value),
                                  keyboardType: TextInputType.emailAddress,
                                  icon: Icons.email_outlined,
                                  text: 'Email',
                                ),
                                CustomPasswordField(
                                  hintText: "Password",
                                  onChanged:
                                      (value) =>
                                          signupViewModel.updatePassword(value),
                                ),
                                CustomPasswordField(
                                  hintText: "Confirm Password",
                                  onChanged:
                                      (value) => signupViewModel
                                          .updateConfirmPassword(value),
                                ),

                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 100.0, end: 0.0),
                                  duration: Duration(milliseconds: 500),

                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(value, 0), // X-axis slide
                                      child: Opacity(
                                        opacity:
                                            1 - (value / 100), // fade in effect
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(top: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightColor.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 10,
                                      children: [
                                        Text(
                                          'Password must contain:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        PassReqWidget(
                                          text: 'At least 8 characters',
                                          color:
                                              signupViewModel.hasMinLength
                                                  ? AppColors.successColor
                                                  : AppColors.darkColor
                                                      .withOpacity(0.5),
                                        ),
                                        PassReqWidget(
                                          text: 'One uppercase letter',
                                          color:
                                              signupViewModel.hasUppercase
                                                  ? AppColors.successColor
                                                  : AppColors.darkColor
                                                      .withOpacity(0.5),
                                        ),
                                        PassReqWidget(
                                          text: 'One lowercase letter',
                                          color:
                                              signupViewModel.hasLowercase
                                                  ? AppColors.successColor
                                                  : AppColors.darkColor
                                                      .withOpacity(0.5),
                                        ),
                                        PassReqWidget(
                                          text: 'One number',
                                          color:
                                              signupViewModel.hasNumber
                                                  ? AppColors.successColor
                                                  : AppColors.darkColor
                                                      .withOpacity(0.5),
                                        ),
                                        PassReqWidget(
                                          text: 'One special Characters',
                                          color:
                                              signupViewModel.hasSpecialChar
                                                  ? AppColors.successColor
                                                  : AppColors.darkColor
                                                      .withOpacity(0.5),
                                        ),
                                        if (signupViewModel
                                                .confirmPassword
                                                .isNotEmpty &&
                                            !signupViewModel.passwordsMatch)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: Text(
                                              'Passwords do not match',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

                                signupViewModel.signupLoading
                                    ? CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    )
                                    : CustomElevatedButton(
                                      text: 'Create Account',
                                      onPress: () {
                                        signupViewModel.signUpUser(context);
                                      },
                                    ),
                                HaveAccountText(
                                  text: 'Already have an account?',
                                  tappableText: 'Sign In',
                                  onPress:
                                      () => Navigator.pushNamed(
                                        context,
                                        RoutesName.loginScreen,
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
          ),
        );
      },
    );
  }
}

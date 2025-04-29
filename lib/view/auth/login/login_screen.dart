import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/back_button_widget.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/custom_password_field.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/configs/components/tappable_text.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/auth/widgets/have_account_text.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, loginViewModel, child) {
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
                        'Welcome Back',
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
                        'Sign in to continue',
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
                                onChanged: (value) {
                                  loginViewModel.updateEmail(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                  ).hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },

                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                                text: 'Email',
                              ),
                              CustomPasswordField(
                                hintText: "Password",
                                onChanged: (value) {
                                  loginViewModel.updatePassword(value);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }

                                  return null;
                                },
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 100.0, end: 0.0),
                                duration: Duration(milliseconds: 600),

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
                                child: TappableText(
                                  text: 'Forgot Password?',
                                  onPress:
                                      () => Navigator.pushNamed(
                                        context,
                                        RoutesName.forgotPasswordScreen,
                                      ),
                                  alignmet: Alignment.centerRight,
                                ),
                              ),
                              loginViewModel.loginLoading
                                  ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                  : CustomElevatedButton(
                                    btnColor:
                                        loginViewModel.isLoginButtonEnabled
                                            ? AppColors.primaryColor
                                            : AppColors.lightColor,

                                    text: 'Sign In',
                                    onPress: () {
                                      loginViewModel.login(context);
                                    },
                                  ),
                              HaveAccountText(
                                text: 'Don\'t have an account?',
                                tappableText: 'Sign Up',
                                onPress:
                                    () => Navigator.pushNamed(
                                      context,
                                      RoutesName.signUpScreen,
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

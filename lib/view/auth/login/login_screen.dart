import 'package:animate_do/animate_do.dart';
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
                    FadeInRight(
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
                    FadeInRight(
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
                    FadeInRight(
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
                              FadeInRight(
                                child: CustomTextField(
                                  onChanged: (value) {
                                    loginViewModel.updateEmail(value);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  icon: Icons.email_outlined,
                                  text: 'Email',
                                ),
                              ),
                              FadeInRight(
                                child: CustomPasswordField(
                                  hintText: "Password",
                                  onChanged: (value) {
                                    loginViewModel.updatePassword(value);
                                  },
                                ),
                              ),
                              FadeInRight(
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
                              FadeInRight(
                                child:
                                    loginViewModel.loginLoading
                                        ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                        : CustomElevatedButton(
                                          text: 'Sign In',
                                          onPress: () {
                                            loginViewModel.login(context);
                                          },
                                        ),
                              ),
                              FadeInRight(
                                child: HaveAccountText(
                                  text: 'Don\'t have an account?',
                                  tappableText: 'Sign Up',
                                  onPress:
                                      () => Navigator.pushNamed(
                                        context,
                                        RoutesName.signUpScreen,
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

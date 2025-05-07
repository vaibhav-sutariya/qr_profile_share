import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/routes/routes.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/forgot_password_view_model.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/login_view_model.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/signup_view_model.dart';
import 'package:qr_profile_share/view_model/controller/auth_provider/social_login_view_model.dart';
import 'package:qr_profile_share/view_model/controller/contact/add_contact_view_model.dart';
import 'package:qr_profile_share/view_model/controller/contact/contact_view_model.dart';
import 'package:qr_profile_share/view_model/controller/home/home_view_model.dart';
import 'package:qr_profile_share/view_model/controller/my_qr/my_qr_view_model.dart';
import 'package:qr_profile_share/view_model/controller/nfc_provider/nfc_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/update_profile_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/user_profile_view_model.dart';
import 'package:qr_profile_share/view_model/controller/scan/scan_view_model.dart';
import 'package:qr_profile_share/view_model/services/bottom_navbar/bottom_navbar_provider.dart';
import 'package:qr_profile_share/view_model/services/mode_toggle/mode_toggle_view_model.dart';
import 'package:qr_profile_share/view_model/services/qr_code_services/qr_code_data_view_model.dart';
import 'package:qr_profile_share/view_model/services/session_manager/session_controller.dart';
import 'package:qr_profile_share/view_model/services/splash_service/splash_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isVisited = false;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA4L11t-ZzFGmfx4s016j6SVqNpQ83zqgk",
      appId: "1:439520334429:android:fd25b7fe49e219c047f3b4",
      messagingSenderId: "439520334429",
      projectId: "quickhitch-7347",
    ),
  );

  try {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    final bool isLoggedIn = SessionController().isLogin;

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      log('Dynamic Link (cold start): $deepLink');

      if (deepLink.pathSegments.isNotEmpty) {
        Navigator.pushReplacementNamed(
          navigatorKey.currentContext!,
          isLoggedIn ? RoutesName.dynamicProfileScreen : RoutesName.loginScreen,
          arguments: isLoggedIn ? deepLink.toString() : null,
        );
      }
    }

    FirebaseDynamicLinks.instance.onLink
        .listen((dynamicLinkData) {
          final Uri deepLink = dynamicLinkData.link;
          log('Dynamic Link (foreground): $deepLink');

          final bool isLoggedIn = SessionController().isLogin;

          if (deepLink.pathSegments.isNotEmpty) {
            Navigator.pushReplacementNamed(
              navigatorKey.currentContext!,
              isLoggedIn
                  ? RoutesName.dynamicProfileScreen
                  : RoutesName.loginScreen,
              arguments: isLoggedIn ? deepLink.toString() : deepLink.toString(),
            );
          }
        })
        .onError((e) {
          log('Dynamic link error: $e');
        });
  } catch (e) {
    log('Error handling dynamic link: $e');
  }

  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  isVisited = prefs.getBool('isOnBoardingVisited') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashServices()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => SocialLoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ScanViewModel()),
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
        ChangeNotifierProvider(create: (_) => QrCodeDataViewModel()),
        ChangeNotifierProvider(create: (_) => UpdateProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileSettingViewModel()),
        ChangeNotifierProvider(create: (_) => ModeToggleViewModel()),
        ChangeNotifierProvider(create: (_) => MyQrViewModel()),
        ChangeNotifierProvider(create: (_) => ContactViewModel()),
        ChangeNotifierProvider(create: (_) => ContactViewModel()),
        ChangeNotifierProvider(create: (_) => AddContactViewModel()),
        ChangeNotifierProvider(create: (_) => NFCViewModel()),
      ],
      child: MaterialApp(
        title: 'QR Profile Share',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor,
          primaryColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
            error: AppColors.errorColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            scrolledUnderElevation: 0.0,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
        ),
        initialRoute:
            isVisited ? RoutesName.splash : RoutesName.onBoardingScreen,
        // home: OpenappScreen(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

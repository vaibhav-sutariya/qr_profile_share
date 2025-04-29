import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/configs/routes/routes_name.dart';
import 'package:qr_profile_share/view/my_qr/widgets/appbar/qr_appbar_widget.dart';
import 'package:qr_profile_share/view/my_qr/widgets/custom_tile_widget.dart';
import 'package:qr_profile_share/view/my_qr/widgets/m_qr_analytics_widget.dart';
import 'package:qr_profile_share/view/my_qr/widgets/qr_action_widget.dart';
import 'package:qr_profile_share/view/my_qr/widgets/qr_card_widget.dart';
import 'package:qr_profile_share/view_model/controller/my_qr/my_qr_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyQrViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: getScreenHeight(context) * 0.17,
                    backgroundColor: Colors.transparent,
                    pinned: false,
                    floating: true,
                    snap: true,
                    elevation: 0,
                    flexibleSpace: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              (1 - value) * -50,
                            ), // Slide from top
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientColor2,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    title: QrAppbarWidget(),
                    // actions: [AppbarActionWidget()],
                  ),
                ],
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    QrCardWidget(),
                    SizedBox(height: 30),
                    QrActionWidget(),
                    SizedBox(height: 30),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 100.0, end: 0.0),
                      duration: Duration(milliseconds: 500),

                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-value, 0), // X-axis slide
                          child: Opacity(
                            opacity: 1 - (value / 100), // fade in effect
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        'QR Code Settings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    CustomTileWidget(
                      duration: 500,
                      icon: Icons.access_time,
                      onChanged: (value) {},
                      title: 'Expiration',
                      subTitle: 'Never expires',
                      value: false,
                      isSwitchEnabled: false,
                    ),
                    SizedBox(height: 20),
                    CustomTileWidget(
                      duration: 600,
                      icon: Icons.shield_outlined,
                      onChanged: (value) {},
                      title: 'Privacy Mode',
                      subTitle: 'Public Profile',
                      value: false,
                      isSwitchEnabled: false,
                    ),
                    SizedBox(height: 20),
                    CustomTileWidget(
                      duration: 700,
                      icon: Icons.error_outline,
                      onChanged: (value) {
                        viewModel.toggleDynamicQr(value);
                      },
                      title: 'Dynamic QR',
                      subTitle: 'Auto updates when profile changes',
                      value: viewModel.dynamicQr,
                      isSwitchEnabled: true,
                    ),
                    SizedBox(height: 20),
                    CustomTileWidget(
                      duration: 800,
                      icon: Feather.users,
                      onChanged: (value) {
                        viewModel.toggleNFCSharing(value);
                      },
                      title: 'NFC Sharing',
                      subTitle: 'One Tap contact sharing',
                      value: viewModel.nfcSharing,
                      isSwitchEnabled: true,
                    ),
                    SizedBox(height: 30),
                    Consumer<ProfileSettingViewModel>(
                      builder: (context, value, child) {
                        return CustomElevatedButton(
                          text: 'Customize QR Theme',
                          onPress: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.profileSettingsScreen,
                            );
                            value.currentTabIndex = 3;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30),

                    MQrAnalyticsWidget(),
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

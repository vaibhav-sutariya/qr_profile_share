import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view/home/widgets/appbar/appbar_action_widget.dart';
import 'package:qr_profile_share/view/home/widgets/appbar/appbar_text_widget.dart';
import 'package:qr_profile_share/view/home/widgets/industry_templates_widget.dart';
import 'package:qr_profile_share/view/home/widgets/qr_analytics_widget.dart';
import 'package:qr_profile_share/view/home/widgets/quick_action_widget.dart';
import 'package:qr_profile_share/view/home/widgets/recent_connection_widget.dart';
import 'package:qr_profile_share/view/home/widgets/smart_features_widget.dart';
import 'package:qr_profile_share/view/home/widgets/top_widget.dart';
import 'package:qr_profile_share/view/home/widgets/upcoming_event_widget.dart';

class HomeScreen extends StatelessWidget {
  // final QrCodeDataViewModel qrCodeDataViewModel;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // log("HomeScreen : ${qrCodeDataViewModel.id} ");
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: getScreenHeight(context) * 0.09,
                backgroundColor: Colors.transparent,
                pinned: false,
                floating: true,
                snap: true,
                elevation: 0,
                flexibleSpace: SlideInDown(
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
                title: AppbarTextWidget(),
                actions: [AppbarActionWidget()],
              ),
            ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 10),
              // TopWidget(qrCodeDataViewModel: qrCodeDataViewModel),
              TopWidget(),
              QrAnalyticsWidget(),
              SizedBox(height: 20),
              QuickActionWidget(),
              SizedBox(height: 20),
              SmartFeaturesWidget(),
              SizedBox(height: 20),
              UpcomingEventsWidget(),
              SizedBox(height: 20),
              RecentConnectionsWidget(),
              SizedBox(height: 20),
              IndustryTemplatesWidget(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

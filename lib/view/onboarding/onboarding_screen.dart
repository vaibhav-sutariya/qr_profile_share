import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/utils/page_view.dart';
import 'package:qr_profile_share/view_model/controller/onboarding_provider/onboarding_view_model.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            body: ConcentricPageView(
              radius: 40,
              colors: viewModel.items.map((e) => e.backgroundColor).toList(),
              itemCount: viewModel.items.length,
              direction: Axis.vertical,
              onChange: (page) => viewModel.updatePage(page),
              onFinish: () => viewModel.completeOnboarding(context),
              itemBuilder: (index, value) {
                final data = viewModel.items[index];
                return SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: Text(
                            "${viewModel.currentPage + 1}/${viewModel.items.length}",
                            style: TextStyle(color: data.titleColor),
                          ),
                        ),
                      ),
                      Expanded(child: _ItemWidget(data: data)),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.data});

  final OnboardingItem data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: data.image),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          color: data.titleColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        data.subtitle,
                        style: TextStyle(
                          color: data.subtitleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

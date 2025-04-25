import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/model/home/template_model.dart';
import 'package:qr_profile_share/view_model/controller/home/home_view_model.dart';

class IndustryTemplatesWidget extends StatelessWidget {
  const IndustryTemplatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final templateVM = Provider.of<HomeViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Industry Templates',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: getScreenHeight(context) * 0.21,
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            padding: const EdgeInsets.all(4),
            scrollDirection: Axis.horizontal,
            itemCount: templateVM.templates.length,
            itemBuilder: (context, index) {
              return TemplateCardWidget(template: templateVM.templates[index]);
            },
          ),
        ),
      ],
    );
  }
}

class TemplateCardWidget extends StatelessWidget {
  final TemplateModel template;

  const TemplateCardWidget({super.key, required this.template});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidth(context) * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(template.iconPath, height: 28, width: 28),
          ),
          const SizedBox(height: 20),
          Text(
            template.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            template.description,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

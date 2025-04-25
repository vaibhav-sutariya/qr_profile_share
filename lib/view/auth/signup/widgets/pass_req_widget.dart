import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PassReqWidget extends StatelessWidget {
  final String text;
  final Color color;
  const PassReqWidget({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          AntDesign.checkcircleo,
          // color: AppColors.lightColor.withOpacity(0.5),
          color: color,
          size: 12,
        ),
        SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_profile_share/configs/responsive.dart';
import 'package:qr_profile_share/view_model/controller/my_qr/my_qr_view_model.dart';
import 'package:qr_profile_share/view_model/controller/profile/profile_setting_view_model.dart';
import 'package:qr_profile_share/view_model/services/qr_code_services/qr_code_data_view_model.dart';

class MyQrWidget extends StatelessWidget {
  final double size;
  const MyQrWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Consumer2<QrCodeDataViewModel, ProfileSettingViewModel>(
      builder: (context, qrCodedataVM, profileSettingVM, child) {
        return RepaintBoundary(
          key: context.read<MyQrViewModel>().qrKey,
          child: QrImageView(
            dataModuleStyle: QrDataModuleStyle(color: profileSettingVM.qrColor),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: profileSettingVM.qrColor,
            ),
            data: jsonEncode({
              "id": qrCodedataVM.id,
              "name": qrCodedataVM.name,
              "email": qrCodedataVM.email,
              "photo": qrCodedataVM.photo,
              "position": qrCodedataVM.position,
              "location": qrCodedataVM.location,
            }),
            version: QrVersions.auto,
            size: getScreenHeight(context) * size,
            embeddedImage:
                profileSettingVM.qrLogo != null
                    ? FileImage(profileSettingVM.qrLogo!) as ImageProvider
                    : null,
            embeddedImageStyle: QrEmbeddedImageStyle(size: const Size(40, 40)),
          ),
        );
      },
    );
  }
}

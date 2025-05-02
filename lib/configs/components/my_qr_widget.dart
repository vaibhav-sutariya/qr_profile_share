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
        // Replace with your actual domain and parameters
        final String dynamicLink =
            qrCodedataVM.dynamicLink.isNotEmpty
                ? qrCodedataVM.dynamicLink
                : 'https://randomqr.page.link/?link=https%3A%2F%2Fqr-profile-share-backend.onrender.com%2Fapi%2Fv1%2Fusers%2FgetOneUser%2F6800b87b4ae12c230f1e126c&apn=com.example.qr_profile_share&afl=https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.quikhitch';

        return RepaintBoundary(
          key: context.read<MyQrViewModel>().qrKey,
          child: QrImageView(
            dataModuleStyle: QrDataModuleStyle(color: profileSettingVM.qrColor),
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: profileSettingVM.qrColor,
            ),
            data: dynamicLink, // Dynamic Link
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

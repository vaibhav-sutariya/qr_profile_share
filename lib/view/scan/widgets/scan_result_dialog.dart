import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/assets/image_assets.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/view_model/controller/scan/scan_view_model.dart';

class ScanResultDialog extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onClose;

  const ScanResultDialog({
    super.key,
    required this.data,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    log('ScanResultDialog data: $data');
    final sId = data['_id'] ?? 'Unknown ID';
    final name = data['name'] ?? 'Unknown User';
    final email = data['email'] ?? 'No email provided';
    final location = data['location'] ?? 'Location not available';
    final photo = data['photo'];
    final userRole = data['userRole'] ?? 'No role provided';
    return Consumer<ScanViewModel>(
      builder: (context, viewModel, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        photo != null && photo!.isNotEmpty
                            ? CachedNetworkImageProvider(photo!)
                            : const AssetImage(ImageAssets.bookImg)
                                as ImageProvider,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Text(
                    name ?? 'Unknown User',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Email
                  Text(
                    email ?? 'No email provided',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),

                  // Email
                  Text(
                    userRole ?? 'No email provided',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          location ?? 'Location not available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    onChanged: (value) {
                      viewModel.setTags(value);
                    },
                    icon: Icons.tag,
                    text: 'Tag the contact',
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(AntDesign.closecircleo),
                        label: const Text("Close"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redColor,
                          foregroundColor: AppColors.whiteColor,
                          iconColor: AppColors.whiteColor,
                          iconSize: 14,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      viewModel.adduserProfileLoading
                          ? CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                          : ElevatedButton.icon(
                            onPressed: () async {
                              log('Add button pressed for user: $sId');
                              viewModel.addContact(sId!, context);
                            },
                            icon: const Icon(AntDesign.pluscircleo),
                            label: const Text("Add"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor,
                              iconColor: AppColors.whiteColor,
                              iconSize: 14,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

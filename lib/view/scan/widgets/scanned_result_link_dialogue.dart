import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/view_model/controller/scan/scan_view_model.dart';

class ScannedResultLinkDialogue extends StatefulWidget {
  final String id;

  const ScannedResultLinkDialogue({super.key, required this.id});

  @override
  State<ScannedResultLinkDialogue> createState() =>
      _ScannedResultLinkDialogueState();
}

class _ScannedResultLinkDialogueState extends State<ScannedResultLinkDialogue> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final scanVM = Provider.of<ScanViewModel>(context, listen: false);
      scanVM.fetchScannedUser(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScanViewModel>(
      builder: (context, scanVM, child) {
        final isLoading = scanVM.isLoading;
        final userData = scanVM.userMode?.data?.user;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : userData == null
                    ? const Text("Failed to load user data")
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              userData.photo != null &&
                                      userData.photo!.isNotEmpty
                                  ? CachedNetworkImageProvider(userData.photo!)
                                  : const AssetImage(
                                        "assets/images/default_avatar.png",
                                      )
                                      as ImageProvider,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 16),

                        // Name
                        Text(
                          userData.name ?? 'Unknown User',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Email
                        Text(
                          userData.email ?? 'No email provided',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Role
                        Text(
                          userData.userRole ?? 'No role provided',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
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
                                userData.location ?? 'Location not available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
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
                            scanVM.adduserProfileLoading
                                ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                                : ElevatedButton.icon(
                                  onPressed: () async {
                                    log(
                                      'Add button pressed for user: ${userData.sId}',
                                    );
                                    scanVM.addContact(userData.sId!, context);
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
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';
import 'package:qr_profile_share/configs/components/custom_app_bar.dart';
import 'package:qr_profile_share/configs/components/custom_elevated_button.dart';
import 'package:qr_profile_share/configs/components/custom_text_field.dart';
import 'package:qr_profile_share/view_model/controller/scan/scan_view_model.dart';

class DynamicProfileScreen extends StatefulWidget {
  final String userId;

  const DynamicProfileScreen({super.key, required this.userId});

  @override
  State<DynamicProfileScreen> createState() => _DynamicProfileScreenState();
}

class _DynamicProfileScreenState extends State<DynamicProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final scanVM = Provider.of<ScanViewModel>(context, listen: false);
      scanVM.fetchScannedUser(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    log('User ID: ${widget.userId}'); // Log the userId for debugging
    // Fetch and display user profile using userId
    return Consumer<ScanViewModel>(
      builder: (context, scanVM, child) {
        final isLoading = scanVM.isLoading;
        final userData = scanVM.userMode?.data?.user;
        return Scaffold(
          appBar: CustomAppBar(
            text: "Scanned User Profile",
            isBackButtonVisible: false,
          ),
          body: Padding(
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 16),
                        CustomTextField(
                          onChanged: (value) {
                            scanVM.setTags(value);
                          },
                          icon: Icons.tag,
                          text: 'Tag the contact',
                        ),

                        const SizedBox(height: 30),
                        scanVM.adduserProfileLoading
                            ? CircularProgressIndicator()
                            : CustomElevatedButton(
                              text: 'Add Contact',
                              onPress: () {
                                log(
                                  'Add Contact button pressed for user: ${userData.sId}',
                                );
                                scanVM.addContact(userData.sId!, context);
                              },
                            ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}

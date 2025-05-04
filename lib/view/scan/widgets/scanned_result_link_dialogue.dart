import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_profile_share/configs/colors/app_colors.dart';

class ScannedResultLinkDialogue extends StatelessWidget {
  final String id;

  const ScannedResultLinkDialogue({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    log('ScannedResultLinkDialogue data: $id');
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Scanned Result',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'User ID: $id',
                style: TextStyle(fontSize: 18, color: AppColors.secondaryColor),
              ),
              // Profile Image
              // CircleAvatar(
              //   radius: 50,
              //   backgroundImage:
              //       photo.isNotEmpty
              //           ? NetworkImage(photo)
              //           : const AssetImage(ImageAssets.bookImg)
              //               as ImageProvider,
              //   backgroundColor: Colors.grey.shade200,
              // ),
              // const SizedBox(height: 16),

              // // Name
              // Text(
              //   name ?? 'Unknown User',
              //   style: const TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),

              // const SizedBox(height: 8),

              // // Email
              // Text(
              //   email ?? 'No email provided',
              //   style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              // ),
              // const SizedBox(height: 8),

              // // Email
              // Text(
              //   userRole ?? 'No email provided',
              //   style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              // ),

              // const SizedBox(height: 8),

              // // Location
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Icon(
              //       Icons.location_on,
              //       color: AppColors.redColor,
              //       size: 20,
              //     ),
              //     const SizedBox(width: 6),
              //     Flexible(
              //       child: Text(
              //         location ?? 'Location not available',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.grey.shade700,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 20),

              // // Buttons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon: const Icon(AntDesign.closecircleo),
              //       label: const Text("Close"),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: AppColors.redColor,
              //         foregroundColor: AppColors.whiteColor,
              //         iconColor: AppColors.whiteColor,
              //         iconSize: 14,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //       ),
              //     ),
              //     Consumer<ScanViewModel>(
              //       builder: (context, value, child) {
              //         return value.adduserProfileLoading
              //             ? CircularProgressIndicator(
              //               color: AppColors.primaryColor,
              //             )
              //             : ElevatedButton.icon(
              //               onPressed: () async {
              //                 log('Add button pressed for user: $sId');
              //                 value.addContact(sId, context);
              //               },
              //               icon: const Icon(AntDesign.pluscircleo),
              //               label: const Text("Add"),
              //               style: ElevatedButton.styleFrom(
              //                 backgroundColor: AppColors.primaryColor,
              //                 foregroundColor: AppColors.whiteColor,
              //                 iconColor: AppColors.whiteColor,
              //                 iconSize: 14,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(12),
              //                 ),
              //               ),
              //             );
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

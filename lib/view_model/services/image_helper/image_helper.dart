import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageHelper {
  static Widget imageOrPlaceholder(File? imagePath, double size) {
    if (imagePath == null || !imagePath.existsSync()) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: const Color(0xFFF1F1F1),
        child: const Icon(Icons.person, size: 40, color: Colors.grey),
      );
    } else {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: FileImage(imagePath),
      );
    }
  }

  Future<String?> uploadImageToCloudinary(File image) async {
    try {
      final cloudinary = CloudinaryPublic(
        dotenv.env['CLOUDINARY_CLOUD_NAME']!,
        dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
        cache: false,
      );
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: 'user_profiles'),
      );
      return response.secureUrl;
    } catch (e) {
      log('Cloudinary Upload Error: $e');
      return null;
    }
  }
}

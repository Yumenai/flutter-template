import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaUtility {
  static Future<File?> pickImageFromCamera() async {
    return _pickImage(ImageSource.camera);
  }

  static Future<File?> pickImageFromGallery() async {
    return _pickImage(ImageSource.gallery);
  }

  static Future<File?> _pickImage(final ImageSource source) async {
    final result = await ImagePicker().pickImage(source: source);

    if (result == null) {
      return null;
    }

    return File(result.path);
  }

  const MediaUtility._();
}
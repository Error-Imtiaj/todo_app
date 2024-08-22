
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

 imagePick(ImageSource Source) async {
  final picker = ImagePicker();
  XFile? File = await picker.pickImage(source: Source);
  if (File != null) {
    return await File.readAsBytes();
  }
  print("No images selected");
}

Future<Uint8List?> pickImagfe() async {
    try {
      final Uint8List? image = await imagePick(ImageSource.gallery);
      return image;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
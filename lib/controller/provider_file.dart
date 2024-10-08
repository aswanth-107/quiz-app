import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quiz_app/input_details.dart';

class FunctionsProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  File? image;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Uint8List? _imageBytes;

  // Getter and Setter for imageBytes
  Uint8List? get imageBytes => _imageBytes;
  set imageBytes(Uint8List? value) {
    _imageBytes = value;
    notifyListeners();
  }

  final ImagePicker picker = ImagePicker();
  String? downloadURL;
  bool showPhotoError = false;

  Future<void> uploadImageAndName({
    required BuildContext context,
    required int score,
    required int timeTaken,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      if (imageBytes != null) {
        // Generate a unique filename for the image
        final filename =
            '${nameController.text}_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Upload the image to Firebase Storage
        final storageref =
            FirebaseStorage.instance.ref().child('upload/$filename');
        final uploadTask = storageref.putData(imageBytes!);
        await uploadTask.whenComplete(() => null);
        final url = await storageref.getDownloadURL();

        downloadURL = url;

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').add({
          'user_name': nameController.text,
          'photo': url,
          'score': score.toString(),
          'time_taken': timeTaken.toString(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image and name uploaded successfully')),
        );

        // Navigate to the next page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const LoginScreen(), // Make sure LoginScreen exists
          ),
          (route) => false,
        );

        // Clear data after upload
        nameController.clear();
        imageBytes = null; // Reset imageBytes after upload
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload image and name')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getImage(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        if (kIsWeb) {
          // For web, use the bytes directly
          imageBytes = await pickedFile.readAsBytes();
        } else {
          // For mobile, use the file path
          io.File imageFile = io.File(pickedFile.path);
          imageBytes = await imageFile.readAsBytes();
        }

        showPhotoError = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image. Please try again.'),
        ),
      );
    }
  }

  Future<void> submitData({
    required BuildContext context,
    required int score,
    required int totalQuestions,
    required int timeTaken,
  }) async {
    if (formKey.currentState!.validate()) {
      if (imageBytes != null) {
        await uploadImageAndName(
          context: context,
          score: score,
          timeTaken: timeTaken,
        );
      } else {
        showPhotoError = true;
        notifyListeners();
      }
    }
  }
}

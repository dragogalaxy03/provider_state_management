import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MediaViewModel extends ChangeNotifier {
  List<String> selectedMediaTypes = [];
  List<File> mediaFiles = [];
  final List<String> mediaCategories = ["Interior", "Exterior", "Product", "Team", "Additional"];

  final ImagePicker _picker = ImagePicker();

  void toggleMediaType(String type) {
    if (selectedMediaTypes.contains(type)) {
      selectedMediaTypes.remove(type);
    } else {
      selectedMediaTypes.add(type);
    }
    notifyListeners();
  }

  Future<void> pickMedia() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      mediaFiles.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  bool validateSelection() {
    if (selectedMediaTypes.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please select a media type",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
    return true;
  }

  void publishMedia(BuildContext context) {
    if (!validateSelection()) return;

    Map<String, List<String>> mediaMap = {};
    for (var type in selectedMediaTypes) {
      mediaMap[type] = mediaFiles.map((file) => file.path).toList();
    }

    debugPrint("Media Uploaded: $mediaMap");
    mediaFiles.clear();
    selectedMediaTypes.clear();
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Media Published Successfully"), backgroundColor: Colors.green),
    );
  }
}



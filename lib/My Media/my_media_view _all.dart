import 'dart:ui';
import 'package:flutter/material.dart';
import 'my_media_data_model.dart';

class ViewAllScreen extends StatelessWidget {
  final MyMediaItem mediaItem;

  ViewAllScreen({required this.mediaItem});

  void showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true, // Close on tapping outside
      builder: (context) {
        return Stack(
          children: [
            // Blurred Background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),

            // Centered Enlarged Image
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // Close on tap
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), // Smooth rounded corners
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
                    height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mediaItem.category),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: mediaItem.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showFullScreenImage(context, mediaItem.images[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                mediaItem.images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

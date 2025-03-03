import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:newday/My%20Media/my_media_upload_screen.dart';
import 'my_media_data_model.dart';
import 'my_media_view _all.dart';

class MyMediaScreen extends StatefulWidget {
  @override
  _MyMediaScreenState createState() => _MyMediaScreenState();
}

class _MyMediaScreenState extends State<MyMediaScreen> {
  bool isGridView = false;
  final List<MyMediaItem> mediaData = [
    MyMediaItem(
      category: 'Interior',
      images: [
        'assets/images/interior1.jpg',
        'assets/images/interior2.jpg',
        'assets/images/interior3.jpg',
        'assets/images/interior4.jpg',
      ],
    ),
    MyMediaItem(
      category: 'Exterior',
      images: [
        'assets/images/exterior1.jpg',
        'assets/images/exterior2.jpg',
        'assets/images/exterior3.jpg',
      ],
    ),
    MyMediaItem(
      category: 'Product',
      images: [
        'assets/images/product1.jpg',
        'assets/images/product2.jpg',
      ],
    ),
    MyMediaItem(
      category: 'Team',
      images: [
        'assets/images/team1.jpg',
        'assets/images/team2.jpg',
        'assets/images/team3.jpg',
        'assets/images/team4.jpg',
        'assets/images/team5.jpg',

      ],
    ),
    MyMediaItem(
      category: 'Additional',
      images: [
        'assets/images/additional1.jpg',
        'assets/images/additional2.jpg',
        'assets/images/additional3.jpg',
        'assets/images/additional4.jpg',
        'assets/images/additional5.jpg',
        'assets/images/additional6.jpg',
      ],
    ),
  ];

  void showFullScreenImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true, // Close when tapping outside
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
        title: Text('Media', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Calculate Total Media Items
                Text(
                  "Total Images: ${mediaData.fold(0, (sum, item) => sum + item.images.length)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),

                // Toggle Button for Grid/List View
                IconButton(
                  icon: Icon(
                    isGridView ? Icons.list : Icons.grid_view,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () => setState(() => isGridView = !isGridView),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: isGridView ? buildGridView() : buildListView(),
            ),
          ),
        ],
      ),
      floatingActionButton: buildAnimatedSpeedDial(context),
    );
  }

  Widget buildListView() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: mediaData.length,
        itemBuilder: (context, index) {
          final mediaItem = mediaData[index];
          return buildCategoryCard(mediaItem);
        },
      ),
    );
  }
  Widget buildCategoryCard(MyMediaItem mediaItem) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      mediaItem.category,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8), // Spacing between text and icon
                    IconButton(
                      icon: Icon(Icons.add_circle_outlined, color: Colors.black45),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddMediaScreen(selectedCategory: mediaItem.category),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (mediaItem.images.length > 3)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAllScreen(mediaItem: mediaItem),
                        ),
                      );
                    },
                    child: Text('View More', style: TextStyle(color: Colors.blueAccent)),
                  ),
              ],
            ),

            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                children: [
                  for (int i = 0; i < (mediaItem.images.length > 3 ? 3 : mediaItem.images.length); i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          showFullScreenImage(context, mediaItem.images[i]); // Show full-screen image
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            mediaItem.images[i],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8, // Adjust aspect ratio for a better layout
        ),
        itemCount: mediaData.length,
        itemBuilder: (context, index) {
          final mediaItem = mediaData[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewAllScreen(mediaItem: mediaItem)),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category title with a "View More" button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mediaItem.category,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 8),

                    // Image Grid
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: mediaItem.images.length > 4 ? 4 : mediaItem.images.length,
                        itemBuilder: (context, imgIndex) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12), // Rounded corners
                            child: Image.asset(
                              mediaItem.images[imgIndex],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SpeedDial buildAnimatedSpeedDial(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Colors.blueAccent,
      overlayColor: Colors.black.withOpacity(0.5), // Background blur effect
      spacing: 12, // Space between buttons
      elevation: 8, // Shadow effect
      spaceBetweenChildren: 10, // Spacing between children
      closeManually: false, // Auto-close after tapping
      animationDuration: Duration(milliseconds: 300), // Smooth animation speed
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: Colors.green,
          label: 'Selfie Checkout',
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          labelBackgroundColor: Colors.black.withOpacity(0.8), // Dark label bg
          onTap: () {
            print('Selfie Checkout clicked');
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.image, color: Colors.white),
          backgroundColor: Colors.blue,
          label: 'Add Media',
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          labelBackgroundColor: Colors.black.withOpacity(0.8),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMediaScreen()));
          },
        ),
      ],
    );
  }
}

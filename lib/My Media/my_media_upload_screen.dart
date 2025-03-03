import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaScreen extends StatefulWidget {
  final String? selectedCategory;

  AddMediaScreen({this.selectedCategory});

  @override
  _AddMediaScreenState createState() => _AddMediaScreenState();
}

class _AddMediaScreenState extends State<AddMediaScreen> {
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Media", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Select Media Type
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 4, // Slightly increased for better depth
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Media Type",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16), // Ensures consistent padding
                        child: GridView.count(
                          shrinkWrap: true, // Prevents unnecessary scrolling inside a Column
                          crossAxisCount: 2, // Ensures 2 buttons per row
                          mainAxisSpacing: 12, // Space between rows
                          crossAxisSpacing: 16, // Space between columns
                          childAspectRatio: 3, // Adjust this ratio for better width-height balance
                          children: [
                            _mediaButton("Interior", Icons.chair),
                            _mediaButton("Exterior", Icons.apartment),
                            _mediaButton("Product", Icons.shopping_bag),
                            _mediaButton("Team", Icons.group),
                            _mediaButton("Additional", Icons.add),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Upload media section
            const Text(
              "📤 Upload Media",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Upload media section
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.zero,
              child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.blue[100]!, Colors.grey[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: _pickImage,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue[900]!.withOpacity(0.5),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(Icons.camera_alt, size: 35, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Capture Image",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[900],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
            ),

            SizedBox(height: 10),
            // Show captured images with border and delete option
            _images.isNotEmpty
                ? SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Open full-screen image when tapped
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.black,
                                  insetPadding: EdgeInsets.all(0),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.file(
                                          File(_images[index].path),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top: 40,
                                        left: 20,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.close, color: Colors.white, size: 28),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueAccent, // Border color
                                width: 2, // Border thickness
                              ),
                              borderRadius: BorderRadius.circular(12), // Rounded corners
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_images[index].path),
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Cross button to remove image
                        Positioned(
                          top: 5,
                          left: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ) : SizedBox(),


            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text("Publish", style: TextStyle(fontSize: 16, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mediaButton(String title, IconData icon) {
    bool isSelected = _selectedCategory == title;
    bool isAnySelected = _selectedCategory != null;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 140, // Fixed width
      height: 40, // Fixed height
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blueAccent
            : (isAnySelected ? Colors.blue.shade50 : Colors.white), // Light blue when any button is selected
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          )
        ]
            : [],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _selectedCategory = title;
          });
        },
        icon: Icon(icon, size: 22, color: isSelected ? Colors.white : Colors.blueAccent),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          fixedSize: Size(140, 60),
        ),
      ),
    );
  }



}

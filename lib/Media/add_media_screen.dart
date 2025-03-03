import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'media_view_model.dart';

class AddMediaScreen extends StatefulWidget {
  final String? selectedLocation;
  final String? profilePhoto;

  const AddMediaScreen({super.key, this.selectedLocation, this.profilePhoto});

  @override
  State<AddMediaScreen> createState() => _AddMediaScreenState();
}

class _AddMediaScreenState extends State<AddMediaScreen> {
  String? formattedDate;
  String? formattedTime;
  Timer? timer;
  final MediaViewModel mediaViewModel = MediaViewModel();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTime());
    updateTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateTime() {
    final now = DateTime.now();
    setState(() {
      formattedDate = DateFormat('EEE, dd MMM yyyy').format(now);
      formattedTime = DateFormat('HH:mm:ss').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 20,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              if (widget.selectedLocation != null && widget.selectedLocation!.isNotEmpty) _buildLocation(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard("Select Media Type", _buildMediaTypeSelection()),
            const SizedBox(height: 12),
            _buildCard("Upload Media", _buildUploadMediaSection()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "back_button",
        onPressed: () => Navigator.pop(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 25),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.perm_media, color: Colors.white, size: 20),
        SizedBox(width: 4),
        Text("Media", style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: Colors.white, size: 23),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            widget.selectedLocation!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            Divider(color: Colors.grey.shade400, height: 20, thickness: 1),
            const SizedBox(height: 4.0),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildMediaTypeSelection() {
    return Wrap(
      spacing: 8.0,
      children: mediaViewModel.mediaCategories.map((type) {
        return ChoiceChip(
          label: Text(type),
          selected: mediaViewModel.selectedMediaTypes.contains(type),
          onSelected: (selected) => setState(() => mediaViewModel.toggleMediaType(type)),
        );
      }).toList(),
    );
  }

  Widget _buildUploadMediaSection() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => mediaViewModel.pickMedia(),
          child: const Text("Select Media"),
        ),
        ElevatedButton(
          onPressed: () => mediaViewModel.publishMedia(context),
          child: const Text("Publish"),
        ),
      ],
    );
  }
}

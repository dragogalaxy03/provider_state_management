import 'package:flutter/material.dart';
import 'media_detail_screen.dart';

class MediaCategoryRoundedTabBar extends StatefulWidget {
  final String imgBaseUrl;
  final Map<String, List<String>> mediaImages;

  const MediaCategoryRoundedTabBar({
    Key? key,
    required this.imgBaseUrl,
    required this.mediaImages,
  }) : super(key: key);

  @override
  State<MediaCategoryRoundedTabBar> createState() => _MediaCategoryRoundedTabBarState();
}

class _MediaCategoryRoundedTabBarState extends State<MediaCategoryRoundedTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Interior', 'Exterior', 'Product', 'Team', 'Additional'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((category) => MediaDetailsScreen(
              imgBaseUrl: widget.imgBaseUrl,
              mediaCategory: category,
              imageUrls: widget.mediaImages[category] ?? [],
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blue,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}

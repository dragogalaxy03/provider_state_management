// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
// // import 'package:loqal_timetracker/helper/shared_pref.dart';
// // import 'package:loqal_timetracker/ui/colors/app_color.dart';
// // import 'package:loqal_timetracker/ui/screens/media/add_media_screen.dart';
// // import 'package:loqal_timetracker/ui/screens/media/media_category_rounded_tab.dart';
// // import 'package:loqal_timetracker/ui/screens/media/media_view_model.dart';
// // import 'package:loqal_timetracker/wrapper/provider_wrapper.dart';
// //
// // class MediaScreen extends StatefulWidget {
// //   final String? selectedLocation;
// //   final String? profilePhoto;
// //
// //   const MediaScreen({super.key, this.selectedLocation, this.profilePhoto});
// //
// //   @override
// //   State<MediaScreen> createState() => _MediaScreenState();
// // }
// //
// // class _MediaScreenState extends State<MediaScreen> with SingleTickerProviderStateMixin {
// //   final String imgBaseUrl = "https://images.pexels.com/photos/";
// //
// //   final Map<String, List<String>> mediaImages = {
// //     "Interior": [
// //       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
// //       "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
// //     ],
// //     "Exterior": [
// //       "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=600",
// //       "https://images.pexels.com/photos/534124/pexels-photo-534124.jpeg?auto=compress&cs=tinysrgb&w=600",
// //     ],
// //     "Product": [
// //       "https://images.pexels.com/photos/7376795/pexels-photo-7376795.jpeg?auto=compress&cs=tinysrgb&w=600",
// //       "https://images.pexels.com/photos/3910071/pexels-photo-3910071.jpeg?auto=compress&cs=tinysrgb&w=600",
// //     ],
// //     "Team": [
// //       "https://images.pexels.com/photos/3184418/pexels-photo-3184418.jpeg?auto=compress&cs=tinysrgb&w=600",
// //       "https://images.pexels.com/photos/1595385/pexels-photo-1595385.jpeg?auto=compress&cs=tinysrgb&w=600",
// //     ],
// //     "Additional": [
// //       "https://images.pexels.com/photos/8923967/pexels-photo-8923967.jpeg?auto=compress&cs=tinysrgb&w=600",
// //       "https://images.pexels.com/photos/4386323/pexels-photo-4386323.jpeg?auto=compress&cs=tinysrgb&w=600",
// //     ],
// //   };
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ProviderWrapper<MediaViewModel>(
// //       create: (context) => MediaViewModel(getContext: () => context),
// //       builder: (context, viewModel, _) {
// //         return Scaffold(
// //           backgroundColor: AppColors.greyBackgrond,
// //           appBar: AppBar(
// //             automaticallyImplyLeading: false,
// //             backgroundColor: AppColors.mainappColor,
// //             toolbarHeight: kToolbarHeight+20,
// //             flexibleSpace: Padding(
// //               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 10, right: 10),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       const Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.perm_media, color: Colors.white, size: 20),
// //                           SizedBox(width: 4),
// //                           Text(
// //                             "Media",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 16,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 4),
// //                       if (widget.selectedLocation != null && widget.selectedLocation!.isNotEmpty)
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           mainAxisSize: MainAxisSize.min, // Ensures the Row takes only necessary space
// //                           children: [
// //                             const Icon(Icons.location_on, color: Colors.white, size: 23),
// //                             const SizedBox(width: 5), // Adds slight spacing between icon and text
// //                             Flexible( // Prevents overflow by wrapping text within available space
// //                               child: Text(
// //                                 widget.selectedLocation!,
// //                                 maxLines: 2,
// //                                 overflow: TextOverflow.ellipsis,
// //                                 textAlign: TextAlign.center,
// //                                 style: const TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 12,
// //                                   fontWeight: FontWeight.w600,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         )
// //                       else
// //                         Container(),
// //                     ],
// //                   ),
// //
// //                 ],
// //               ),
// //             ),
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
// //             child: MediaCategoryRoundedTabBar(
// //               imgBaseUrl: imgBaseUrl,
// //               mediaImages: mediaImages,
// //             ),
// //           ),
// //           floatingActionButtonLocation: ExpandableFab.location,
// //           floatingActionButton: Theme(
// //             data: Theme.of(context).copyWith(
// //               floatingActionButtonTheme:  FloatingActionButtonThemeData(
// //                 backgroundColor: AppColors.mainappColor,
// //                 foregroundColor: Colors.white
// //               ),
// //             ),
// //             child: ExpandableFab(
// //               childrenAnimation: ExpandableFabAnimation.none,
// //               type: ExpandableFabType.up,
// //               distance: 65,
// //               children: [
// //                 Row(
// //                   children: [
// //                     const Text('Add Media'),
// //                     const SizedBox(width: 10),
// //                     FloatingActionButton.small(
// //                       heroTag: 'media_fab',
// //                       onPressed: () {
// //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddMediaScreen(selectedLocation: widget.selectedLocation)));
// //                       },
// //                       backgroundColor: Colors.blue, // Background color for button
// //                       child: const Icon(Icons.image, color: Colors.white),
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   children: [
// //                     const Text('Selfie Checkout'),
// //                     const SizedBox(width: 10),
// //                     FloatingActionButton.small(
// //                       heroTag: 'selfie_fab',
// //                       onPressed: () {},
// //                       backgroundColor: Colors.green, // Background color for button
// //                       child: const Icon(Icons.camera, color: Colors.white),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
//
// import 'dart:async';
// // import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
// // import 'package:loqal_timetracker/components/custom_appbar.dart';
// // import 'package:loqal_timetracker/helper/shared_pref.dart';
// // import 'package:loqal_timetracker/ui/colors/app_color.dart';
// // import 'package:loqal_timetracker/ui/screens/media/add_media_screen.dart';
// // import 'package:loqal_timetracker/ui/screens/media/media_category_rounded_tab.dart';
// // import 'package:loqal_timetracker/ui/screens/media/media_view_model.dart';
// // import 'package:loqal_timetracker/wrapper/provider_wrapper.dart';
//
// class MediaScreen extends StatefulWidget {
//   final String? selectedLocation;
//   final String? profilePhoto;
//
//   const MediaScreen({super.key, this.selectedLocation, this.profilePhoto});
//
//   @override
//   State<MediaScreen> createState() => _MediaScreenState();
// }
//
// class _MediaScreenState extends State<MediaScreen> {
//   final Map<String, List<String>> mediaImages = {
//     "Interior": [
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       // "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//     ],
//     "Exterior": [
//       "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/534124/pexels-photo-534124.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       // "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//     ],
//     "Product": [
//       "https://images.pexels.com/photos/7376795/pexels-photo-7376795.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/3910071/pexels-photo-3910071.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       // "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//     ],
//     "Team": [
//       "https://images.pexels.com/photos/3184418/pexels-photo-3184418.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1595385/pexels-photo-1595385.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       // "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//     ],
//     "Additional": [
//       "https://images.pexels.com/photos/8923967/pexels-photo-8923967.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/4386323/pexels-photo-4386323.jpeg?auto=compress&cs=tinysrgb&w=600",
//       "https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg?auto=compress&cs=tinysrgb&w=600",
//       // "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?auto=compress&cs=tinysrgb&w=600",
//     ],
//   };
//
//   bool hasLessThanThreeImages() {
//     return mediaImages.values.any((images) => images.length < 4);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return ProviderWrapper<MediaViewModel>(
//     //   create: (context) => MediaViewModel(getContext: () => context),
//     //   builder: (context, viewModel, _) {
//         return Scaffold(
//           // backgroundColor: AppColors.greyBackgrond,
//           // appBar: CustomAppBar(
//           //   title: "Media",
//           //   location: widget.selectedLocation,
//           //   leading: const Icon(Icons.perm_media,color: Colors.white,size: 20,),
//           //   backgroundColor: AppColors.mainappColor,
//           // ),
//           body:
//           // hasLessThanThreeImages() ? _buildImageListView() : _buildTabView(),
//           // // floatingActionButtonLocation: ExpandableFab.location,
//           // floatingActionButton: Theme(
//           //   data: Theme.of(context).copyWith(
//           //     floatingActionButtonTheme:  FloatingActionButtonThemeData(
//           //         // backgroundColor: AppColors.mainappColor,
//           //         foregroundColor: Colors.white
//           //     ),
//           //   ),
//             // child: ExpandableFab(
//             //   childrenAnimation: ExpandableFabAnimation.none,
//             //   type: ExpandableFabType.up,
//             //   distance: 65,
//             //   children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Text(
//                         'Add Media',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     // FloatingActionButton.small(
//                     //   heroTag: 'media_fab',
//                     //   onPressed: () {
//                     //     Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddMediaScreen(selectedLocation: widget.selectedLocation)));
//                     //   },
//                     //   backgroundColor: Colors.blue, // Background color for button
//                     //   child: const Icon(Icons.image, color: Colors.white),
//                     // ),
//                     OpenContainer(
//                       transitionType: ContainerTransitionType.fadeThrough,
//                       closedElevation: 6,
//                       closedShape: const CircleBorder(),
//                       closedColor: Colors.blue,
//                       transitionDuration: const Duration(milliseconds: 700),
//                       closedBuilder: (context, openContainer) => FloatingActionButton.small(
//                         heroTag: 'media_fab',
//                         onPressed: openContainer, // Open the AddMediaScreen with animation
//                         backgroundColor: Colors.blue,
//                         child: const Icon(Icons.image, color: Colors.white),
//                       ),
//                       openBuilder: (context, closeContainer) => AddMediaScreen(selectedLocation: widget.selectedLocation),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: const Text(
//                         'Selfie Checkout',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     FloatingActionButton.small(
//                       heroTag: 'selfie_fab',
//                       onPressed: () {},
//                       backgroundColor: Colors.green, // Background color for button
//                       child: const Icon(Icons.camera, color: Colors.white),
//                     ),
//                   ],
//                 ),
//             ),
//           );
//   }
//
//   // Widget _buildImageListView() {
//   //   return ListView(
//   //     padding: const EdgeInsets.all(10),
//   //     children: [
//   //     // mediaImages.entries.where((entry) => entry.value.length < 4).map((entry) {
//   //     //    return
//   //          Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Padding(
//   //             padding: const EdgeInsets.symmetric(vertical: 8.0),
//   //             child: Text(entry.key, style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.mainappColor)),
//   //           ),
//   //           SizedBox(
//   //             height: 120,
//   //             child: ListView.builder(
//   //               scrollDirection: Axis.horizontal,
//   //               itemCount: entry.value.length,
//   //               itemBuilder: (context, index) {
//   //                 return Padding(
//   //                   padding: const EdgeInsets.only(right: 8.0),
//   //                   child: ClipRRect(
//   //                     borderRadius: BorderRadius.circular(10),
//   //                     child: Image.network(entry.value[index], width: 120, height: 120, fit: BoxFit.cover),
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //           )
//   //         ],
//   //       ),
//   //   ]
//   //     // }).toList(),
//   //   );
//   // }
//   //
//   // Widget _buildTabView() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//   //     child: MediaCategoryRoundedTabBar(
//   //       imgBaseUrl: "https://images.pexels.com/photos/",
//   //       mediaImages: mediaImages,
//   //     ),
//   //   );
//   // }
// }

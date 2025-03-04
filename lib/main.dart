import 'package:flutter/material.dart';
import 'package:newday/AddressForm/business-form.dart';
import 'package:newday/Media/add_media_screen.dart';
import 'package:newday/My%20Media/my_media_screen.dart';
import 'package:newday/Screens/Crypto/crypto-list-screen.dart';
import 'package:newday/Screens/Offer/offer-screen.dart';
import 'package:newday/Screens/attachment.dart';
import 'package:provider/provider.dart';

import 'Provider/crypto-provider.dart';
import 'Provider/taks_provider.dart';
import 'Screens/task_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => CryptoProvider()..fetchCryptoData(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Automatically switch theme
      home: MyMediaScreen(),
    );
  }
}

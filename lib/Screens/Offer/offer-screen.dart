import 'package:flutter/material.dart';
import 'offer-json.dart';
import 'offer-model.dart';
import 'offers.dart';

class OfferScreen extends StatelessWidget {
  OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Exclusive Offers"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Offer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Offers List
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OfferCard(offer: offers[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

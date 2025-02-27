import 'offer-model.dart';

List<Map<String, dynamic>> offersJson = [
  {
    "title": "Super Sale!",
    "description": "Get 50% off on all items. Limited time offer!",
    "discount": "50% OFF",
    "validity": "March 31, 2025",
    "gifPath": "assets/gif/sales.gif",
  },
  {
    "title": "Special Offer",
    "description": "Buy 3 Get 2 Free",
    "discount": "30% OFF",
    "validity": "March 3, 2025",
    "gifPath": "assets/gif/offer.gif",

  },
  {
    "title": "Buy 1 Get 1 Free",
    "description": "Exclusive offer on selected brands.",
    "discount": "BOGO",
    "validity": "April 15, 2025",
    "gifPath": "assets/gif/best-offer.gif",
  },
  // {
  //   "title": "New User Offer",
  //   "description": "Get Rs.100 off on your first order!",
  //   "discount": "Rs.100 OFF",
  //   "validity": "June 30, 2025"
  // },
  // {
  //   "title": "Flash Deal",
  //   "description": "Limited-time discount on fashion and apparel.",
  //   "discount": "Up to 70% OFF",
  //   "validity": "February 28, 2025"
  // }
];

List<Offer> offers = offersJson.map((json) => Offer.fromJson(json)).toList();
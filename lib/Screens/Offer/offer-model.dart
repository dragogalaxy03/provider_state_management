class Offer {
  final String title;
  final String description;
  final String discount;
  final String validity;
  final String gifPath;

  Offer({
    required this.title,
    required this.description,
    required this.discount,
    required this.validity,
    required this.gifPath,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      title: json['title'],
      description: json['description'],
      discount: json['discount'],
      validity: json['validity'],
      gifPath: json['gifPath'],
    );
  }
}

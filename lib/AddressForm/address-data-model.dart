import 'dart:convert';

class BusinessModel {
  //legal details
  late final String legalName;
  late final String locationName;
  late final String businessStructure;
  late final String registryNumber;
  late final String gst;
  late final String pan;
  //brand details
  late final String companyName;
  late final String brandCode;
  late final String brandName;
  //bank accounts
  late final String accountNumber;
  late final String accountName;
  late final String ifsc;
  late final String bankName;
  //personal
  late final String personName;
  late final String personPhone;
  late final String personEmail;
  //Address
  late final String address;
  late final String postalCode;
  late final String country;
  late final String administrativeArea;
  late final String latitude;
  late final String longitude;
  //files
  late final String documentName;
  late final String tags;
  late final String comment;
  late final String file;
  late final String media;

  BusinessModel({
    required this.legalName,
    required this.locationName,
    required this.businessStructure,
    required this.registryNumber,
    required this.gst,
    required this.pan,
    required this.companyName,
    required this.brandCode,
    required this.brandName,
    required this.accountNumber,
    required this.accountName,
    required this.ifsc,
    required this.bankName,
    required this.personName,
    required this.personPhone,
    required this.personEmail,
    required this.address,
    required this.postalCode,
    required this.country,
    required this.administrativeArea,
    required this.latitude,
    required this.longitude,
    required this.documentName,
    required this.tags,
    required this.comment,
    required this.file,
    required this.media,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      legalName: json['legel_name'] ?? '',
      locationName: json['location_name'] ?? '',
      businessStructure: json['business_structure'] ?? '',
      registryNumber: json['registry_number'] ?? '',
      gst: json['gst'] ?? '',
      pan: json['pan'] ?? '',
      companyName: json['company_name'] ?? '',
      brandCode: json['brand_code'] ?? '',
      brandName: json['brand_name'] ?? '',
      accountNumber: json['account_number'] ?? '',
      accountName: json['account_name'] ?? '',
      ifsc: json['ifsc'] ?? '',
      bankName: json['bank_name'] ?? '',
      personName: json['person_name'] ?? '',
      personPhone: json['person_phone'] ?? '',
      personEmail: json['person_email'] ?? '',
      address: json['address'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      administrativeArea: json['administrative_area'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      documentName: json['document_name'] ?? '',
      tags: json['tags'] ?? '',
      comment: json['comment'] ?? '',
      file: json['file'] ?? '',
      media: json['media'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'legel_name': legalName,
      'location_name': locationName,
      'business_structure': businessStructure,
      'registry_number': registryNumber,
      'gst': gst,
      'pan': pan,
      'company_name': companyName,
      'brand_code': brandCode,
      'brand_name': brandName,
      'account_number': accountNumber,
      'account_name': accountName,
      'ifsc': ifsc,
      'bank_name': bankName,
      'person_name': personName,
      'person_phone': personPhone,
      'person_email': personEmail,
      'address': address,
      'postalCode': postalCode,
      'country': country,
      'administrative_area': administrativeArea,
      'latitude': latitude,
      'longitude': longitude,
      'document_name': documentName,
      'tags': tags,
      'comment': comment,
      'file': file,
      'media': media,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

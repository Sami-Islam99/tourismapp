import '../models/attraction_model.dart';

class HotelModel extends AttractionModel {
  final String phone;
  final String link;
  final int stars;

  HotelModel({
    required String id,
    required String name,
    required String city,
    required String address,
    required List<String> images,
    required this.phone,
    required this.link,
    required this.stars,
  }) : super(
          id: id,
          name: name,
          city: city,
          address: address,
          type: AttractionType.hotel,
          images: images,
        );

  static HotelModel fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json["id"],
      name: json["name"],
      images: json["images"],
      city: json["city"],
      address: json["address"],
      link: json["link"],
      phone: json["phone"],
      stars: json["stars"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "city": city,
      "address": address,
      "link": link,
      "phone": phone,
      "stars": stars,
      "type": type,
    };
  }
}

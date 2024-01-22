/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    HomeModel({
        required this.data,
        required this.baseUrl,
        required this.status,
    });

    List<Datum> data;
    String baseUrl;
    int status;

    factory HomeModel.fromJson(Map<dynamic, dynamic> json) => HomeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        baseUrl: json["base_url"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "base_url": baseUrl,
        "status": status,
    };
}

class Datum {
    Datum({
        required this.subPhotos,
        required this.additionalInfo,
        required this.careInstruction,
        required this.rating,
        required this.photo,
        required this.description,
        required this.id,
        required this.title,
        required this.category,
        this.vender,
        required this.slug,
        required this.status,
    });

    String subPhotos;
    String additionalInfo;
    String careInstruction;
    String rating;
    String photo;
    String description;
    int id;
    String title;
    int category;
    int? vender;
    String slug;
    Status status;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        subPhotos: json["sub_photos"],
        additionalInfo: json["additional_info"],
        careInstruction: json["care_instruction"],
        rating: json["rating"],
        photo: json["photo"],
        description: json["description"],
        id: json["id"],
        title: json["title"],
        category: json["category"],
        vender: json["vender"],
        slug: json["slug"],
        status: statusValues.map[json["status"]]!,
    );

    Map<dynamic, dynamic> toJson() => {
        "sub_photos": subPhotos,
        "additional_info": additionalInfo,
        "care_instruction": careInstruction,
        "rating": rating,
        "photo": photo,
        "description": description,
        "id": id,
        "title": title,
        "category": category,
        "vender": vender,
        "slug": slug,
        "status": statusValues.reverse[status],
    };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

DataImage dataImageFromJson(String str) => DataImage.fromJson(json.decode(str));

String dataImageToJson(DataImage data) => json.encode(data.toJson());

class DataImage {
    DataImage({
        required this.offset,
        required this.totalPhotos,
        required this.success,
        required this.limit,
        required this.message,
        required this.photos,
    });

    int offset;
    int totalPhotos;
    bool success;
    int limit;
    String message;
    List<Photo> photos;

    factory DataImage.fromJson(Map<dynamic, dynamic> json) => DataImage(
        offset: json["offset"],
        totalPhotos: json["total_photos"],
        success: json["success"],
        limit: json["limit"],
        message: json["message"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "offset": offset,
        "total_photos": totalPhotos,
        "success": success,
        "limit": limit,
        "message": message,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    Photo({
        required this.description,
        required this.id,
        required this.title,
        required this.user,
        required this.url,
    });

    String description;
    int id;
    String title;
    int user;
    String url;

    factory Photo.fromJson(Map<dynamic, dynamic> json) => Photo(
        description: json["description"],
        id: json["id"],
        title: json["title"],
        user: json["user"],
        url: json["url"],
    );

    Map<dynamic, dynamic> toJson() => {
        "description": description,
        "id": id,
        "title": title,
        "user": user,
        "url": url,
    };
}

// To parse this JSON data, do
//
//     final fakeApiModel = fakeApiModelFromJson(jsonString);

import 'dart:convert';

FakeApiModel fakeApiModelFromJson(String str) => FakeApiModel.fromJson(json.decode(str));

String fakeApiModelToJson(FakeApiModel data) => json.encode(data.toJson());

class FakeApiModel {
    String status;
    List<News> news;

    FakeApiModel({
        required this.status,
        required this.news,
    });

    factory FakeApiModel.fromJson(Map<String, dynamic> json) => FakeApiModel(
        status: json["status"],
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
    };
}

class News {
    String id;
    String title;
    String description;
    String url;
    String author;
    String image;
    String language;
    List<String> category;
    String published;

    News({
        required this.id,
        required this.title,
        required this.description,
        required this.url,
        required this.author,
        required this.image,
        required this.language,
        required this.category,
        required this.published,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        author: json["author"],
        image: json["image"],
        language: json["language"],
        category: List<String>.from(json["category"].map((x) => x)),
        published: json["published"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "author": author,
        "image": image,
        "language": language,
        "category": List<dynamic>.from(category.map((x) => x)),
        "published": published,
    };
}

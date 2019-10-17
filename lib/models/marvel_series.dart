class MarvelSeries {
  MarvelSeries({this.id, this.title, this.thumbnail});

  factory MarvelSeries.fromJson(Map<String, dynamic> json) {
    return MarvelSeries(
      id: int.parse(json["id"].toString()),
      title: json["title"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
    );
  }

  int id;
  String title;
  String thumbnail;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
    };
  }

  @override
  String toString() {
    return "id:$id title:$title thumbnail:$thumbnail";
  }
}
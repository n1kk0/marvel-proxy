class MarvelCharacterEvent {
  MarvelCharacterEvent({this.id, this.title, this.thumbnail, this.description, this.detailUri});

  factory MarvelCharacterEvent.fromJson(Map<String, dynamic> json) {
    final detailUri = json["urls"].firstWhere((url) => url["type"].toString() == "detail", orElse: () => null);

    return MarvelCharacterEvent(
      id: int.parse(json["id"].toString()),
      title: json["title"].toString(),
      thumbnail: json["thumbnail"] != null ? "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}" : null,
      description: json["description"].toString(),
      detailUri: detailUri != null ? detailUri["url"].toString() : null,
    );
  }

  int id;
  String title;
  String thumbnail;
  String description;
  String detailUri;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "description": description,
      "detailUri": detailUri,
    };
  }

  @override
  String toString() {
    return "id:$id title:$title thumbnail:$thumbnail description:$description detailUri:$detailUri";
  }
}
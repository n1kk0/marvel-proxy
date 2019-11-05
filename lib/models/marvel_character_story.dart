class MarvelCharacterStory {
  MarvelCharacterStory({this.id, this.title, this.thumbnail, this.description});

  factory MarvelCharacterStory.fromJson(Map<String, dynamic> json) {
    return MarvelCharacterStory(
      id: int.parse(json["id"].toString()),
      title: json["title"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
      description: json["description"].toString(),
    );
  }

  int id;
  String title;
  String thumbnail;
  String description;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "description": description,
    };
  }

  @override
  String toString() {
    return "id:$id title:$title thumbnail:$thumbnail description:$description";
  }
}
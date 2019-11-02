class MarvelCharacter {
  MarvelCharacter({this.name, this.thumbnail, this.resourceUri});

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    return MarvelCharacter(
      name: json["name"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
      resourceUri: ((json["urls"] as List).firstWhere((url) => url["type"].toString() == "wiki") as Map)["url"].toString(),
    );
  }

  String name;
  String thumbnail;
  String resourceUri;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "thumbnail": thumbnail,
      "resourceUri": resourceUri
    };
  }

  @override
  String toString() {
    return "name:$name thumbnail:$thumbnail resourceUri:$resourceUri";
  }
}

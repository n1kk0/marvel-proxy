class MarvelCharacter {
  MarvelCharacter({this.name, this.thumbnail, this.resourceUri});

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    final wikiUrl = json["urls"].firstWhere((url) => url["type"].toString() == "wiki", orElse: () => null);

    return MarvelCharacter(
      name: json["name"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
      resourceUri: wikiUrl != null ? wikiUrl["url"].toString() : null,
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

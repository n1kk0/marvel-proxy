class MarvelCharacter {
  MarvelCharacter({this.name, this.thumbnail, this.resourceUri, this.detailUri, this.wikiUri, this.comicsUri, this.description});

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    final wikiUri = json["urls"].firstWhere((url) => url["type"].toString() == "wiki", orElse: () => null);
    final detailUri = json["urls"].firstWhere((url) => url["type"].toString() == "detail", orElse: () => null);
    final comicsUri = json["urls"].firstWhere((url) => url["type"].toString() == "comiclink", orElse: () => null);

    return MarvelCharacter(
      name: json["name"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
      resourceUri: wikiUri != null ? wikiUri["url"].toString() : null,
      detailUri: detailUri != null ? detailUri["url"].toString() : null,
      wikiUri: wikiUri != null ? wikiUri["url"].toString() : null,
      comicsUri: comicsUri != null ? comicsUri["url"].toString() : null,
      description: json["description"].toString(),
    );
  }

  String name;
  String thumbnail;
  String resourceUri;
  String detailUri;
  String wikiUri;
  String comicsUri;
  String description;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "thumbnail": thumbnail,
      "resourceUri": resourceUri,
      "detailUri": detailUri,
      "wikiUri": wikiUri,
      "comicsUri": comicsUri,
      "description": description,
    };
  }

  @override
  String toString() {
    return "name:$name thumbnail:$thumbnail detailUri:$detailUri wikiUri:$wikiUri comicsUri:$comicsUri description:$description";
  }
}

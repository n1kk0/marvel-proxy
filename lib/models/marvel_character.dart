class MarvelCharacter {
  MarvelCharacter({this.name, this.thumbnail});

  factory MarvelCharacter.fromJson(Map<String, dynamic> json) {
    return MarvelCharacter(
      name: json["name"].toString(),
      thumbnail: "${json["thumbnail"]["path"]}.${json["thumbnail"]["extension"]}",
    );
  }

  String name;
  String thumbnail;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "thumbnail": thumbnail,
    };
  }

  @override
  String toString() {
    return "name:$name thumbnail:$thumbnail";
  }
}

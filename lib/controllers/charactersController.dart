import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersController extends ResourceController {
  @Operation.get()
  Future<Response> getCharacters(@Bind.query('p') int page, {@Bind.query('csfi') int comicSeriesFilterId}) async {
    int count;

    final characters = await ApiService().getMarvelCharacters(page, comicSeriesFilterId, (int i) {
      count = i;
    });

    return Response.ok({
      "count": count,
      "characters": characters,
    });
  }
}

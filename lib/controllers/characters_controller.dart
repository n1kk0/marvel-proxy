import 'package:dcache/dcache.dart';
import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersController extends ResourceController {
  CharactersController(this._cache, this._messageHub);

  final Cache<String, String> _cache;
  final ApplicationMessageHub _messageHub;

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("p") int page, {@Bind.query("csfi") int comicSeriesFilterId}) async {
    int count;

    final characters = await ApiService(_cache, _messageHub).getMarvelCharacters(page, comicSeriesFilterId, (int i) {
      count = i;
    });

    return Response.ok({
      "count": count,
      "characters": characters,
    });
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel characters.")};
  }
}

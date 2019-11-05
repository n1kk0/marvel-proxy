import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersComicsController extends ResourceController {
  CharactersComicsController(this.cacheService);

  final CacheService cacheService;

  @Operation.get("id")
  Future<Response> getComics(@Bind.path("id") int id) async {
    return Response.ok(await ApiService(cacheService).getMarvelCharactersComics(id));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel Comics for a given character.")};
  }
}

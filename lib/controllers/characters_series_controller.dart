import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersSeriesController extends ResourceController {
  CharactersSeriesController(this.cacheService);

  final CacheService cacheService;

  @Operation.get("id")
  Future<Response> getSeries(@Bind.path("id") int id) async {
    return Response.ok(await ApiService(cacheService).getMarvelCharactersSeries(id));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel Series for a given character.")};
  }
}

import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersComicsController extends ResourceController {
  CharactersComicsController(this.apiService);

  final ApiService apiService;

  @Operation.get("id")
  Future<Response> getComics(@Bind.path("id") int id) async {
    return Response.ok(await apiService.getMarvelCharactersComics(id));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel Comics for a given character.")};
  }
}

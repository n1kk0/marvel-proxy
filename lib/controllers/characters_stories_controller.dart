import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersStoriesController extends ResourceController {
  CharactersStoriesController(this.apiService);

  final ApiService apiService;

  @Operation.get("id")
  Future<Response> getStories(@Bind.path("id") int id) async {
    return Response.ok(await apiService.getMarvelCharactersStories(id));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel Stories for a given character.")};
  }
}

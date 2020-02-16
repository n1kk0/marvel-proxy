import 'package:marvel_proxy/marvel_proxy.dart';

class CharactersEventsController extends ResourceController {
  CharactersEventsController(this.apiService);

  final ApiService apiService;

  @Operation.get("id")
  Future<Response> getEvents(@Bind.path("id") int id) async {
    return Response.ok(await apiService.getMarvelCharactersEvents(id));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel Events for a given character.")};
  }
}

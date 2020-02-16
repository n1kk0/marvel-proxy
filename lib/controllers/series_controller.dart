import 'package:marvel_proxy/marvel_proxy.dart';

class SeriesController extends ResourceController {
  SeriesController(this.apiService);

  final ApiService apiService;

  @Operation.get()
  Future<Response> getSeries(@Bind.query("tsw") String titleStartsWith) async {
    return Response.ok(await apiService.getMarvelSeries(titleStartsWith));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel comic series where title begins by `tsw`.")};
  }
}

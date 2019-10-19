import 'package:dcache/dcache.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class SeriesController extends ResourceController {
  SeriesController(this._cache);

  final Cache<String, http.Response> _cache;

  @Operation.get()
  Future<Response> getSeries(@Bind.query("tsw") String titleStartsWith) async {
    return Response.ok(await ApiService(_cache).getMarvelSeries(titleStartsWith));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel comic series where title begins by `tsw`.")};
  }
}

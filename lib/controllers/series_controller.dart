import 'package:dcache/dcache.dart';
import 'package:marvel_proxy/marvel_proxy.dart';

class SeriesController extends ResourceController {
  SeriesController(this._cache, this._messageHub);

  final Cache<String, String> _cache;
  final ApplicationMessageHub _messageHub;

  @Operation.get()
  Future<Response> getSeries(@Bind.query("tsw") String titleStartsWith) async {
    return Response.ok(await ApiService(_cache, _messageHub).getMarvelSeries(titleStartsWith));
  }

  @override
  Map<String, APIResponse> documentOperationResponses(APIDocumentContext context, Operation operation) {
    return {"200": APIResponse("A list of Marvel comic series where title begins by `tsw`.")};
  }
}

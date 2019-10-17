import 'package:dcache/dcache.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class SeriesController extends ResourceController {
  SeriesController(this._cache);

  final Cache<String, http.Response> _cache;

  @Operation.get()
  Future<Response> getCharacters(@Bind.query('tsw') String titleStartsWith) async {
    return Response.ok(await ApiService(_cache).getMarvelSeries(titleStartsWith));
  }
}

import 'package:marvel_proxy/marvel_proxy.dart';

class SeriesController extends ResourceController {
  @Operation.get()
  Future<Response> getCharacters(@Bind.query('tsw') String titleStartsWith) async {
    return Response.ok(await ApiService().getMarvelSeries(titleStartsWith));
  }
}

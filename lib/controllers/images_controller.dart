import 'package:dcache/dcache.dart';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class ImagesController extends ResourceController {
  ImagesController(this._cache);

  final Cache<String, http.Response> _cache;

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("uri") String uri) async {
    http.Response response;

    if (_cache.containsKey(uri)) {
      response = _cache.get(uri);
    } else {
      response = await http.Client().get(Uri.parse(uri));
      _cache.set("uri", response);
    }

    final File image = MemoryFileSystem().file('tmp')..writeAsBytesSync(response.bodyBytes);

    if (image == null) {
      return Response.notFound();
    }

    return Response.ok(image.openRead())
      ..encodeBody = false
      ..contentType = ContentType("application", "octet-stream");
  }
}

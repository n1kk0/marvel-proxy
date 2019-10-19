import 'package:dcache/dcache.dart';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class ImagesController extends ResourceController {
  ImagesController(this._cache, this._messageHub);

  final Cache<String, List<int>> _cache;
  final ApplicationMessageHub _messageHub;

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("uri") String uri) async {
    List<int> bodyBytes;

    if (_cache.containsKey(uri)) {
      bodyBytes = _cache.get(uri);
    } else {
      final http.Response response = await http.Client().get(Uri.parse(uri));
      bodyBytes = response.bodyBytes;
      _cache.set("uri", bodyBytes);
      _messageHub.add({"type": "images", "url": uri, "response": bodyBytes});
    }

    final File image = MemoryFileSystem().file('tmp')..writeAsBytesSync(bodyBytes);

    if (image == null) {
      return Response.notFound();
    }

    return Response.ok(image.openRead())
      ..encodeBody = false
      ..contentType = ContentType("application", "octet-stream");
  }
}

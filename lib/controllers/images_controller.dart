import 'package:dcache/dcache.dart';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class ImagesController extends ResourceController {
  ImagesController(this._cache, this._messageHub);

  final Cache<String, List<int>> _cache;
  final ApplicationMessageHub _messageHub;
  final List<String> _notAvailables = [
    "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
    "http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708.gif",
  ];

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("uri") String uri) async {
    List<int> bodyBytes;

    final String finalUri = _notAvailables.where((notAvailableUri) => notAvailableUri == uri).isNotEmpty ? "http://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn-600x600.jpg" : uri;

    if (_cache.containsKey(finalUri)) {
      bodyBytes = _cache.get(finalUri);
    } else {
      final http.Response response = await http.Client().get(Uri.parse(finalUri));
      bodyBytes = response.bodyBytes;
      _cache.set("uri", bodyBytes);
      _messageHub.add({"type": "images", "url": finalUri, "response": bodyBytes});
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

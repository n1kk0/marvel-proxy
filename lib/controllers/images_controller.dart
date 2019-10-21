import 'package:dcache/dcache.dart';
import 'package:file/memory.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_proxy/marvel_proxy.dart';

class ImagesController extends ResourceController {
  ImagesController(this._cache, this._messageHub);

  final Cache<String, List<int>> _cache;
  final ApplicationMessageHub _messageHub;
  final RegExp pattern = RegExp("^http://i.annihil.us/u/prod/marvel/i/mg/[a-f,0-9]{1}/[a-f,0-9]{2}/[a-f,0-9]{13}.(gif|jpg|png)\$");

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("uri") String uri) async {
    List<int> bodyBytes;

    final String finalUri = pattern.hasMatch(uri) ? uri : "http://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn-600x600.jpg";

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

import 'dart:convert';

import 'package:file/memory.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_proxy/marvel_proxy.dart';

class ImagesController extends ResourceController {
  ImagesController(this.cacheService);
  final CacheService cacheService;
  final RegExp pattern = RegExp("^http://i.annihil.us/u/prod/marvel/i/mg/[a-f,0-9]{1}/[a-f,0-9]{2}/[a-f,0-9]{13}.(gif|jpg|png)\$");
  final List<String> whiteList = ["https://images-na.ssl-images-amazon.com/images/S/cmx-images-prod/StoryArc/1542/1542._SX400_QL80_TTD_.jpg"];
  final List<String> blackList = ["http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708.gif"];

  @Operation.get()
  Future<Response> getCharacters(@Bind.query("uri") String uri) async {
    String finalUri;
    List<int> bodyBytes;

    if (blackList.where((rejectedUrl) => rejectedUrl == uri).isNotEmpty) {
      finalUri = "http://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn-600x600.jpg";
    } else if (whiteList.where((acceptedUrl) => acceptedUrl == uri).isNotEmpty) {
      finalUri = uri;
    } else {
      finalUri = pattern.hasMatch(uri) ? uri : "http://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn-600x600.jpg";
    }

    if (await cacheService.exists(finalUri)) {
      bodyBytes = base64.decode(await cacheService.get(finalUri) as String);
    } else {
      final http.Response response = await http.Client().get(Uri.parse(finalUri));
      bodyBytes = response.bodyBytes;
      await cacheService.set(uri, base64.encode(bodyBytes));
    }

    final File image = MemoryFileSystem().file('tmp')..writeAsBytesSync(bodyBytes);

    if (image == null) {
      return Response.notFound();
    }

    return Response.ok(image.openRead())
      ..encodeBody = false
      ..contentType = ContentType("image", finalUri.substring(finalUri.length - 3));
  }
}

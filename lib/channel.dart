import 'package:dcache/dcache.dart';
import 'package:http/http.dart' as http;

import 'marvel_proxy.dart';

class MarvelProxyChannel extends ApplicationChannel {
  Cache<String, http.Response> _charactersCache;
  Cache<String, http.Response> _seriesCache;
  Cache<String, http.Response> _imagesCache;

  @override
  Future prepare() async {
    _charactersCache = SimpleCache<String, http.Response>(storage: SimpleStorage<String, http.Response>(size: 200));
    _seriesCache = SimpleCache<String, http.Response>(storage: SimpleStorage<String, http.Response>(size: 100));
    _imagesCache = SimpleCache<String, http.Response>(storage: SimpleStorage<String, http.Response>(size: 1500));
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/").linkFunction((request) async => Response.ok(await File('client.html').readAsString())..contentType = ContentType.html)
      ..route("/characters").link(() => CharactersController(_charactersCache))
      ..route("/series").link(() => SeriesController(_seriesCache))
      ..route("/images").link(() => ImagesController(_imagesCache))
    ;
  }
}

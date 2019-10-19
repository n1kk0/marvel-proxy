import 'package:dcache/dcache.dart';

import 'marvel_proxy.dart';

class MarvelProxyChannel extends ApplicationChannel {
  Cache<String, String> _charactersCache;
  Cache<String, String> _seriesCache;
  Cache<String, List<int>> _imagesCache;

  @override
  Future prepare() async {
    _charactersCache = SimpleCache<String, String>(storage: SimpleStorage<String, String>(size: 200));
    _seriesCache = SimpleCache<String, String>(storage: SimpleStorage<String, String>(size: 100));
    _imagesCache = SimpleCache<String, List<int>>(storage: SimpleStorage<String, List<int>>(size: 1500));
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    messageHub.listen((event) {
      if (event is Map) {
        switch (event["type"].toString()) {
          case "characters":
            _charactersCache.set(event["url"].toString(), event["response"].toString());
            break;
          case "series":
            _seriesCache.set(event["url"].toString(), event["response"].toString());
            break;
          case "images":
            _imagesCache.set(event["url"].toString(), event["response"] as List<int>);
            break;
        }
      }
    });
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/").linkFunction((request) async => Response.ok(await File('client.html').readAsString())..contentType = ContentType.html)
      ..route("/characters").link(() => CharactersController(_charactersCache, messageHub))
      ..route("/series").link(() => SeriesController(_seriesCache, messageHub))
      ..route("/images").link(() => ImagesController(_imagesCache, messageHub))
    ;
  }
}

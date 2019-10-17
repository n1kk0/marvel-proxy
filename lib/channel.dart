import 'package:dcache/dcache.dart';
import 'package:http/http.dart' as http;

import 'marvel_proxy.dart';

class MarvelProxyChannel extends ApplicationChannel {
  Cache<String, http.Response> _cache;

  @override
  Future prepare() async {
    _cache = SimpleCache<String, http.Response>(storage: SimpleStorage<String, http.Response>(size: 1000));
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/characters").link(() => CharactersController(_cache))
      ..route("/series").link(() => SeriesController(_cache))
    ;
  }
}

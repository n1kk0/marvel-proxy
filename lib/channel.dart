import 'marvel_proxy.dart';

class ApiConfiguration extends Configuration {
  ApiConfiguration(String fileName) : super.fromFile(File(fileName));

  String redisHost;
  int redisPort;

  String marvelApiPublicKey;
  String marvelApiPrivateKey;
}

class MarvelProxyChannel extends ApplicationChannel {
  ApiService apiService;
  CacheService cacheService;

  @override
  Future prepare() async {
    final config = ApiConfiguration(options.configurationFilePath);
    cacheService = CacheService(config.redisHost, config.redisPort);
    apiService = ApiService(config.marvelApiPublicKey, config.marvelApiPrivateKey, cacheService);

    await cacheService.connect();

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/").linkFunction((request) async => Response.ok(await File('client.html').readAsString())..contentType = ContentType.html)
      ..route("/characters").link(() => CharactersController(apiService))
      ..route("/characters/:id/comics").link(() => CharactersComicsController(apiService))
      ..route("/characters/:id/events").link(() => CharactersEventsController(apiService))
      ..route("/characters/:id/series").link(() => CharactersSeriesController(apiService))
      ..route("/characters/:id/stories").link(() => CharactersStoriesController(apiService))
      ..route("/series").link(() => SeriesController(apiService))
      ..route("/images").link(() => ImagesController(cacheService))
    ;
  }
}

import 'marvel_proxy.dart';

class ApiConfiguration extends Configuration {
  ApiConfiguration(String fileName) : super.fromFile(File(fileName));

  String redisHost;
  int redisPort;
}

class MarvelProxyChannel extends ApplicationChannel {
  CacheService cacheService;

  @override
  Future prepare() async {
    final config = ApiConfiguration(options.configurationFilePath);
    cacheService = CacheService(config.redisHost, config.redisPort);
    await cacheService.connect();

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/").linkFunction((request) async => Response.ok(await File('client.html').readAsString())..contentType = ContentType.html)
      ..route("/characters").link(() => CharactersController(cacheService))
      ..route("/series").link(() => SeriesController(cacheService))
      ..route("/images").link(() => ImagesController(cacheService))
    ;
  }
}

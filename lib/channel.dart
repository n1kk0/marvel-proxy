import 'marvel_proxy.dart';

class MarvelProxyChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    return Router()
      ..route("/characters").link(() => CharactersController())
      ..route("/series").link(() => SeriesController())
    ;
  }
}

import 'package:marvel_proxy/marvel_proxy.dart';

Future main() async {
  final app = Application<MarvelProxyChannel>()
      ..options.configurationFilePath = "config.src.yaml"
      ..options.port = 8888;

  await app.start();
}

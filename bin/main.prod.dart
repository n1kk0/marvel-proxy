import 'package:marvel_proxy/marvel_proxy.dart';

Future main() async {
  final app = Application<MarvelProxyChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.port = 8888;

  await app.start(numberOfInstances: 4);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
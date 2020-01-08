import 'package:marvel_proxy/marvel_proxy.dart';

Future main() async {
  final app = Application<MarvelProxyChannel>();

  await app.start();
}

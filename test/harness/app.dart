import 'package:aqueduct_test/aqueduct_test.dart';
import 'package:marvel_proxy/marvel_proxy.dart';

export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';
export 'package:marvel_proxy/marvel_proxy.dart';

class Harness extends TestHarness<MarvelProxyChannel> {
  @override
  Future onSetUp() async {

  }

  @override
  Future onTearDown() async {

  }
}

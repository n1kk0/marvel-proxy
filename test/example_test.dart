import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /characters?page=0 returns 200", () async {
    expectResponse(await harness.agent.get("/characters?p=0"), 200);
    expectResponse(await harness.agent.get("/series?tsw=s"), 200);
  });
}

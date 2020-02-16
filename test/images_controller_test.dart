import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /images?uri=... returns 200", () async {
    final response = await harness.agent.get("/characters?p=0");
    final response2 = await harness.agent.get("/images?uri=${response.body.as<Map>()['characters'][0]['thumbnail']}");
    expectResponse(response2, 200);
  });

  test("GET /images?uri=http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708.gif returns 200", () async {
    final response = await harness.agent.get("/images?uri=http://i.annihil.us/u/prod/marvel/i/mg/f/60/4c002e0305708.gif");
    expectResponse(response, 200);
  });
}

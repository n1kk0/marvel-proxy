import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /characters/:id/stories returns 200", () async {
    final response = await harness.agent.get("/characters?p=0");
    final response2 = await harness.agent.get("/characters/${response.body.as<Map>()['characters'][0]['id']}/stories");
    expectResponse(response2, 200);
    expect(response2.body.isEmpty, false);
  });
}

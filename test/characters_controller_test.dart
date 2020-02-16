import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /characters?page=0 10 & 55 return 200", () async {
    final response = await harness.agent.get("/characters?p=0");
    expectResponse(response, 200);
    expect(response.body.as<Map>()['characters'][0]['id'], 1011334);

    expectResponse(await harness.agent.get("/characters?p=10"), 200);
    expectResponse(await harness.agent.get("/characters?p=55"), 200);
  });
}

import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  test("GET /series?tsw=s returns 8821 as 1st id", () async {
    final response = await harness.agent.get("/series?tsw=s");
    expectResponse(response, 200);
    expect(response.body.as<List<Map>>()[0]['id'], 8821);
  });
}

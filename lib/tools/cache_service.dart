import 'dart:async';

import 'package:redis/redis.dart';

class CacheService {
  CacheService(this.host, this.port);

  final String host;
  final int port;
  final RedisConnection connection = RedisConnection();
  Command command;

  Future<void> connect() async {
    command = await connection.connect(host, port);
  }

  Future<bool> set(String key, dynamic value) async {
    final response = await command.send_object(["SET", key, value.toString()]);

    return response.toString() == "OK";
  }

  Future<dynamic> get(String key) async {
    return await command.send_object(["GET", key]);
  }

  Future<bool> exists(String key) async {
    final response = await command.send_object(["EXISTS", key]);

    return int.parse(response.toString()) == 1;
  }
}

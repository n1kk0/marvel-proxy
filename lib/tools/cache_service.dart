import 'dart:async';

import 'package:redis/redis.dart';

class CacheService {
  CacheService(this.host, this.port);

  final String host;
  final int port;
  final RedisConnection connection = RedisConnection();
  Command command;

  Future<void> connect() async {
    try {
      command = await connection.connect(host, port);
    } on Exception {
      command = null;
    }
  }

  Future<bool> set(String key, dynamic value) async {
    final response = command != null ? await command.send_object(["SET", key, value.toString()]) : "OK";

    return response.toString() == "OK";
  }

  Future<dynamic> get(String key) async {
    return await command.send_object(["GET", key]);
  }

  Future<bool> exists(String key) async {
    final response = command != null ? await command.send_object(["EXISTS", key]) : 0;

    return int.parse(response.toString()) == 1;
  }
}

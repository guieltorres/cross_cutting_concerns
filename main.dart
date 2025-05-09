import 'dart:convert';

import 'package:dio/dio.dart';
import "package:http/http.dart";

void main() async {
  // Dependency injection
  final userRepository = UserRepository(
    httpClient: createHttpClient(),
  );
  await userRepository.loadCurrentUser();
}

final class UserRepository {
  final HttpClient httpClient;

  const UserRepository({required this.httpClient});

  Future<void> loadCurrentUser() async {
    await httpClient.get(url: "http://localhost:6000/users");
  }
}

abstract interface class Logger {
  Future<void> log({required String key, required Map<String, dynamic> value});
}

final class ConsoleLogger implements Logger {
  @override
  Future<void> log({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    print(key);
    print(value);
  }
}

// Interface Segregation Principle
abstract interface class HttpClient {
  Future<dynamic> get({required String url});
}

// Factory Method Pattern
HttpClient createHttpClient() => HttpAdapterLogger(
      logger: ConsoleLogger(),
      decoratee: DioAdapter(client: Dio()),
    );

// Decorator
// Open-Closed Principle
// Liskov Substitution Principle
final class HttpAdapterLogger implements HttpClient {
  final Logger logger;
  final HttpClient decoratee;

  const HttpAdapterLogger({
    required this.logger,
    required this.decoratee,
  });

  @override
  Future<dynamic> get({required String url}) async {
    final response = await decoratee.get(url: url);
    await logger.log(key: "http_request", value: {
      "url": url,
      "response": response,
    });
    return response;
  }
}

// Adapters Pattern
final class HttpAdapter implements HttpClient {
  final Client client;

  const HttpAdapter({required this.client});

  @override
  Future<dynamic> get({required String url}) async {
    final response = await client.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}

final class DioAdapter implements HttpClient {
  final Dio client;

  const DioAdapter({required this.client});

  @override
  Future<dynamic> get({required String url}) async {
    final response = await client.get(url);
    return response.data;
  }
}

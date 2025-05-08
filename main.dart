import 'dart:convert';

import 'package:dio/dio.dart';
import "package:http/http.dart";

void main() async {
  // Injetando a dependência HttpClient
  final userRepository = UserRepository(httpClient: createHttpClient());
  await userRepository.loadCurrentUser();
}

final class UserRepository {
  final HttpClient httpClient;

  const UserRepository({required this.httpClient});

  Future<void> loadCurrentUser() async {
    final json = await httpClient.get(url: "http://localhost:6000/users");
    print(json);
  }
}

// Factory Method Pattern:
// Encapsula a lógica de criação de objetos e permite alternar entre diferentes implementações de  HttpClient
HttpClient createHttpClient() => HttpAdapter(client: Client());

// Interface Segregation Principle
abstract interface class HttpClient {
  Future<dynamic> get({required String url});
}

// Adapters Pattern:
// Ela adapta as bibliotecas `http` e `Dio` para a interface HttpClient, permitindo que o UserRepository use uma abstração comum.
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

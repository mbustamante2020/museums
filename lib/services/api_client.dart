import 'dart:convert';
import 'dart:io';

import 'package:exercise3/exceptions/museum_api_client_exceptions.dart';
import 'package:exercise3/model/museum.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseAddress =
      "https://do.diba.cat/api/dataset/museus/format/json";

  Future<List<Museum>> getAllMuseums(int ini, int fi) async {
    final response = await _get('/pag-ini/$ini/pag-fi/$fi');

    final decodedMuseums2 = json.decode(response.body)['elements'] as List;

    return decodedMuseums2
        .map((jsonMuseum) => Museum.fromJson(jsonMuseum))
        .toList();
  }

  Future<Museum> getMuseumsById(String id) async {
    final response = await _get('/id-punt/$id');

    return Museum.fromJson(json.decode(response.body));
  }

  Future<Museum> addMuseum(Museum museum) async {
    final response = await _post(museum);

    return Museum.fromJson(json.decode(response.body));
  }

  Future<Museum> updateMuseum(Museum museum) async {
    final response = await _put(museum);

    return Museum.fromJson(json.decode(response.body));
  }

  Future<void> deleteMuseumById(String id) async {
    await _delete(id);
  }

  Future<http.Response> _get(String endpoint) async {
    try {
      final response = await http.get(
        '$_baseAddress$endpoint',
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      return returnResponseOrThrowException(response);
    } on IOException catch (e) {
      print(e.toString());
      throw NetworkException();
    }
  }

  Future<http.Response> _post(Museum museum) async {
    try {
      final response = await http.post(
        '$_baseAddress/',
        body: json.encode(museum.toJson()),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      return returnResponseOrThrowException(response);
    } on IOException {
      throw NetworkException();
    }
  }

  Future<http.Response> _put(Museum museum) async {
    try {
      final response = await http.put(
        '$_baseAddress/todos/${museum.id}',
        body: json.encode(museum.toJson()),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      return returnResponseOrThrowException(response);
    } on IOException {
      throw NetworkException();
    }
  }

  Future<http.Response> _delete(String id) async {
    try {
      final response = await http.delete(
        '$_baseAddress/todos/$id',
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      return returnResponseOrThrowException(response);
    } on IOException {
      throw NetworkException();
    }
  }

  http.Response returnResponseOrThrowException(http.Response response) {
    if (response.statusCode == 404) {
      throw ItemNotFoundException();
    } else if (response.statusCode > 400) {
      throw UnKnowApiException(response.statusCode);
    } else {
      return response;
    }
  }
}

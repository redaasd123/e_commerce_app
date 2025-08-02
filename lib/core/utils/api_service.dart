import 'package:dio/dio.dart';

import '../errors/failure.dart';

class Api {
  static final String _baseUrl = 'https://dummyjson.com/';
  final Dio dio;

  Api({required this.dio});

  Future<dynamic> get({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = <String, String>{
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.get(
        _baseUrl + endPoint,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      throw ServerFailure(errMessage: e.toString());
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await dio.post(
        _baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put({
    required String endPoint,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await dio.put(
        _baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

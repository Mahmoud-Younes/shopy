import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final _baseUrl = 'https://student.valuxapps.com/api/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> getData({
    required String endPoint,
    @required String? token,
    Map<String, String>? headers,
  }) async {
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: headers ??
            {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required data,
    @required String? token,
    String? contentType,
    Map<String, String>? headers,
  }) async {
    var response = await _dio.post('$_baseUrl$endPoint',
        data: data,
        options: Options(
          contentType: contentType,
          headers: headers ??
              {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required data,
    @required String? token,
    String? contentType,
    Map<String, String>? headers,
  }) async {
    var response = await _dio.put('$_baseUrl$endPoint',
        data: data,
        options: Options(
          contentType: contentType,
          headers: headers ??
              {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    required data,
    @required String? token,
    String? contentType,
    Map<String, String>? headers,
  }) async {
    var response = await _dio.delete('$_baseUrl$endPoint',
        data: data,
        options: Options(
          contentType: contentType,
          headers: headers ??
              {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
        ));
    return response.data;
  }
}

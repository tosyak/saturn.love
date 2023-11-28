// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:saturn/data/network/api_exceptions.dart';
import 'package:saturn/utils/logger.dart';


abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String url, dynamic data);
  Future<dynamic> getGoogleApiResponse(String url, dynamic data);
}

class ApiService extends BaseApiServices {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      responseType: ResponseType.json,
    ),
  );

  @override
  Future getApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    logger.i('data ${jsonEncode(data)}');
    logger.i('url  $url');
    try {
      final Response response = await dio.post(
        url,
        data: jsonEncode(data),
        
      );
      responseJson = returnResponse(response);
      logger.i('ApiService getApiResponse status code ${response.statusCode}');
      logger.i('ApiService getApiResponse response $response');
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

   @override
  Future getGoogleApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    logger.i('data ${jsonEncode(data)}');
    logger.i('url  $url');
    try {
      final Response response = await dio.post(
        url,
        data: jsonEncode(data),
        
      );
      responseJson = returnResponse(response);
      logger.i('ApiService getApiResponse status code ${response.statusCode}');
      logger.i('ApiService getApiResponse response $response');
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return responseJson;
  }

  

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      case 400:
        throw BadRequestException(message: response.data.toString());
      case 401:
        throw UnAuthorizedException(message: response.data.toString());
      case 500:
        dynamic responseJson = jsonDecode(response.data);
        logger.i('500 status code');
        logger.i('500 status code response.data ${response.data}');
        return responseJson;
      default:
        logger.e(
            "Error occurred while communicating with server with status code ${response.statusCode}");
        throw FetchDataException(
            message:
                "Error occurred while communicating with server with status code ${response.statusCode}");
    }
  }
}

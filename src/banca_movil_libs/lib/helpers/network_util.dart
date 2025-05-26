import 'dart:io';

import 'package:banca_movil_libs/config/env_config.dart';
import 'package:banca_movil_libs/preferences/preferences.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final dioClient = NetworkUtil.getClient();

class NetworkUtil {
  static Dio getClient([
    Apis key =
        // !kDebugMode ?
        // Apis.apiUrlDev,
        //  : Apis.apiUrlQA,
        Apis.apiUrlQA,
  ]) {
    final Dio dio = _createClient(key);

    Apis host;

    switch (key) {
      case Apis.apiUrlDev:
        host = Apis.hostDev;
        break;
      default:
        host = Apis.hostQA;
        break;
    }

    dio.options.validateStatus = (status) => status! <= 600;
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };

    dio.interceptors.add(_RequestInterceptor(dio, host));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }

  static Dio _createClient(Apis key) {
    String apiName = EnvConfig.configs[key]!;
    Dio dio = Dio();
    dio.options.baseUrl = apiName;
    dio.options.connectTimeout = const Duration(minutes: 1);
    dio.options.receiveTimeout = const Duration(minutes: 1);
    dio.options.followRedirects = false;
    return dio;
  }
}

class _RequestInterceptor extends InterceptorsWrapper {
  final Dio dio;
  final Apis api;

  _RequestInterceptor(this.dio, this.api);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["Authorization"] = "Bearer ${preferences.uToken}";
    options.headers['Host'] = EnvConfig.configs[api];

    super.onRequest(options, handler);
  }
}

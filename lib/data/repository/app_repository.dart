import 'package:dio/dio.dart';
import 'package:handshake/data/repository/retrofit.dart';

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();
  late Dio _dio;
  late RestClient _client; // Provide a dio instance
  RestClient get getRetrofitClient => _client;

  AppRepository._internal() {
    _dio = Dio();
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (RequestOptions options){
    //     print(
    //         "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    //     print("Headers:");
    //     options.headers.forEach((k, v) => print('$k: $v'));
    //     if (options.queryParameters != null) {
    //       print("queryParameters:");
    //       options.queryParameters.forEach((k, v) => print('$k: $v'));
    //     }
    //     if (options.data != null && options.method.toUpperCase()=="POST") {
    //       print("Body: ${options.data.fields}");
    //     }
    //     print(
    //         "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    //   }
    // ));// Provide a dio instance
    _client = RestClient(_dio);
  }

  static AppRepository get instance => _instance;
}

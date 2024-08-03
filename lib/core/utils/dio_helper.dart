import 'dart:developer';
import 'package:alternative_energy_user_app/core/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    ResponseType? responseType,
  }) async {
    log("AAAAAAAAAAA");
    var response = await dio!.get(
      url,
      queryParameters: query,
      options: Options(
        validateStatus: (_) => true,
        responseType: responseType,
        headers: {'auth-token': token},
      ),
    );

    if (response.statusCode == 200) {
      // log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    var response = await dio!.post(
      url,
      queryParameters: query,
      options: Options(
        // headers: {"authorization": "Bearer $token"},
        validateStatus: (_) => true,
        headers: {'auth-token': token},
      ),
      data: body,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> postData222({
    required String url,
    required FormData body,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    var response = await dio!.post(
      url,
      queryParameters: query,
      options: Options(
        // headers: {"authorization": "Bearer $token"},
        validateStatus: (_) => true,
        headers: {'auth-token': token},
      ),
      data: body,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  // static Future<Response> uploadFile({
  //   required PlatformFile file,
  //   required String url,
  //   required Map<String, String> body,
  //   Map<String, dynamic>? query,
  //   String? token,
  // }) async {
  //   final FormData formData = FormData();
  //   body.forEach((key, value) {
  //     formData.fields.add(MapEntry(key, value));
  //   });
  //   formData.files.add(
  //     MapEntry(
  //       'file',
  //       MultipartFile.fromBytes(
  //         file.bytes!,
  //         filename: file.name,
  //       ),
  //     ),
  //   );
  //   var response = await dio!.post(
  //     url,
  //     queryParameters: query,
  //     options: Options(
  //       // headers: {"authorization": "Bearer $token"},
  //       contentType: 'multipart/form-data',
  //       validateStatus: (_) => true,
  //       headers: {'auth-token': token},
  //     ),
  //     data: formData,
  //     onSendProgress: (count, total) =>
  //         log('progress ... Count=$count  Total=$total'),
  //   );
  //   if (response.statusCode == 200) {
  //     log(response.data.toString());
  //     return response;
  //   } else {
  //     throw Exception(
  //       'there is an error with status code ${response.statusCode} and with body : ${response.data}',
  //     );
  //   }
  // }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    var response = await dio!.put(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
        // headers: {'auth-token': token},
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    var response = await dio!.delete(
      url,
      queryParameters: query,
      options: Options(
        headers: {"authorization": "Bearer $token"},
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      log(response.data.toString());
      return response;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.data}',
      );
    }
  }

  // static Future<dynamic> postWithImage({
  //   required String endPoint,
  //   required Map<String, String> body,
  //   @required List<String>? imagesPaths,
  //   @required String? token,
  // }) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('http://192.168.43.37:8000/api/$endPoint'),
  //   );
  //   request.fields.addAll(body);
  //   if (imagesPaths != null) {
  //     for (String path in imagesPaths) {
  //       request.files.add(await http.MultipartFile.fromPath('images[]', path));
  //     }
  //   }
  //   request.headers.addAll(
  //     {
  //       'Accept': 'application/json',
  //       if (token != null) 'auth-token': token,
  //       // if (token != null) 'Authorization': 'Bearer $token',
  //     },
  //   );
  //   http.StreamedResponse response = await request.send();

  //   http.Response r = await http.Response.fromStream(response);

  //   if (r.statusCode == 200) {
  //     Map<String, dynamic> data = jsonDecode(r.body);
  //     log('HTTP POSTIMAGE Data: $data');
  //     return data;
  //   } else {
  //     throw Exception(
  //       'there is an error with status code ${r.statusCode} and with body : ${r.body}',
  //     );
  //   }
  // }
}

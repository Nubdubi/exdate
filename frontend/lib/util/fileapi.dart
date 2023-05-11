import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FileApi {
  final _dio = Dio();

  Future<Response> uploadImage(Uint8List image, String photoname) async {
    final formData = FormData.fromMap(
        {'file': MultipartFile.fromBytes(image, filename: '')});

    if (kDebugMode) {
      final response = await _dio.post(
        'http://localhost:9000/upload',
        data: formData,
      );
      return response;
    } else {
      final response =
          await _dio.post('http://localhost:9000/upload', data: formData);
      return response;
    }
  }
}

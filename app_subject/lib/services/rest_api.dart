import 'dart:convert';

import 'package:app_subject/services/dio_config.dart';
import 'package:app_subject/utils/utility.dart';
import 'package:dio/dio.dart';

class CallAPI {
  // สร้าง Dio Instance
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

  // loginAPI API
  loginAPI(data) async {
    // Check Network Connection
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dio.post('login', data: data);
        Utility().logger.d(response.data);
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  registerAPI(data) async {
    // Check Network Connection
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dio.post('register', data: data);
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }
}
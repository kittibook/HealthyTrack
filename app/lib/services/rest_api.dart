import 'dart:convert';

import 'package:app/services/dio_config.dart';
import 'package:app/utils/utility.dart';
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

  editUser(data) async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.post('edit', data: data);
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  getUserProfileAPI() async {
    // Check Network Connection
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('user');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  book_1(data) async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.post('dataday/insert', data: data);
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  getMenuAPI() async {
    // Check Network Connection
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('menu/get');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

   getchartToRun1API() async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('eat/getuser');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  getchartwalkAPI() async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('walk/getuser');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  getchartallAPI() async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('walk/getuserbmi');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }

  getchartwalkkcalAPI() async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({
        'successfull': 'fail',
        'message': {'title': 'การเชื่อมต่อล้มเหลว', 'text': 'ลองอีกครั้ง'}
      });
    } else {
      try {
        final response = await _dioWithAuth.get('walk/getuserkcal');
        return jsonEncode(response.data);
      } catch (e) {
        Utility().logger.e(e);
      }
    }
  }



}
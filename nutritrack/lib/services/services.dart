import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  String baseUrl = 'http://localhost:3000';
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dio.post('$baseUrl/api/auth/login', 
      data: {
        "email": email,
        "password": password
      });
      return response;
    } catch(e) {
      throw Exception('Failed to login : $e');
    }
  }
  Future<Response> getUserByID({
    required int id,
  }) async {
    try{
      var response = await dio.get('$baseUrl/api/user/$id');
      return response;
    }catch(e) {
      throw Exception('Failed to load user : $e');
    }
  }
  Future<Response> getDailyStats({
    required int id,
  }) async {
    try{
      var response = await dio.get('$baseUrl/api/user/daily-records/$id');
    return response;
    } catch(e) {
      throw Exception('Failed to load daily stats: $e');
    }
  }
  Future<Response> getDailyMeals({
    required int id,
  }) async {
    try{
      var response = await dio.get('$baseUrl/api/user/meal-records/$id');
      return response;
    } catch(e) {
      throw Exception('Failed to load daily meals: #e');
    }
  }
  Future<Response> registerUser({
    required String email,
    required String password,
    required String username,
    required int age,
    required String gender,
    required int height,
    required double kilogram
     
  }) async {
    try{
      var response = await dio.post('$baseUrl/api/auth/register', data: {
        "username": username,
        "password": password,
        "email": email,
        "age": age,
        "gender": gender,
        "height": height,
        "kilogram": kilogram
      });
      return response;
    } catch(e) {
      throw Exception('Failed to register user : $e');
    }
  }

  Future<Response> verifyOTP({
    required String email,
    required String password,
    required String username,
    required int age,
    required String gender,
    required int height,
    required double kilogram,
    required String otp,
  }) async {
    try {
      var response = await dio.post('$baseUrl/api/auth/verify-otp', data: {
        "username": username,
        "password": password,
        "email": email,
        "otp": otp,
        "age": age,
        "gender": gender,
        "height": height,
        "kilogram": kilogram
      });
      return response;
    } catch(e) {
      if (e is DioException) {
        // Capture more details about the response
        print('Request failed with status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      }
      throw Exception('Failed to verify otp : $e');
    }
  }
}
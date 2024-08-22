import 'dart:convert';

import 'package:api_eccomerce/core/widget/uttils/constants/api_constatnts.dart';
import 'package:api_eccomerce/main.dart';
import 'package:api_eccomerce/screens/auth/logic/auth_states.dart';
import 'package:api_eccomerce/screens/auth/views/login_screen.dart';
import 'package:api_eccomerce/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> login(BuildContext context) async {
    emit(AuthLoading());

    var url = Uri.parse('${baseUrl}login');
    Map<String, dynamic> data = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      final response = await _postRequest(url, data);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Handle response data if needed
        debugPrint(' success: ${responseData['data']['token']}');
        token = responseData['data']['token'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
        emit(AuthSuccess());
      } else {
        final responseData = json.decode(response.body);
        debugPrint(' failed: ${responseData['message']}');
        emit(AuthError(responseData['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      debugPrint('Error during add: ${e.toString()}');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(BuildContext context) async {
    emit(AuthLoading());

    var url = Uri.parse('${baseUrl}register');
    Map<String, dynamic> data = {
      "email": emailController.text,
      "password": passwordController.text,
      "phone": phoneController.text,
      "name": nameController.text,
    };

    try {
      final response = await _postRequest(url, data);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Handle response data if needed
        debugPrint('Register success: ${responseData}');
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        emit(AuthSuccess());
      } else {
        final responseData = json.decode(response.body);
        debugPrint('Register failed: ${responseData['message']}');
        emit(AuthError(responseData['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      debugPrint('Error during registration: ${e.toString()}');
      emit(AuthError(e.toString()));
    }
  }

  Future<http.Response> _postRequest(Uri url, Map<String, dynamic> data) async {
    String body = json.encode(data);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response;
  }
}

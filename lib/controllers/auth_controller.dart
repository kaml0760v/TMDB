import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter Username!";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter Password!";
    }
    return null;
  }

  void loginAsGuest() async{
    
  }

  void loginWithUsernamePassword()async{

  }
}

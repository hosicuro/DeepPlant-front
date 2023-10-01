import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/main.dart';

class ChangePasswordViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // validation 문구를 위한 변수
  bool isRedTextPw = false;
  bool isRedTextCPw = false;

  String _userPassword = '';
  String _userNewPassword = '';
  String _userCPassword = '';

  // 버튼 활성화 확인을 위한 변수
  bool _isValidPw = false;
  bool _isValidNewPw = false;
  bool _isValidCPw = false;

  bool completed = false;

  void onChangedOriginPW(String? value) {
    _userPassword = value!;
    _tryValidation();
  }

  void onChangedNewPw(String? value) {
    _userNewPassword = value!;
    _tryValidation();
  }

  void onChangedCPw(String? value) {
    _userCPassword = value!;
    _tryValidation();
  }

  // 기존 비밀번호 유효성 검사
  String? pwValidate(String? value) {
    if (value!.isEmpty) {
      _isValidPw = false;
      return null;
    } else {
      _isValidPw = true;
      return null;
    }
  }

  // 새 비밀번호 유효성 검사
  String? newPwValidate(String? value) {
    final bool isValid = _validatePassword(value!);
    if (value.isEmpty) {
      _isValidNewPw = false;
      isRedTextPw = false;
      _isAllValid();
      notifyListeners();
      return null;
    } else if (!isValid) {
      _isValidNewPw = false;
      isRedTextPw = true;
      _isAllValid();
      notifyListeners();
      return null;
    }

    _isValidNewPw = true;
    isRedTextPw = false;
    _isAllValid();
    notifyListeners();
    return null;
  }

  // 비밀번호 재입력 유효성 검사
  String? cPwValidate(String? value) {
    if (value!.isEmpty) {
      _isValidCPw = false;
      isRedTextCPw = false;
      _isAllValid();
      notifyListeners();

      return null;
    } else if (_userNewPassword != _userCPassword) {
      _isValidCPw = false;
      isRedTextCPw = true;
      _isAllValid();
      notifyListeners();
      return null;
    }

    _isValidCPw = true;
    isRedTextCPw = false;
    _isAllValid();
    notifyListeners();
    return null;
  }

  // 비밀번호 유효성 검사
  bool _validatePassword(String password) {
    // 비밀번호 유효성을 검사하는 정규식
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\-_=+{};:,<.>]).{10,}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(password);
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
    }
  }

  // 모든 값이 올바르게 입력됐는지 확인
  void _isAllValid() {
    if (_isValidPw && _isValidNewPw && _isValidCPw) {
      completed = true;
    } else {
      completed = false;
    }
  }

  late BuildContext _context;

  // 비밀번호 변경
  Future<void> changePassword(BuildContext context) async {
    try {
      final response =
          await RemoteDataSource.checkUserPw(_userInfoToJson(_userPassword));

      _context = context;
      if (response == null) {
        _showAlert();
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: userModel.userId!,
            password: _userPassword,
          ),
        );
        await user.updatePassword(_userNewPassword);
        final response = await RemoteDataSource.changeUserPw(
            _userInfoToJson(_userNewPassword));

        if (response == null) {
          throw Error();
        }
      } else {
        print('User does not exist.');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  String _userInfoToJson(String password) {
    return jsonEncode({
      "id": userModel.userId,
      "password": password,
    });
  }

  void _showAlert() {
    ScaffoldMessenger.of(_context).showSnackBar(
      const SnackBar(
        content: Text('비밀번호를 확인하세요'),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

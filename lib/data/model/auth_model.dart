import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthModel{
  Future<UserCredential> login({required String email,required String password});
  Future<UserCredential> register({required String email,required String password,required String name,required String phoneNumber});
  Future<void> logOut();
}
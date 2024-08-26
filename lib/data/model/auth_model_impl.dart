import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_store/network/auth_data_agent/auth_data_agent.dart';
import 'package:pharmacy_store/network/auth_data_agent/auth_data_agent_impl.dart';
import 'auth_model.dart';

class AuthModelImpl extends AuthModel{
  AuthModelImpl._();

  static final AuthModelImpl _singleton = AuthModelImpl._();
  factory AuthModelImpl() => _singleton;

  final AuthDataAgent _authDataAgent = AuthDataAgentImpl();
  @override
  Future<UserCredential> login({required String email, required String password}) =>_authDataAgent.signInUser(email: email, password: password);

  @override
  Future<UserCredential> register({
    required String email, required String password,
    required String name,required String phoneNumber,
      }
      ) =>_authDataAgent.registerUser(email: email, password: password, name: name, phoneNumber: phoneNumber);
  @override
  Future<void> logOut()=>_authDataAgent.logout();

}
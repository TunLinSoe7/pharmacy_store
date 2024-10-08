import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy_store/data/vos/user_vo.dart';
import 'package:pharmacy_store/network/auth_data_agent/auth_data_agent.dart';

class AuthDataAgentImpl extends AuthDataAgent{
  AuthDataAgentImpl._();
  static final AuthDataAgentImpl _authDataAgentImpl = AuthDataAgentImpl._();
  factory AuthDataAgentImpl()=>_authDataAgentImpl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// login user
  @override
  Future<UserCredential> signInUser({required String email, required String password})async {
    try{
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }
  /// signUp user
  @override
  Future<UserCredential> registerUser({required String email,required String password,
    required String name,required String phoneNumber,}) async {
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = _auth.currentUser!.uid;
      final userName = '@${email.split('@')[0]}';
      UserVO userVO = UserVO(
        userId: uid,
        name: name,
        userName:userName,
        email: email,
        phoneNumber: phoneNumber
      );
      saveUserData(userVO);
      return userCredential;
    } on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }
  /// logout
  @override
  Future<void> logout() =>_auth.signOut();
  /// Save User Data to firestore
  @override
  Future<void> saveUserData(UserVO userVO) async{
    try{
      await _firebaseFirestore.collection('users').doc(userVO.userId).set(userVO.toJson());
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
import 'package:flutter/material.dart';
import 'package:pharmacy_store/data/model/auth_model.dart';
import 'package:pharmacy_store/data/model/auth_model_impl.dart';

class ProfileScreenProvider extends ChangeNotifier{
  bool _isDispose  = false;
  final AuthModel _authModel = AuthModelImpl();

  Future<void> logOut()async{
    await _authModel.logOut();
    notifyListeners();
  }
  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
  @override
  void notifyListeners() {
    if(!_isDispose){
      super.notifyListeners();
    }
  }

}
import 'package:flutter/material.dart';
import 'package:pharmacy_store/screens/home_screen.dart';
import 'package:pharmacy_store/screens/profile_screen.dart';
import 'package:pharmacy_store/screens/whist_list_screen.dart';

class NavigationProvider extends ChangeNotifier{
  bool _isDispose = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;
  void toggleIndex(int newIndex){
    _selectedIndex = newIndex;
    notifyListeners();
  }

  List<Widget> screens = [const HomeScreen(),Container(),const WhistListScreen(),const ProfileScreen()];
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
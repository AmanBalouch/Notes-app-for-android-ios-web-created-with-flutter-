import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class theme_provider extends ChangeNotifier{
  bool _isDark=false;

  void updateTheme({required bool value}){
    _isDark=value;
    notifyListeners();
  }

  bool getTheme(){
    return _isDark;
  }
}
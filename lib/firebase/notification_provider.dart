import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {

  int _count = 0;
  int get count => _count;

  setCount (int count){
    _count = count;
    notifyListeners();
  }


}
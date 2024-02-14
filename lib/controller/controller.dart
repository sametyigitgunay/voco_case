import 'package:flutter/material.dart';
import 'package:voco/model/user_model.dart';
import 'package:voco/services/user_model_services.dart';

class Controller extends ChangeNotifier {
  bool? isLoading;
  List <UserModelData?>  users = [];

  void getData () {
    UserServices.fetch().then((value) {
      if(value != null) {
        users = value.data!;
        isLoading = true;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  } 
}
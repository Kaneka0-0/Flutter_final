import 'package:flutter/material.dart';
import 'fakeapi_model.dart';
import 'music_service.dart';

class MusicLogic extends ChangeNotifier{
  List<FakeApiModel> _productList = [];
  List<FakeApiModel> get productList => _productList;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(){
    _loading = true;
    notifyListeners();
  }

  Future getData() async{
    setLoading();
    _productList = await MusicService.readAPI();
    _loading = false;
    notifyListeners();
  }
}
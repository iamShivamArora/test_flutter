import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/model/listModel.dart';


class PrefUtils {
  static SharedPreferences? _sharedPreferences;


  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveDataList(List<ListModel> data) async {
    List<String> jsonStringList = data.map((data) => jsonEncode(data.toJson())).toList();
    await _sharedPreferences!.setStringList('person_list', jsonStringList);
  }

  Future<List<ListModel>> getDataList() async {
    List<String>? jsonStringList = _sharedPreferences!.getStringList('person_list');

    if (jsonStringList != null) {
      return jsonStringList.map((jsonString) => ListModel.fromJson(jsonDecode(jsonString))).toList();
    }

    return [];
  }

  clearPreference()async{
    _sharedPreferences!.clear();

  }


}

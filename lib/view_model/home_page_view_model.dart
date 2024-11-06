import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testflutter/util/pref_utils.dart';

import '../model/listModel.dart';

class HomePageViewModel extends BaseViewModel {
  final TextEditingController titleController = TextEditingController();

  List<ListModel> taskList = [];

  clearData(){
    taskList.clear();
    PrefUtils().clearPreference();
    notifyListeners();
  }


  addInList({int index = -1, String title = ""}) {
    if (index == -1) {
      taskList.add(
          ListModel(title: titleController.text.trim(), checked: false));
    }
    else {
      taskList.insert(index, ListModel(title: title, checked: true));
    }

    PrefUtils().clearPreference();
    PrefUtils().saveDataList(taskList);
    notifyListeners();
    titleController.clear();
  }

  updateCheck(int index, String title) {
    taskList.removeAt(index);
    addInList(index: index, title: title);

  }

  Future<void> init() async {
    var list = await PrefUtils().getDataList();
    if (list.isNotEmpty) {
      taskList.addAll(list);
    }
  }

  String validate() {
    if (titleController.text.isEmpty) {
      return "Please enter title";
    } else {
      return "";
    }
  }
}

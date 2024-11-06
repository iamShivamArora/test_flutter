import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testflutter/view_model/home_page_view_model.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("List"),
              actions: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("Add Task Title"),
                              content: TextField(
                                controller: viewModel.titleController,
                                decoration:
                                    InputDecoration(hintText: "Enter Title"),
                              ),
                              actions: [
                                CupertinoButton(
                                    child: Text("Add"),
                                    onPressed: () {
                                      if (viewModel.validate().isEmpty) {
                                        viewModel.addInList();
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    viewModel.validate())));
                                      }
                                    }),
                                CupertinoButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      "Add",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    viewModel.clearData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Text(
                      "Clear List",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
            body: viewModel.taskList.isEmpty
                ? Center(child: Text("Please Add Task"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.taskList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: null,
                        leading: Checkbox(
                            value: viewModel.taskList[index].checked,
                            onChanged: (value) {
                              viewModel.updateCheck(index,viewModel.taskList[index].title);

                            }),
                        title: Text(viewModel.taskList[index].title),
                        subtitle: Text(viewModel.taskList[index].checked
                            ? "Completed"
                            : "Pending"),
                      );
                    }),
          );
        });
  }
}

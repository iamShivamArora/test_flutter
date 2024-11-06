class ListModel {
  ListModel({
    required this.title,
    required this.checked,
  });

  late final String title;
  late final bool checked;




  ListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['checked'] = this.checked;

    return data;
  }
}

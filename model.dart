import 'dart:convert';

RepModel repModelFromJson(String str) => RepModel.fromJson(json.decode(str));

class RepModel {
  RepModel({
    required this.name,
    required this.size,
    required this.medicines,
    required this.subItems,
  });

  final String name;
  final int size;
  final List<String> medicines;
  List<RepModel> subItems;

  addSubItem(RepModel item) {
    subItems.add(item);
  }

  factory RepModel.fromJson(Map<String, dynamic> json) => RepModel(
        name: json["name"],
        size: json["size"],
        medicines: List<String>.from(json["medicines"].map((x) => x)),
        subItems: List<RepModel>.from(json["subItems"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "\"name\"": "\"" + name + "\"",
        "\"size\"": size,
        "\"medicines\"": List<dynamic>.from(
            medicines.map((x) => "\"" + x.toString() + "\"")),
        "\"subitems\"": List<dynamic>.from(subItems.map((x) => x.toJson())),
      };
}

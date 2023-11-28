import 'package:json_annotation/json_annotation.dart';

part 'reports_list_model.g.dart';

@JsonSerializable(anyMap: true, fieldRename: FieldRename.snake)
class ReportsListModel {
  ReportsListModel({
    required this.reports,
    // required this.typeReport,
    required this.newreport,
  });

  final List<ReportsListItemModel> reports;
  // @JsonKey(name: 'type_report')
  // final List<String> typeReport;
  final String newreport;

  factory ReportsListModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportsListModelToJson(this);
}

@JsonSerializable()
class ReportsListItemModel {
  ReportsListItemModel({
    required this.id,
    required this.title,
    required this.datar,
    required this.timer,
    required this.city,
    required this.transite,
    required this.moon,
    required this.groups,
    required this.favorite,
    required this.expSub,
    required this.planId,
    required this.plan,
  });

  final String id;
  final String title;
  final DateTime datar;
  final String timer;
  final String city;
  final String transite;
  final String moon;
  final String groups;
  final String favorite;
  final dynamic expSub;
  final dynamic planId;
  final String plan;

  factory ReportsListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsListItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportsListItemModelToJson(this);
}


// import 'dart:convert';

// ReportsListModel reportsListFromJson(String str) => ReportsListModel.fromJson(json.decode(str));

// String reportsListToJson(ReportsListModel data) => json.encode(data.toJson());

// class ReportsListModel {
//     ReportsListModel({
//         required this.reports,
//         required this.typeReport,
//         required this.newreport,
//     });

//     final List<Report> reports;
//     final List<String> typeReport;
//     final String newreport;

//     factory ReportsListModel.fromJson(Map<String, dynamic> json) => ReportsListModel(
//         reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
//         typeReport: List<String>.from(json["type_report"].map((x) => x)),
//         newreport: json["newreport"],
//     );

//     Map<String, dynamic> toJson() => {
//         "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
//         "type_report": List<dynamic>.from(typeReport.map((x) => x)),
//         "newreport": newreport,
//     };
// }

// class Report {
//     Report({
//         required this.id,
//         required this.title,
//         required this.datar,
//         required this.timer,
//         required this.city,
//         required this.transite,
//         required this.moon,
//         required this.expSub,
//         required this.planId,
//         required this.plan,
//     });

//     final String id;
//     final String title;
//     final DateTime datar;
//     final String timer;
//     final String city;
//     final String transite;
//     final String moon;
//     final dynamic expSub;
//     final dynamic planId;
//     final String plan;

//     factory Report.fromJson(Map<String, dynamic> json) => Report(
//         id: json["id"],
//         title: json["title"],
//         datar: DateTime.parse(json["datar"]),
//         timer: json["timer"],
//         city: json["city"],
//         transite: json["transite"],
//         moon: json["moon"],
//         expSub: json["exp_sub"],
//         planId: json["plan_id"],
//         plan: json["plan"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "datar": "${datar.year.toString().padLeft(4, '0')}-${datar.month.toString().padLeft(2, '0')}-${datar.day.toString().padLeft(2, '0')}",
//         "timer": timer,
//         "city": city,
//         "transite": transite,
//         "moon": moon,
//         "exp_sub": expSub,
//         "plan_id": planId,
//         "plan": plan,
//     };
// }

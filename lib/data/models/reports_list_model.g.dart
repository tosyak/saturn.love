// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportsListModel _$ReportsListModelFromJson(Map json) => ReportsListModel(
      reports: (json['reports'] as List<dynamic>)
          .map((e) => ReportsListItemModel.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
      newreport: json['newreport'] as String,
    );

Map<String, dynamic> _$ReportsListModelToJson(ReportsListModel instance) =>
    <String, dynamic>{
      'reports': instance.reports,
      'newreport': instance.newreport,
    };

ReportsListItemModel _$ReportsListItemModelFromJson(
        Map<String, dynamic> json) =>
    ReportsListItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      datar: DateTime.parse(json['datar'] as String),
      timer: json['timer'] as String,
      city: json['city'] as String,
      transite: json['transite'] as String,
      moon: json['moon'] as String,
      groups: json['groups'] as String,
      favorite: json['favorite'] as String,
      expSub: json['expSub'],
      planId: json['planId'],
      plan: json['plan'] as String,
    );

Map<String, dynamic> _$ReportsListItemModelToJson(
        ReportsListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'datar': instance.datar.toIso8601String(),
      'timer': instance.timer,
      'city': instance.city,
      'transite': instance.transite,
      'moon': instance.moon,
      'groups': instance.groups,
      'favorite': instance.favorite,
      'expSub': instance.expSub,
      'planId': instance.planId,
      'plan': instance.plan,
    };

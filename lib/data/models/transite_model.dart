import 'package:json_annotation/json_annotation.dart';

part 'transite_model.g.dart';

@JsonSerializable()
class TransitsModel {
  TransitsModel({
    this.transite,
    this.source,
  });

  final Transite? transite;
  final Source? source;

  factory TransitsModel.fromJson(Map<String, dynamic> json) =>
      _$TransitsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransitsModelToJson(this);
}

@JsonSerializable()
class Source {
  Source({
    this.id,
    this.title,
    this.datar,
    this.timer,
    this.city,
    this.sh,
    this.dl,
    this.m,
    this.p,
    this.rez,
    this.utc,
    this.zone,
    this.users,
    this.timelite,
    this.groups,
    this.favorite,
  });

  final String? id;
  final String? title;
  final DateTime? datar;
  final String? timer;
  final String? city;
  final String? sh;
  final String? dl;
  final String? m;
  final String? p;
  final String? rez;
  final String? utc;
  final String? zone;
  final String? users;
  final String? timelite;
  final String? groups;
  final String? favorite;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

@JsonSerializable()
class Transite {
  Transite({
    this.title,
    this.about,
    this.child,
  });

  final String? title;
  final String? about;
  final Map<String, Child>? child;

  factory Transite.fromJson(Map<String, dynamic> json) =>
      _$TransiteFromJson(json);
  Map<String, dynamic> toJson() => _$TransiteToJson(this);
}

@JsonSerializable()
class Child {
  Child({
    this.title,
    this.time,
    this.content,
  });

  final String? title;
  final Time? time;
  final String? content;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
  Map<String, dynamic> toJson() => _$ChildToJson(this);
}

@JsonSerializable()
class Time {
  Time({
    this.start,
    this.end,
  });

  final End? start;
  final End? end;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class End {
  End({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  final DateTime? date;
  @JsonKey(name: 'timezone_type')
  final int? timezoneType;
  final Timezone? timezone;

  factory End.fromJson(Map<String, dynamic> json) => _$EndFromJson(json);
  Map<String, dynamic> toJson() => _$EndToJson(this);
}

enum Timezone { UTC }

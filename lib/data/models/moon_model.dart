import 'package:json_annotation/json_annotation.dart';

part 'moon_model.g.dart';

@JsonSerializable()
class MoonModel {
  MoonModel({
    this.moon,
    this.source,
  });

  final Moon? moon;
  final Source? source;

  factory MoonModel.fromJson(Map<String, dynamic> json) =>
      _$MoonModelFromJson(json);
  Map<String, dynamic> toJson() => _$MoonModelToJson(this);
}

@JsonSerializable()
class Moon {
  Moon({
    this.title,
    this.child,
  });

  final String? title;
  final List<Child>? child;

  factory Moon.fromJson(Map<String, dynamic> json) => _$MoonFromJson(json);
  Map<String, dynamic> toJson() => _$MoonToJson(this);
}

@JsonSerializable()
class Child {
  Child({
    this.title,
    this.content,
    this.about,
    this.time,
  });

  final String? title;
  final String? content;
  final String? about;
  final Time? time;

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
  final String? timezoneType;
  final String? timezone;

  factory End.fromJson(Map<String, dynamic> json) => _$EndFromJson(json);
  Map<String, dynamic> toJson() => _$EndToJson(this);
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

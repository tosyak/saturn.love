import 'package:json_annotation/json_annotation.dart';

part 'sadi_sati_model.g.dart';

@JsonSerializable()
class SadiSatiModel {
  SadiSatiModel({
    this.sadisati,
    this.source,
  });

  final Sadisati? sadisati;
  final Source? source;

  factory SadiSatiModel.fromJson(Map<String, dynamic> json) =>
      _$SadiSatiModelFromJson(json);
  Map<String, dynamic> toJson() => _$SadiSatiModelToJson(this);
}

@JsonSerializable()
class Sadisati {
  Sadisati({
    this.title,
    this.about,
    this.child,
  });

  final String? title;
  final String? about;
  final List<SadisatiChild>? child;

  factory Sadisati.fromJson(Map<String, dynamic> json) =>
      _$SadisatiFromJson(json);
  Map<String, dynamic> toJson() => _$SadisatiToJson(this);
}

@JsonSerializable()
class SadisatiChild {
  SadisatiChild({
    this.title,
    this.child,
  });

  final String? title;
  final List<ChildChild>? child;

  factory SadisatiChild.fromJson(Map<String, dynamic> json) =>
      _$SadisatiChildFromJson(json);
  Map<String, dynamic> toJson() => _$SadisatiChildToJson(this);
}

@JsonSerializable()
class ChildChild {
  ChildChild({
    this.title,
    this.time,
    this.content,
  });

  final String? title;
  final Time? time;
  final String? content;

  factory ChildChild.fromJson(Map<String, dynamic> json) =>
      _$ChildChildFromJson(json);
  Map<String, dynamic> toJson() => _$ChildChildToJson(this);
}

@JsonSerializable()
class Time {
  Time({
    this.start,
    this.end,
  });

  final List<End>? start;
  final List<End>? end;

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
  final Timezone? timezone;

  factory End.fromJson(Map<String, dynamic> json) => _$EndFromJson(json);
  Map<String, dynamic> toJson() => _$EndToJson(this);
}

enum Timezone { UTC }

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
  final String? datar;
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

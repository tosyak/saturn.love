// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sadi_sati_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SadiSatiModel _$SadiSatiModelFromJson(Map<String, dynamic> json) =>
    SadiSatiModel(
      sadisati: json['sadisati'] == null
          ? null
          : Sadisati.fromJson(json['sadisati'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SadiSatiModelToJson(SadiSatiModel instance) =>
    <String, dynamic>{
      'sadisati': instance.sadisati,
      'source': instance.source,
    };

Sadisati _$SadisatiFromJson(Map<String, dynamic> json) => Sadisati(
      title: json['title'] as String?,
      about: json['about'] as String?,
      child: (json['child'] as List<dynamic>?)
          ?.map((e) => SadisatiChild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SadisatiToJson(Sadisati instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'child': instance.child,
    };

SadisatiChild _$SadisatiChildFromJson(Map<String, dynamic> json) =>
    SadisatiChild(
      title: json['title'] as String?,
      child: (json['child'] as List<dynamic>?)
          ?.map((e) => ChildChild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SadisatiChildToJson(SadisatiChild instance) =>
    <String, dynamic>{
      'title': instance.title,
      'child': instance.child,
    };

ChildChild _$ChildChildFromJson(Map<String, dynamic> json) => ChildChild(
      title: json['title'] as String?,
      time: json['time'] == null
          ? null
          : Time.fromJson(json['time'] as Map<String, dynamic>),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ChildChildToJson(ChildChild instance) =>
    <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'content': instance.content,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      start: (json['start'] as List<dynamic>?)
          ?.map((e) => End.fromJson(e as Map<String, dynamic>))
          .toList(),
      end: (json['end'] as List<dynamic>?)
          ?.map((e) => End.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

End _$EndFromJson(Map<String, dynamic> json) => End(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      timezoneType: json['timezoneType'] as String?,
      timezone: $enumDecodeNullable(_$TimezoneEnumMap, json['timezone']),
    );

Map<String, dynamic> _$EndToJson(End instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timezoneType': instance.timezoneType,
      'timezone': _$TimezoneEnumMap[instance.timezone],
    };

const _$TimezoneEnumMap = {
  Timezone.UTC: 'UTC',
};

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      id: json['id'] as String?,
      title: json['title'] as String?,
      datar: json['datar'] as String?,
      timer: json['timer'] as String?,
      city: json['city'] as String?,
      sh: json['sh'] as String?,
      dl: json['dl'] as String?,
      m: json['m'] as String?,
      p: json['p'] as String?,
      rez: json['rez'] as String?,
      utc: json['utc'] as String?,
      zone: json['zone'] as String?,
      users: json['users'] as String?,
      timelite: json['timelite'] as String?,
      groups: json['groups'] as String?,
      favorite: json['favorite'] as String?,
    );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'datar': instance.datar,
      'timer': instance.timer,
      'city': instance.city,
      'sh': instance.sh,
      'dl': instance.dl,
      'm': instance.m,
      'p': instance.p,
      'rez': instance.rez,
      'utc': instance.utc,
      'zone': instance.zone,
      'users': instance.users,
      'timelite': instance.timelite,
      'groups': instance.groups,
      'favorite': instance.favorite,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoonModel _$MoonModelFromJson(Map<String, dynamic> json) => MoonModel(
      moon: json['moon'] == null
          ? null
          : Moon.fromJson(json['moon'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MoonModelToJson(MoonModel instance) => <String, dynamic>{
      'moon': instance.moon,
      'source': instance.source,
    };

Moon _$MoonFromJson(Map<String, dynamic> json) => Moon(
      title: json['title'] as String?,
      child: (json['child'] as List<dynamic>?)
          ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoonToJson(Moon instance) => <String, dynamic>{
      'title': instance.title,
      'child': instance.child,
    };

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      title: json['title'] as String?,
      content: json['content'] as String?,
      about: json['about'] as String?,
      time: json['time'] == null
          ? null
          : Time.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'about': instance.about,
      'time': instance.time,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      start: json['start'] == null
          ? null
          : End.fromJson(json['start'] as Map<String, dynamic>),
      end: json['end'] == null
          ? null
          : End.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

End _$EndFromJson(Map<String, dynamic> json) => End(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      timezoneType: json['timezoneType'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$EndToJson(End instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timezoneType': instance.timezoneType,
      'timezone': instance.timezone,
    };

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      id: json['id'] as String?,
      title: json['title'] as String?,
      datar: json['datar'] == null
          ? null
          : DateTime.parse(json['datar'] as String),
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
      'datar': instance.datar?.toIso8601String(),
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

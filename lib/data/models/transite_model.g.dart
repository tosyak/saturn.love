// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransitsModel _$TransitsModelFromJson(Map<String, dynamic> json) =>
    TransitsModel(
      transite: json['transite'] == null
          ? null
          : Transite.fromJson(json['transite'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransitsModelToJson(TransitsModel instance) =>
    <String, dynamic>{
      'transite': instance.transite,
      'source': instance.source,
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

Transite _$TransiteFromJson(Map<String, dynamic> json) => Transite(
      title: json['title'] as String?,
      about: json['about'] as String?,
      child: (json['child'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Child.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$TransiteToJson(Transite instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'child': instance.child,
    };

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      title: json['title'] as String?,
      time: json['time'] == null
          ? null
          : Time.fromJson(json['time'] as Map<String, dynamic>),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'content': instance.content,
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
      timezoneType: json['timezone_type'] as int?,
      timezone: $enumDecodeNullable(_$TimezoneEnumMap, json['timezone']),
    );

Map<String, dynamic> _$EndToJson(End instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timezone_type': instance.timezoneType,
      'timezone': _$TimezoneEnumMap[instance.timezone],
    };

const _$TimezoneEnumMap = {
  Timezone.UTC: 'UTC',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      time: json['time'] == null
          ? null
          : Time.fromJson(json['time'] as Map<String, dynamic>),
      image: json['image'] as String?,
      ayanamsa: json['ayanamsa'] as String?,
      lagnesh: json['lagnesh'] == null
          ? null
          : Lagnesh.fromJson(json['lagnesh'] as Map<String, dynamic>),
      energy: json['energy'] == null
          ? null
          : Energy.fromJson(json['energy'] as Map<String, dynamic>),
      happy: json['happy'] == null
          ? null
          : Happy.fromJson(json['happy'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : Type.fromJson(json['type'] as Map<String, dynamic>),
      rost: json['rost'] == null
          ? null
          : Rost.fromJson(json['rost'] as Map<String, dynamic>),
      asket: json['asket'] == null
          ? null
          : Asket.fromJson(json['asket'] as Map<String, dynamic>),
      ero: json['ero'] == null
          ? null
          : Ero.fromJson(json['ero'] as Map<String, dynamic>),
      libido: json['libido'],
      man: json['man'] == null
          ? null
          : Man.fromJson(json['man'] as Map<String, dynamic>),
      woman: json['woman'] == null
          ? null
          : Woman.fromJson(json['woman'] as Map<String, dynamic>),
      table: json['table'] == null
          ? null
          : Table.fromJson(json['table'] as Map<String, dynamic>),
      oneHouse: json['one_house'] == null
          ? null
          : OneHouse.fromJson(json['one_house'] as Map<String, dynamic>),
      downPlanet: json['down_planet'] == null
          ? null
          : DownPlanet.fromJson(json['down_planet'] as Map<String, dynamic>),
      habbyBlock: json['habby_block'] == null
          ? null
          : HabbyBlock.fromJson(json['habby_block'] as Map<String, dynamic>),
      yogas: json['yogas'] == null
          ? null
          : Yogas.fromJson(json['yogas'] as Map<String, dynamic>),
      lagneshBlock: json['lagnesh_block'] == null
          ? null
          : LagneshBlock.fromJson(
              json['lagnesh_block'] as Map<String, dynamic>),
      love: json['love'] == null
          ? null
          : Love.fromJson(json['love'] as Map<String, dynamic>),
      homePlanets: json['home_planets'] == null
          ? null
          : HomePlanets.fromJson(json['home_planets'] as Map<String, dynamic>),
      pdf: json['pdf'] == null
          ? null
          : SavePdf.fromJson(json['pdf'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'image': instance.image,
      'ayanamsa': instance.ayanamsa,
      'lagnesh': instance.lagnesh,
      'energy': instance.energy,
      'happy': instance.happy,
      'type': instance.type,
      'rost': instance.rost,
      'asket': instance.asket,
      'ero': instance.ero,
      'libido': instance.libido,
      'man': instance.man,
      'woman': instance.woman,
      'table': instance.table,
      'one_house': instance.oneHouse,
      'down_planet': instance.downPlanet,
      'habby_block': instance.habbyBlock,
      'yogas': instance.yogas,
      'lagnesh_block': instance.lagneshBlock,
      'love': instance.love,
      'home_planets': instance.homePlanets,
      'pdf': instance.pdf,
      'source': instance.source,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      timezoneType: json['timezone_type'] as int?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'timezone_type': instance.timezoneType,
      'timezone': instance.timezone,
    };

Lagnesh _$LagneshFromJson(Map<String, dynamic> json) => Lagnesh(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$LagneshToJson(Lagnesh instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Energy _$EnergyFromJson(Map<String, dynamic> json) => Energy(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$EnergyToJson(Energy instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Happy _$HappyFromJson(Map<String, dynamic> json) => Happy(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$HappyToJson(Happy instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      title: json['title'] as String?,
      about: json['about'] as String?,
      home: json['home'] as int?,
      content: json['content'],
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'home': instance.home,
      'content': instance.content,
    };

Rost _$RostFromJson(Map<String, dynamic> json) => Rost(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$RostToJson(Rost instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Asket _$AsketFromJson(Map<String, dynamic> json) => Asket(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$AsketToJson(Asket instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Ero _$EroFromJson(Map<String, dynamic> json) => Ero(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$EroToJson(Ero instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Libido _$LibidoFromJson(Map<String, dynamic> json) => Libido(
      content: json['content'],
    );

Map<String, dynamic> _$LibidoToJson(Libido instance) => <String, dynamic>{
      'content': instance.content,
    };

Man _$ManFromJson(Map<String, dynamic> json) => Man(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$ManToJson(Man instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Woman _$WomanFromJson(Map<String, dynamic> json) => Woman(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$WomanToJson(Woman instance) => <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Table _$TableFromJson(Map<String, dynamic> json) => Table(
      planets: json['planets'] == null
          ? null
          : Planets.fromJson(json['planets'] as Map<String, dynamic>),
      homes: json['homes'] == null
          ? null
          : Homes.fromJson(json['homes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TableToJson(Table instance) => <String, dynamic>{
      'planets': instance.planets,
      'homes': instance.homes,
    };

Homes _$HomesFromJson(Map<String, dynamic> json) => Homes(
      title: json['title'] as String?,
      head: (json['head'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      content: json['content'],
    );

Map<String, dynamic> _$HomesToJson(Homes instance) => <String, dynamic>{
      'title': instance.title,
      'head': instance.head,
      'content': instance.content,
    };

Planets _$PlanetsFromJson(Map<String, dynamic> json) => Planets(
      title: json['title'] as String?,
      head: (json['head'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      content: json['content'],
    );

Map<String, dynamic> _$PlanetsToJson(Planets instance) => <String, dynamic>{
      'title': instance.title,
      'head': instance.head,
      'content': instance.content,
    };

OneHouse _$OneHouseFromJson(Map<String, dynamic> json) => OneHouse(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$OneHouseToJson(OneHouse instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'content': instance.content,
    };

DownPlanet _$DownPlanetFromJson(Map<String, dynamic> json) => DownPlanet(
      title: json['title'] as String?,
      about: json['about'] as String?,
      child: json['child'],
    );

Map<String, dynamic> _$DownPlanetToJson(DownPlanet instance) =>
    <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'child': instance.child,
    };

HabbyBlock _$HabbyBlockFromJson(Map<String, dynamic> json) => HabbyBlock(
      title: json['title'] as String?,
      about: json['about'] as String?,
      child: (json['child'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, HabbyBlockChild.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$HabbyBlockToJson(HabbyBlock instance) =>
    <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'child': instance.child,
    };

HabbyBlockChild _$HabbyBlockChildFromJson(Map<String, dynamic> json) =>
    HabbyBlockChild(
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$HabbyBlockChildToJson(HabbyBlockChild instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

Yogas _$YogasFromJson(Map<String, dynamic> json) => Yogas(
      title: json['title'] as String?,
      child: (json['child'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, YogasChild.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$YogasToJson(Yogas instance) => <String, dynamic>{
      'title': instance.title,
      'child': instance.child,
    };

YogasChild _$YogasChildFromJson(Map<String, dynamic> json) => YogasChild(
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$YogasChildToJson(YogasChild instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };

LagneshBlock _$LagneshBlockFromJson(Map<String, dynamic> json) => LagneshBlock(
      title: json['title'] as String?,
      about: json['about'] as String?,
      child: (json['child'] as List<dynamic>?)
          ?.map((e) => LagneshBlockChild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LagneshBlockToJson(LagneshBlock instance) =>
    <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'child': instance.child,
    };

LagneshBlockChild _$LagneshBlockChildFromJson(Map<String, dynamic> json) =>
    LagneshBlockChild(
      title: json['title'] as String?,
      about: json['about'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$LagneshBlockChildToJson(LagneshBlockChild instance) =>
    <String, dynamic>{
      'title': instance.title,
      'about': instance.about,
      'content': instance.content,
    };

Love _$LoveFromJson(Map<String, dynamic> json) => Love(
      title: json['title'] as String?,
      child: json['child'],
    );

Map<String, dynamic> _$LoveToJson(Love instance) => <String, dynamic>{
      'title': instance.title,
      'child': instance.child,
    };

LoveChild _$LoveChildFromJson(Map<String, dynamic> json) => LoveChild(
      title: json['title'] as String?,
      content: json['content'] as String?,
      about: json['about'] as String?,
    );

Map<String, dynamic> _$LoveChildToJson(LoveChild instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'about': instance.about,
    };

HomePlanets _$HomePlanetsFromJson(Map<String, dynamic> json) => HomePlanets(
      title: json['title'] as String?,
      child: json['child'],
    );

Map<String, dynamic> _$HomePlanetsToJson(HomePlanets instance) =>
    <String, dynamic>{
      'title': instance.title,
      'child': instance.child,
    };

SavePdf _$SavePdfFromJson(Map<String, dynamic> json) => SavePdf(
      title: json['title'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$SavePdfToJson(SavePdf instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
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

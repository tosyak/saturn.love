// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  final Time? time;
  final String? image;
  final String? ayanamsa;
  final Lagnesh? lagnesh;
  final Energy? energy;
  final Happy? happy;
  final Type? type;
  final Rost? rost;
  final Asket? asket;
  final Ero? ero;
  final dynamic libido;
  final Man? man;
  final Woman? woman;
  final Table? table;
  @JsonKey(name: 'one_house')
  final OneHouse? oneHouse;
  @JsonKey(name: 'down_planet')
  final DownPlanet? downPlanet;
  @JsonKey(name: 'habby_block')
  final HabbyBlock? habbyBlock;
  final Yogas? yogas;
  @JsonKey(name: 'lagnesh_block')
  final LagneshBlock? lagneshBlock;
  final Love? love;
  @JsonKey(name: 'home_planets')
  final HomePlanets? homePlanets;
  final SavePdf? pdf;
  final Source? source;
  ReportModel({
    this.time,
    this.image,
    this.ayanamsa,
    this.lagnesh,
    this.energy,
    this.happy,
    this.type,
    this.rost,
    this.asket,
    this.ero,
    this.libido,
    this.man,
    this.woman,
    this.table,
    this.oneHouse,
    this.downPlanet,
    this.habbyBlock,
    this.yogas,
    this.lagneshBlock,
    this.love,
    this.homePlanets,
    this.pdf,
    this.source,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}

@JsonSerializable()
class Time {
  Time({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  final DateTime? date;
  @JsonKey(name: 'timezone_type')
  final int? timezoneType;
  final String? timezone;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);
  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class Lagnesh {
  Lagnesh({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Lagnesh.fromJson(Map<String, dynamic> json) =>
      _$LagneshFromJson(json);
  Map<String, dynamic> toJson() => _$LagneshToJson(this);
}

@JsonSerializable()
class Energy {
  Energy({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Energy.fromJson(Map<String, dynamic> json) => _$EnergyFromJson(json);
  Map<String, dynamic> toJson() => _$EnergyToJson(this);
}

@JsonSerializable()
class Happy {
  Happy({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Happy.fromJson(Map<String, dynamic> json) => _$HappyFromJson(json);
  Map<String, dynamic> toJson() => _$HappyToJson(this);
}

@JsonSerializable()
class Type {
  Type({
    this.title,
    this.about,
    this.home,
    this.content,
  });

  final String? title;
  final String? about;
  final int? home;
  final dynamic content;

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class Rost {
  Rost({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Rost.fromJson(Map<String, dynamic> json) => _$RostFromJson(json);
  Map<String, dynamic> toJson() => _$RostToJson(this);
}

@JsonSerializable()
class Asket {
  Asket({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Asket.fromJson(Map<String, dynamic> json) => _$AsketFromJson(json);
  Map<String, dynamic> toJson() => _$AsketToJson(this);
}

@JsonSerializable()
class Ero {
  Ero({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Ero.fromJson(Map<String, dynamic> json) => _$EroFromJson(json);
  Map<String, dynamic> toJson() => _$EroToJson(this);
}

@JsonSerializable()
class Libido {
  Libido({
    // this.title,
    // this.about,
    this.content,
  });

  // final String? title;
  // final String? about;
  final dynamic content;

  factory Libido.fromJson(Map<String, dynamic> json) => _$LibidoFromJson(json);
  Map<String, dynamic> toJson() => _$LibidoToJson(this);
}

@JsonSerializable()
class Man {
  Man({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Man.fromJson(Map<String, dynamic> json) => _$ManFromJson(json);
  Map<String, dynamic> toJson() => _$ManToJson(this);
}

@JsonSerializable()
class Woman {
  Woman({
    this.title,
    this.about,
    this.content,
  });

  final String? title;
  final String? about;
  final dynamic content;

  factory Woman.fromJson(Map<String, dynamic> json) => _$WomanFromJson(json);
  Map<String, dynamic> toJson() => _$WomanToJson(this);
}

@JsonSerializable()
class Table {
  Table({
    this.planets,
    this.homes,
  });

  final Planets? planets;
  final Homes? homes;

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);
  Map<String, dynamic> toJson() => _$TableToJson(this);
}

@JsonSerializable()
class Homes {
  Homes({
    this.title,
    this.head,
    this.content,
  });

  final String? title;
  final Map<String, String>? head;
  // final List<Map<String, dynamic>>? content;
  final dynamic content;

  factory Homes.fromJson(Map<String, dynamic> json) => _$HomesFromJson(json);
  Map<String, dynamic> toJson() => _$HomesToJson(this);
}

@JsonSerializable()
class Planets {
  Planets({
    this.title,
    this.head,
    this.content,
  });

  final String? title;
  final Map<String, String>? head;
  final dynamic content;

  factory Planets.fromJson(Map<String, dynamic> json) =>
      _$PlanetsFromJson(json);
  Map<String, dynamic> toJson() => _$PlanetsToJson(this);
}

@JsonSerializable()
class OneHouse {
  OneHouse({
    this.title,
    this.subtitle,
    this.content,
  });

  final String? title;
  final String? subtitle;
  final String? content;

  factory OneHouse.fromJson(Map<String, dynamic> json) =>
      _$OneHouseFromJson(json);
  Map<String, dynamic> toJson() => _$OneHouseToJson(this);
}

@JsonSerializable()
class DownPlanet {
  DownPlanet({
    this.title,
    this.about,
    this.child,
  });

  final String? title;
  final String? about;
  final dynamic child;

  factory DownPlanet.fromJson(Map<String, dynamic> json) =>
      _$DownPlanetFromJson(json);
  Map<String, dynamic> toJson() => _$DownPlanetToJson(this);
}

@JsonSerializable()
class HabbyBlock {
  HabbyBlock({
    this.title,
    this.about,
    this.child,
  });

  final String? title;
  final String? about;
  final Map<String, HabbyBlockChild>? child;
  // final ChildElement child;

  factory HabbyBlock.fromJson(Map<String, dynamic> json) =>
      _$HabbyBlockFromJson(json);
  Map<String, dynamic> toJson() => _$HabbyBlockToJson(this);
}

@JsonSerializable()
class HabbyBlockChild {
  final String? title;
  final String? content;

  HabbyBlockChild({
    this.title,
    this.content,
  });

  factory HabbyBlockChild.fromJson(Map<String, dynamic> json) =>
      _$HabbyBlockChildFromJson(json);
  Map<String, dynamic> toJson() => _$HabbyBlockChildToJson(this);
}

@JsonSerializable()
class Yogas {
  Yogas({
    this.title,
    this.child,
  });

  final String? title;
  final Map<String, YogasChild>? child;
  // final ChildElement child;

  factory Yogas.fromJson(Map<String, dynamic> json) => _$YogasFromJson(json);
  Map<String, dynamic> toJson() => _$YogasToJson(this);
}

@JsonSerializable()
class YogasChild {
  final String? title;
  final String? content;

  YogasChild({
    this.title,
    this.content,
  });

  factory YogasChild.fromJson(Map<String, dynamic> json) =>
      _$YogasChildFromJson(json);
  Map<String, dynamic> toJson() => _$YogasChildToJson(this);
}

@JsonSerializable()
class LagneshBlock {
  final String? title;
  final String? about;
  final List<LagneshBlockChild>? child;

  LagneshBlock({
    this.title,
    this.about,
    this.child,
  });

  factory LagneshBlock.fromJson(Map<String, dynamic> json) =>
      _$LagneshBlockFromJson(json);
  Map<String, dynamic> toJson() => _$LagneshBlockToJson(this);
}

@JsonSerializable()
class LagneshBlockChild {
  final String? title;
  final String? about;
  final String? content;

  LagneshBlockChild({
    this.title,
    this.about,
    this.content,
  });

  factory LagneshBlockChild.fromJson(Map<String, dynamic> json) =>
      _$LagneshBlockChildFromJson(json);
  Map<String, dynamic> toJson() => _$LagneshBlockChildToJson(this);
}

@JsonSerializable()
class Love {
  final String? title;
  final dynamic child;

  Love({
    this.title,
    this.child,
  });

  factory Love.fromJson(Map<String, dynamic> json) => _$LoveFromJson(json);
  Map<String, dynamic> toJson() => _$LoveToJson(this);
}

@JsonSerializable()
class LoveChild {
  final String? title;
  final String? content;
  final String? about;

  LoveChild({
    this.title,
    this.content,
    this.about,
  });

  factory LoveChild.fromJson(Map<String, dynamic> json) =>
      _$LoveChildFromJson(json);
  Map<String, dynamic> toJson() => _$LoveChildToJson(this);
}

@JsonSerializable()
class HomePlanets {
  final String? title;
  final dynamic child;
  HomePlanets({
    this.title,
    this.child,
  });
  factory HomePlanets.fromJson(Map<String, dynamic> json) =>
      _$HomePlanetsFromJson(json);
  Map<String, dynamic> toJson() => _$HomePlanetsToJson(this);
}

// @JsonSerializable()
// class HomePlanetsChild {
//   final String? title;
//   final String? content;
//   final dynamic child;

//   HomePlanetsChild({
//     this.title,
//     this.content,
//     this.child,
//   });
//   factory HomePlanetsChild.fromJson(Map<String, dynamic> json) =>
//       _$HomePlanetsChildFromJson(json);
//   Map<String, dynamic> toJson() => _$HomePlanetsChildToJson(this);
// }

// @JsonSerializable()
// class HomeChild {
//   final String? title;
//   final String? content;
//   HomeChild({
//     this.title,
//     this.content,
//   });
//   factory HomeChild.fromJson(Map<String, dynamic> json) =>
//       _$HomeChildFromJson(json);
//   Map<String, dynamic> toJson() => _$HomeChildToJson(this);
// }

@JsonSerializable()
class SavePdf {
  SavePdf({
    this.title,
    this.link,
  });

  final String? title;
  final String? link;

  factory SavePdf.fromJson(Map<String, dynamic> json) =>
      _$SavePdfFromJson(json);
  Map<String, dynamic> toJson() => _$SavePdfToJson(this);
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




// @JsonSerializable()
// class ChildElement {
//   ChildElement({
//      this.childOne,
//      this.childTwo,
//      this.childThree,
//   });
//   @JsonKey(name: '1')
//   final ChildElementOne childOne;
//   @JsonKey(name: '2')
//   final ChildElementTwo childTwo;
//   @JsonKey(name: '3')
//   final ChildElementThree childThree;

//   factory ChildElement.fromJson(Map<String, dynamic> json) =>
//       _$ChildElementFromJson(json);
//   Map<String, dynamic> toJson() => _$ChildElementToJson(this);
// }

// @JsonSerializable()
// class ChildElementOne {
//   ChildElementOne({
//      this.title,
//      this.content,
//   });

//   final String? title;
//   final String? content;

//   factory ChildElementOne.fromJson(Map<String, dynamic> json) =>
//       _$ChildElementOneFromJson(json);
//   Map<String, dynamic> toJson() => _$ChildElementOneToJson(this);
// }

// @JsonSerializable()
// class ChildElementTwo {
//   ChildElementTwo({
//      this.title,
//      this.content,
//   });

//   final String? title;
//   final String? content;

//   factory ChildElementTwo.fromJson(Map<String, dynamic> json) =>
//       _$ChildElementTwoFromJson(json);
//   Map<String, dynamic> toJson() => _$ChildElementTwoToJson(this);
// }

// @JsonSerializable()
// class ChildElementThree {
//   ChildElementThree({
//      this.title,
//      this.content,
//   });

//   final String? title;
//   final String? content;

//   factory ChildElementThree.fromJson(Map<String, dynamic> json) =>
//       _$ChildElementThreeFromJson(json);
//   Map<String, dynamic> toJson() => _$ChildElementThreeToJson(this);
// }







// @JsonSerializable()
// class ReportModel {
//   ReportModel({
//      this.image,
//      this.ayanamsa,
//      this.lagnesh,
//      this.energy,
//      this.happy,
//      this.type,
//      this.rost,
//      this.asket,
//      this.ero,
//      this.libido,
//      this.man,
//      this.woman,
//      this.table,
//      this.oneHouse,
//      this.habbyBlock,
//      this.yogas,
//      this.lagneshBlock,
//      this.love,
//      this.homePlanets,
//      this.pdf,
//      this.source,
//   });

//   final String? image;
//   final String? ayanamsa;
//   final Lagnesh lagnesh;
//   final CardContent energy;
//   final CardContent happy;
//   final Lagnesh type;
//   final CardContent rost;
//   final CardContent asket;
//   final CardContent ero;
//   final CardContent libido;
//   final CardContent man;
//   final CardContent woman;
//   final Table table;
//   final OneHouse oneHouse;
//   final HabbyBlock habbyBlock;
//   final Yogas yogas;
//   final LagneshBlock lagneshBlock;
//   final Love love;
//   final HomePlanets homePlanets;
//   final Pdf pdf;
//   final Source source;

//   factory ReportModel.fromJson(Map<String, dynamic> json) =>
//       _$ReportModelFromJson(json);
//   Map<String, dynamic> toJson() => _$ReportModelToJson(this);
// }

// @JsonSerializable()
// class CardContent {
//   CardContent({
//      this.title,
//      this.about,
//      this.content,
//   });

//   final String? title;
//   final String? about;
//   final List<String?> content;

//   factory CardContent.fromJson(Map<String, dynamic> json) =>
//       _$CardContentFromJson(json);
//   Map<String, dynamic> toJson() => _$CardContentToJson(this);
// }

// @JsonSerializable()
// class HabbyBlock {
//   HabbyBlock({
//      this.title,
//      this.about,
//      this.child,
//   });

//   final String? title;
//   final String? about;
//   final Map<String, ChildElement> child;

//   factory HabbyBlock.fromJson(Map<String, dynamic> json) =>
//       _$HabbyBlockFromJson(json);
//   Map<String, dynamic> toJson() => _$HabbyBlockToJson(this);
// }

// @JsonSerializable()
// class ChildElement {
//   ChildElement({
//      this.title,
//      this.content,
//   });

//   final String? title;
//   final String? content;

//     factory ChildElement.fromJson(Map<String, dynamic> json) =>
//       _$ChildElementFromJson(json);
//   Map<String, dynamic> toJson() => _$ChildElementToJson(this);
// }

// @JsonSerializable()
// class HomePlanets {
//   HomePlanets({
//      this.title,
//      this.child,
//   });

//   final String? title;
//   final Map<String, HomePlanetsChild> child;

//   factory HomePlanets.fromJson(Map<String, dynamic> json) =>
//       _$HomePlanetsFromJson(json);
//   Map<String, dynamic> toJson() => _$HomePlanetsToJson(this);
// }

// @JsonSerializable()
// class HomePlanetsChild {
//   HomePlanetsChild({
//      this.title,
//      this.content,
//      this.child,
//   });

//   final String? title;
//   final String? content;
//   final List<ChildElement> child;

//   factory HomePlanetsChild.fromJson(Map<String, dynamic> json) =>
//       _$HomePlanetsChildFromJson(json);
//   Map<String, dynamic> toJson() => _$HomePlanetsChildToJson(this);
// }

// @JsonSerializable()
// class Lagnesh {
//   Lagnesh({
//      this.title,
//      this.about,
//      this.content,
//     //  this.home,
//   });

//   final String? title;
//   final String? about;
//   final String? content;
//   // final int home;

//   factory Lagnesh.fromJson(Map<String, dynamic> json) =>
//       _$LagneshFromJson(json);
//   Map<String, dynamic> toJson() => _$LagneshToJson(this);
// }

// @JsonSerializable()
// class LagneshBlock {
//   LagneshBlock({
//      this.title,
//      this.about,
//      this.child,
//   });

//   final String? title;
//   final String? about;
//   final List<Lagnesh> child;

//   factory LagneshBlock.fromJson(Map<String, dynamic> json) =>
//       _$LagneshBlockFromJson(json);
//   Map<String, dynamic> toJson() => _$LagneshBlockToJson(this);
// }

// @JsonSerializable()
// class Love {
//   Love({
//      this.title,
//      this.child,
//   });

//   final String? title;
//   final Map<String, LoveChild> child;

//   factory Love.fromJson(Map<String, dynamic> json) =>
//       _$LoveFromJson(json);
//   Map<String, dynamic> toJson() => _$LoveToJson(this);
// }

// @JsonSerializable()
// class LoveChild {
//   LoveChild({
//      this.title,
//      this.content,
//      this.about,
//      this.home,
//   });

//   final String? title;
//   final String? content;
//   final String? about;
//   final int home;

//    factory LoveChild.fromJson(Map<String, dynamic> json) =>
//       _$LoveChildFromJson(json);
//   Map<String, dynamic> toJson() => _$LoveChildToJson(this);
// }

// @JsonSerializable()
// class OneHouse {
//   OneHouse({
//      this.title,
//      this.subtitle,
//      this.content,
//   });

//   final String? title;
//   final String? subtitle;
//   final String? content;

//   factory OneHouse.fromJson(Map<String, dynamic> json) =>
//       _$OneHouseFromJson(json);
//   Map<String, dynamic> toJson() => _$OneHouseToJson(this);
// }

// @JsonSerializable()
// class Pdf {
//   Pdf({
//      this.title,
//      this.link,
//   });

//   final String? title;
//   final String? link;

//  factory Pdf.fromJson(Map<String, dynamic> json) =>
//       _$PdfFromJson(json);
//   Map<String, dynamic> toJson() => _$PdfToJson(this);
// }

// @JsonSerializable()
// class Source {
//   Source({
//      this.id,
//      this.title,
//      this.datar,
//      this.timer,
//      this.city,
//      this.sh,
//      this.dl,
//      this.m,
//      this.p,
//      this.rez,
//      this.utc,
//      this.zone,
//      this.users,
//      this.timelite,
//      this.groups,
//      this.favorite,
//   });

//   final String? id;
//   final String? title;
//   final DateTime datar;
//   final String? timer;
//   final String? city;
//   final String? sh;
//   final String? dl;
//   final String? m;
//   final String? p;
//   final String? rez;
//   final String? utc;
//   final String? zone;
//   final String? users;
//   final String? timelite;
//   final String? groups;
//   final String? favorite;

//   factory Source.fromJson(Map<String, dynamic> json) =>
//       _$SourceFromJson(json);
//   Map<String, dynamic> toJson() => _$SourceToJson(this);
// }

// @JsonSerializable()
// class Table {
//   Table({
//      this.planets,
//      this.homes,
//   });

//   final Planets planets;
//   final Homes homes;

//   factory Table.fromJson(Map<String, dynamic> json) =>
//       _$TableFromJson(json);
//   Map<String, dynamic> toJson() => _$TableToJson(this);
// }

// @JsonSerializable()
// class Homes {
//   Homes({
//      this.title,
//      this.head,
//      this.content,
//   });

//   final String? title;
//   final Map<String, String>? head;
//   final List<Map<String, dynamic>>? content;

//   factory Homes.fromJson(Map<String, dynamic> json) =>
//       _$HomesFromJson(json);
//   Map<String, dynamic> toJson() => _$HomesToJson(this);
// }

// @JsonSerializable()
// class Planets {
//   Planets({
//      this.title,
//      this.head,
//      this.content,
//   });

//   final String? title;
//   final Map<String, String>? head;
//   final List<Map<String, dynamic>>? content;

//   factory Planets.fromJson(Map<String, dynamic> json) =>
//       _$PlanetsFromJson(json);
//   Map<String, dynamic> toJson() => _$PlanetsToJson(this);
// }

// @JsonSerializable()
// class Yogas {
//   Yogas({
//      this.title,
//      this.child,
//   });

//   final String? title;
//   final Map<String, ChildElement> child;

//  factory Yogas.fromJson(Map<String, dynamic> json) =>
//       _$YogasFromJson(json);
//   Map<String, dynamic> toJson() => _$YogasToJson(this);
// }

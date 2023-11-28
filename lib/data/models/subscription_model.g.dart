// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: json['id'] as String,
      planId: json['planId'] as String,
      ctime: DateTime.parse(json['ctime'] as String),
      extime: DateTime.parse(json['extime'] as String),
      price: json['price'] as String,
      activated: json['activated'] as String,
      ordId: json['ordId'] as String,
      recurring: json['recurring'] as String,
      planName: json['planName'] as String,
      plan: json['plan'] as String,
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'ctime': instance.ctime.toIso8601String(),
      'extime': instance.extime.toIso8601String(),
      'price': instance.price,
      'activated': instance.activated,
      'ordId': instance.ordId,
      'recurring': instance.recurring,
      'planName': instance.planName,
      'plan': instance.plan,
    };

import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  SubscriptionModel({
    required this.id,
    required this.planId,
    required this.ctime,
    required this.extime,
    required this.price,
    required this.activated,
    required this.ordId,
    required this.recurring,
    required this.planName,
    required this.plan,
  });

  final String id;
  final String planId;
  final DateTime ctime;
  final DateTime extime;
  final String price;
  final String activated;
  final String ordId;
  final String recurring;
  final String planName;
  final String plan;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}

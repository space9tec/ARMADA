import 'package:json_annotation/json_annotation.dart';

part 'farm_model.g.dart';

@JsonSerializable()
class FarmModel {
  final String farmname;
  final String croptype;
  final String soiltype;
  final int farmsize;
  final int latitud;
  final int longtude;

  FarmModel(
      {required this.farmname,
      required this.croptype,
      required this.soiltype,
      required this.farmsize,
      required this.latitud,
      required this.longtude});
  factory FarmModel.fromJson(Map<String, dynamic> json) =>
      _$FarmModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmModelToJson(this);
}
// @JsonSerializable()
// 

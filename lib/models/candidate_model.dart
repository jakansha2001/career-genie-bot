import 'package:json_annotation/json_annotation.dart';

part 'candidate_model.g.dart';

@JsonSerializable()
class CandidateModel {
  final String id;
  final String name;
  final String location;
  final int experience;
  final List<String> skills;

  CandidateModel({
    required this.id,
    required this.name,
    required this.location,
    required this.experience,
    required this.skills,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}

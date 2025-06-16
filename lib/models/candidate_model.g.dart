// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateModel _$CandidateFromJson(Map<String, dynamic> json) => CandidateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      experience: (json['experience'] as num).toInt(),
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CandidateToJson(CandidateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'experience': instance.experience,
      'skills': instance.skills,
    };

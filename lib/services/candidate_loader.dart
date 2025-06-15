import 'dart:convert';
import 'package:career_genie_bot/models/candidate_model.dart';
import 'package:flutter/services.dart';

class CandidateLoader {
  static Future<List<Candidate>> loadCandidates() async {
    final jsonString = await rootBundle.loadString('assets/candidates.json');
    final List<dynamic> data = json.decode(jsonString);
    return data.map((e) => Candidate.fromJson(e)).toList();
  }
}

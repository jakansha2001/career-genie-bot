import 'dart:convert';
import 'package:career_genie_bot/models/candidate_model.dart';
import 'package:flutter/services.dart';

class CandidateService {
  static Future<List<CandidateModel>> fetchLocalCandidates() async {
    final String response =
        await rootBundle.loadString('assets/candidates.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((e) => CandidateModel.fromJson(e)).toList();
  }
}

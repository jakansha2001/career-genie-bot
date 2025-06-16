import 'package:career_genie_bot/models/candidate_model.dart';
import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class CareerBot {
  final GenerativeModel _model;

  CareerBot(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-2.0-flash',
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 0.2, 
          ),
        );

  Future<List<CandidateModel>> findCandidates({
    required List<CandidateModel> candidates,
    required String prompt,
  }) async {
    final promptText = '''
You are an intelligent AI recruitment assistant. Based on the following natural language requirement:

"$prompt"

Evaluate the candidate list below and return the **top 5 best matches**. Use your judgment based on experience, location, and relevant skills.

If no suitable match is found, return exactly this string: **"No match found."**

Output strictly one of the following:
1. A JSON array of up to 5 matching candidates using this structure:
[
  {
    "id": "string",
    "name": "string",
    "location": "string",
    "experience": integer,
    "skills": ["string", "string"]
  }
]

2. The string: **"No match found."**

Here is the candidate list:
${jsonEncode(candidates.map((c) => c.toJson()).toList())}
''';

    try {
      final response = await _model.generateContent([Content.text(promptText)]);
      var text = response.text;

      if (text == null || text.isEmpty) {
        debugPrint('⚠️ Gemini returned no text.');
        return [];
      }

      // Strip unwanted Markdown formatting like ```json
      text = text.replaceAll(RegExp(r'```json|```'), '').trim();
      if (text == 'No match found.') {
        return [];
      }

      // Try to parse JSON only if it looks like a JSON array
      if (!text.startsWith('[')) {
        debugPrint('❌ Gemini responded with unexpected format: $text');
        return [];
      }

      final parsedJson = jsonDecode(text);

      // If Gemini returns a stringified JSON inside a string block
      if (parsedJson is String) {
        final nestedJson = jsonDecode(parsedJson);
        return (nestedJson as List).map((e) => CandidateModel.fromJson(e as Map<String, dynamic>)).toList();
      }

      return (parsedJson as List).map((e) => CandidateModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint('❌ Error in parsing Gemini response: $e');
      return [];
    }
  }
}

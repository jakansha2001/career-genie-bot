import 'package:career_genie_bot/bot/career_bot.dart';
import 'package:career_genie_bot/models/candidate_model.dart';
import 'package:career_genie_bot/services/candidate_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final _controller = TextEditingController();
  List<CandidateModel> _results = [];
  bool _loading = false;

  Future<void> _search() async {
    FocusScope.of(context).unfocus();
    final prompt = _controller.text.trim();

    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a requirement.')),
      );
      return;
    }
    setState(() => _loading = true);

    final candidates = await CandidateService.fetchLocalCandidates();
    final bot = CareerBot(dotenv.env['GEMINI_API_KEY']!);

    final matches = await bot.findCandidates(
      candidates: candidates,
      prompt: prompt,
    );

    setState(() {
      _results = matches;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Career Genie')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'e.g. Flutter dev, 3 yrs, Delhi, testing expert',
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(bottom: 6, left: 20),
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() => _results.clear());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : _search,
              child: const Text('Find Candidates'),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (!_loading && _results.isEmpty && _controller.text.isNotEmpty)
              const Text('No matching candidates found.'),
            if (!_loading)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (_, i) {
                    final c = _results[i];
                    return ListTile(
                      title: Text(c.name),
                      subtitle: Text(
                          '${c.experience} yrs | ${c.location} | ${c.skills.join(', ')}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

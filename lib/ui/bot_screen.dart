import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:career_genie_bot/bloc/candidate_bloc.dart';

class BotScreen extends StatelessWidget {
  BotScreen({super.key});

  final _controller = TextEditingController();

  void _search(BuildContext context) {
    FocusScope.of(context).unfocus();
    final prompt = _controller.text.trim();
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a requirement.')),
      );
      return;
    }
    context.read<CandidateBloc>().add(SearchCandidates(prompt));
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
                    context.read<CandidateBloc>().add(ClearResults());
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CandidateBloc, CandidateState>(
              builder: (context, state) {
                final loading = state is CandidateLoading;
                return ElevatedButton(
                  onPressed: loading ? null : () => _search(context),
                  child: const Text('Find Candidates'),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<CandidateBloc, CandidateState>(
              builder: (context, state) {
                if (state is CandidateLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CandidateNoMatch && _controller.text.isNotEmpty) {
                  return const Text('No matching candidates found.');
                } else if (state is CandidateLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.candidates.length,
                      itemBuilder: (_, i) {
                        final c = state.candidates[i];
                        return ListTile(
                          title: Text(c.name),
                          subtitle: Text('${c.experience} yrs | ${c.location} | ${c.skills.join(', ')}'),
                        );
                      },
                    ),
                  );
                } else if (state is CandidateError) {
                  return Text('Error: ${state.message}');
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

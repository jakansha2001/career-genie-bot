part of 'candidate_bloc.dart';

abstract class CandidateEvent {
  const CandidateEvent();
}

class SearchCandidates extends CandidateEvent {
  final String prompt;
  const SearchCandidates(this.prompt);
}

class ClearResults extends CandidateEvent {}

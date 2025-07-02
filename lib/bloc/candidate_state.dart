part of 'candidate_bloc.dart';

abstract class CandidateState extends Equatable {
  const CandidateState();
  @override
  List<Object?> get props => [];
}

class CandidateInitial extends CandidateState {}

class CandidateLoading extends CandidateState {}

class CandidateLoaded extends CandidateState {
  final List<CandidateModel> candidates;
  const CandidateLoaded(this.candidates);
  @override
  List<Object?> get props => [candidates];
}

class CandidateNoMatch extends CandidateState {}

class CandidateError extends CandidateState {
  final String message;
  const CandidateError(this.message);
  @override
  List<Object?> get props => [message];
}

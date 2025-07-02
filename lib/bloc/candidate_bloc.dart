import 'package:career_genie_bot/models/candidate_model.dart';
import 'package:career_genie_bot/services/candidate_service.dart';
import 'package:career_genie_bot/bot/career_bot.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'candidate_event.dart';
part 'candidate_state.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  CandidateBloc() : super(CandidateInitial()) {
    on<SearchCandidates>(_onSearchCandidates);
    on<ClearResults>((event, emit) => emit(CandidateInitial()));
  }

  Future<void> _onSearchCandidates(
    SearchCandidates event,
    Emitter<CandidateState> emit,
  ) async {
    emit(CandidateLoading());
    try {
      final candidates = await CandidateService.fetchLocalCandidates();
      final bot = CareerBot(dotenv.env['GEMINI_API_KEY']!);
      final matches = await bot.findCandidates(
        candidates: candidates,
        prompt: event.prompt,
      );
      if (matches.isEmpty) {
        emit(CandidateNoMatch());
      } else {
        emit(CandidateLoaded(matches));
      }
    } catch (e) {
      emit(CandidateError(e.toString()));
    }
  }
}

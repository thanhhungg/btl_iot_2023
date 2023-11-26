import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/history_in_out_repo.dart';
part 'history_in_out_state.dart';
class HistoryInOutCubit extends Cubit<HistoryInOutState> {
  HistoryInOutCubit() : super(HistoryInOutInitial());
  final HistoryInOutRepo _historyInOutRepo = HistoryInOutRepo();
  Future<void> getHistoryInOut() async {
    emit(HistoryInOutLoading());

    try {
      final data = await _historyInOutRepo.getHistoryInOut();
      emit(HistoryInOutSuccess(data: data));
    } catch (e) {


      emit(HistoryInOutFailure(error: e.toString()));
    }
  }
}

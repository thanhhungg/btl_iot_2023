part of 'history_in_out_cubit.dart';
class HistoryInOutState extends Equatable {
  const HistoryInOutState();
  @override
  List<Object> get props => [];
}
class HistoryInOutInitial extends HistoryInOutState {}
class HistoryInOutLoading extends HistoryInOutState {}
class HistoryInOutSuccess extends HistoryInOutState {
  final List<dynamic> data;
  HistoryInOutSuccess({required this.data});
  @override
  List<Object> get props => [data];
}
class HistoryInOutFailure extends HistoryInOutState {
  final String error;
  HistoryInOutFailure({required this.error});
  @override
  List<Object> get props => [error];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadProgressBarBloc
    extends Bloc<LoadProgressBarEvent, LoadProgressBarState> {
  LoadProgressBarBloc() : super(LoadProgressInitial()) {
    on<UserAndNetworkCheck>(_userAndNetworkCheck);
    on<ReportsListLoaded>(_reportsListLoaded);
    on<ReportCached>(_reportCached);
    on<ImageCached>(_imageCached);
  }

  double loadProgressPercent = 0.0;

  void _userAndNetworkCheck(
      UserAndNetworkCheck event, Emitter<LoadProgressBarState> emit) {
    loadProgressPercent = 0.1;
    emit(LoadProgressUpdated(loadProgressPercent: loadProgressPercent));
  }

  void _reportsListLoaded(
      ReportsListLoaded event, Emitter<LoadProgressBarState> emit) {
    loadProgressPercent = 0.15;
    emit(LoadProgressUpdated(loadProgressPercent: loadProgressPercent));
  }

  void _reportCached(ReportCached event, Emitter<LoadProgressBarState> emit) {
    final int listLength = event.listLength;
    final int listIndex = event.listIndex;
    final double percent = 0.8 / listLength * listIndex;
    loadProgressPercent = 0.1 + percent;
    emit(LoadProgressUpdated(loadProgressPercent: loadProgressPercent));
  }

  void _imageCached(ImageCached event, Emitter<LoadProgressBarState> emit) {
    loadProgressPercent = event.i;
    emit(LoadProgressUpdated(loadProgressPercent: loadProgressPercent));
  }
}

//
// Events
//

abstract class LoadProgressBarEvent extends Equatable {
  const LoadProgressBarEvent();
  @override
  List<Object> get props => [];
}

class UserAndNetworkCheck extends LoadProgressBarEvent {}

class ReportsListLoaded extends LoadProgressBarEvent {}

class ReportCached extends LoadProgressBarEvent {
  final int listLength;
  final int listIndex;

  const ReportCached({required this.listLength, required this.listIndex});
}

class ImageCached extends LoadProgressBarEvent {
  final double i;
  const ImageCached({required this.i});

  @override
  List<Object> get props => [i];
}

//
// States
//

abstract class LoadProgressBarState extends Equatable {
  const LoadProgressBarState();

  @override
  List<Object> get props => [];
}

class LoadProgressInitial extends LoadProgressBarState {}

class LoadProgressUpdated extends LoadProgressBarState {
  const LoadProgressUpdated({
    required this.loadProgressPercent,
  });

  final double loadProgressPercent;

  @override
  List<Object> get props => [loadProgressPercent];
}

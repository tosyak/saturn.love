import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(const MainScreenInitial(0)) {
    on<SetTabIndex>(_setTabIndex);
  }

  void _setTabIndex(SetTabIndex event, Emitter<MainScreenState> emit) {
    emit(MainScreenTabIndex(event.index));
  }
}

//
// Events
//

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class SetTabIndex extends MainScreenEvent {
  final int index;
  const SetTabIndex(this.index);

  @override
  List<Object> get props => [index];
}

//
// States
//

abstract class MainScreenState extends Equatable {
  final int tabIndex;
  const MainScreenState(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class MainScreenInitial extends MainScreenState {
  const MainScreenInitial(int tabIndex) : super(tabIndex);
}

class MainScreenTabIndex extends MainScreenState {
  const MainScreenTabIndex(int tabIndex) : super(tabIndex);
}

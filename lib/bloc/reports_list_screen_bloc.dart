// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saturn/data/models/reports_list_model.dart';
import 'package:saturn/data/repository/api_repository.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class ReportsListBloc extends Bloc<ReportsListEvent, ReportsListState> {
  ReportsListBloc({
    required this.deleteReportRepository,
    required this.editFavoriteRepository,
  }) : super(ReportsListInitial()) {
    on<GetReportsList>(_makeList);
    on<FilterReportsList>(_filterSearchResults);
    on<FilterReportsListByFavorites>(_filterByFavorites);
    on<FilterReportsListByGroup>(_filterByGroup);
    on<DeleteReportsListItem>(_deleteReport);
    on<EditReportsListItem>(_editUserData);
    on<ResetState>(_resetState);
  }

  final DeleteReportRepository deleteReportRepository;
  final EditFavoriteRepository editFavoriteRepository;

  static final List<ReportsListItemModel> _listOfReports = [];
  List<String> categoryList = [];
  List<bool> favoritesList = [];
  List<ReportsListItemModel> filteredListOfReports = [];
  List<ReportsListItemModel> get listOfReports => _listOfReports;

  void _resetState(ResetState event, Emitter<ReportsListState> emit) {
    emit(ReportsListInitial());
  }

  _makeList(GetReportsList event, Emitter<ReportsListState> emit) async {
    _listOfReports.clear();
    final ReportsListModel model =
        await ReportsListHiveBox().getReportsListHive();
    for (var element in model.reports) {
      _listOfReports.add(element);
    }
    add(const FilterReportsList(query: ''));
  }

  _filterSearchResults(
      FilterReportsList event, Emitter<ReportsListState> emit) {
    if (event.query.isNotEmpty) {
      filteredListOfReports = _listOfReports
          .where((item) =>
              item.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
    } else {
      filteredListOfReports = _listOfReports;
    }
    favoritesList.clear();
    categoryList.clear();
    for (var element in filteredListOfReports) {
      element.favorite == '0'
          ? favoritesList.add(false)
          : favoritesList.add(true);
      categoryList.add(element.groups);
    }
    emit(ReportsListLoaded(
        filteredListOfReports: filteredListOfReports,
        favoritesList: favoritesList,
        categoryList: categoryList));
  }

  _filterByGroup(
      FilterReportsListByGroup event, Emitter<ReportsListState> emit) {
    if (event.groupIndex.isNotEmpty) {
      filteredListOfReports = _listOfReports
          .where((item) => item.groups.contains(event.groupIndex))
          .toList();
    } else {
      filteredListOfReports = _listOfReports;
    }
    favoritesList.clear();
    categoryList.clear();
    for (var element in filteredListOfReports) {
      element.favorite == '0'
          ? favoritesList.add(false)
          : favoritesList.add(true);
      categoryList.add(element.groups);
    }
    emit(ReportsListLoaded(
        filteredListOfReports: filteredListOfReports,
        favoritesList: favoritesList,
        categoryList: categoryList));
  }

  _filterByFavorites(
      FilterReportsListByFavorites event, Emitter<ReportsListState> emit) {
    if (event.groupIndex.isNotEmpty) {
      filteredListOfReports = _listOfReports
          .where((item) => item.favorite.contains(event.groupIndex))
          .toList();
    } else {
      filteredListOfReports = _listOfReports;
    }
    favoritesList.clear();
    categoryList.clear();
    for (var element in filteredListOfReports) {
      element.favorite == '0'
          ? favoritesList.add(false)
          : favoritesList.add(true);
      categoryList.add(element.groups);
    }
    emit(ReportsListLoaded(
        filteredListOfReports: filteredListOfReports,
        favoritesList: favoritesList,
        categoryList: categoryList));
  }

  _deleteReport(
      DeleteReportsListItem event, Emitter<ReportsListState> emit) async {
    final Map<String, dynamic> listResponse =
        await deleteReportRepository.deleteReportRequest(event.reportIndex);

    switch (listResponse['status']) {
      case 'OK':
        emit(ReportsListItemDeleted());
        ReportHiveBox().deleteReportHive(event.reportIndex);
        break;
      case 'USERME':
        logger.i('delete user me error');
        break;
      case 'ERRORUSER':
        logger.e('delete user error');
        break;
      default:
    }
  }

  _editUserData(
      EditReportsListItem event, Emitter<ReportsListState> emit) async {
    final int? userId = await UserSharedPreferences().getUserId();
    final response = await editFavoriteRepository.editUserDataRequest(
      userId: userId!,
      reportId: event.reportId,
      favorite: event.favorite,
      groups: event.groups,
    );

    switch (response['status']) {
      case 'OK':
        emit(ReportsListItemEdited(reportId: event.reportId));
        emit(ReportsListLoaded(
            filteredListOfReports: filteredListOfReports,
            favoritesList: favoritesList,
            categoryList: categoryList));
        break;
      case 'USERME':
        logger.i('case userme');
        break;
      case 'ERRORUSER':
        logger.e('case erroruser');
        break;
      default:
    }
  }
}

//
// Event
//

abstract class ReportsListEvent extends Equatable {
  const ReportsListEvent();

  @override
  List<Object?> get props => [];
}

class GetReportsList extends ReportsListEvent {}

class FilterReportsList extends ReportsListEvent {
  final String query;
  const FilterReportsList({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterReportsListByGroup extends ReportsListEvent {
  final String groupIndex;
  const FilterReportsListByGroup({required this.groupIndex});

  @override
  List<Object> get props => [groupIndex];
}

class FilterReportsListByFavorites extends ReportsListEvent {
  final String groupIndex;
  const FilterReportsListByFavorites({required this.groupIndex});

  @override
  List<Object> get props => [groupIndex];
}

class DeleteReportsListItem extends ReportsListEvent {
  final int reportIndex;
  final int listIndex;
  const DeleteReportsListItem(
      {required this.reportIndex, required this.listIndex});

  @override
  List<Object> get props => [reportIndex, listIndex];
}

class EditReportsListItem extends ReportsListEvent {
  final int reportId;
  final String? favorite;
  final String? groups;
  const EditReportsListItem(
      {required this.reportId, this.favorite, this.groups});

  @override
  List<Object?> get props => [reportId, favorite, groups];
}

class ResetState extends ReportsListEvent {}

//
// States
//

class ReportsListState extends Equatable {
  const ReportsListState();

  @override
  List<Object> get props => [];
}

class ReportsListInitial extends ReportsListState {}

class ReportsListLoaded extends ReportsListState {
  const ReportsListLoaded(
      {required this.filteredListOfReports,
      required this.favoritesList,
      required this.categoryList});

  final List<String> categoryList;
  final List<bool> favoritesList;
  final List<ReportsListItemModel> filteredListOfReports;

  @override
  List<Object> get props =>
      [filteredListOfReports, favoritesList, categoryList];
}

class ReportsListItemDeleted extends ReportsListState {
  @override
  List<Object> get props => [];
}

class ReportsListItemEdited extends ReportsListState {
  final int reportId;
  const ReportsListItemEdited({required this.reportId});
  @override
  List<Object> get props => [reportId];
}



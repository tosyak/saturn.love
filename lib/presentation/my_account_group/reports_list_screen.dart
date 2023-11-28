// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:saturn/bloc/main_screen_bloc.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/cache_manager.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/bloc/edit_user_data_bloc.dart';
import 'package:saturn/bloc/moon_screen_bloc.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';
import 'package:saturn/bloc/reports_list_screen_bloc.dart';
import 'package:saturn/bloc/transits_screen_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.reports;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(title, maxLines: 4),
      ),
      bottomNavigationBar: null,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReportScreenBloc, ReportScreenState>(
            listener: (context, state) {
              if (state is ReportScreenReportLoaded) {
                context.goNamed(AppPage.reportScreen.toName);
              }
            },
          ),
          BlocListener<ReportsListBloc, ReportsListState>(
            listener: (context, state) {
              if (state is ReportsListItemDeleted) {
                BlocProvider.of<CacheManagerCubit>(context).cacheReportsList();
              }
            },
          ),
          BlocListener<CacheManagerCubit, CacheManagerState>(
            listener: (context, state) {
              if (state is CacheManagerReportsListCached) {
                BlocProvider.of<ReportsListBloc>(context).add(GetReportsList());
                BlocProvider.of<CacheManagerCubit>(context).resetState();
                BlocProvider.of<ReportsListBloc>(context).add(ResetState());
              }
            },
          ),
          BlocListener<EditUserBloc, EditUserState>(
            listener: (context, state) {
              context.goNamed(AppPage.userInputData.toName);
            },
          ),
        ],
        child: BlocBuilder<ReportsListBloc, ReportsListState>(
          builder: (context, state) {
            return Container(
              width: screenWidth,
              height: screenHeight,
              padding: ConstantSize.screenPadding,
              child: Column(
                children: [
                  _ReportsFilter(),
                  const SizedBox(height: 24),
                  const _ReportsSearch(),
                  gapH20,
                  state is ReportsListLoaded == false
                      ? const CircularProgressIndicator()
                      : const Expanded(
                          child: _ReportsItemBuilder(),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ReportsFilter extends StatefulWidget {
  @override
  _ReportsFilterState createState() => _ReportsFilterState();
}

class _ReportsFilterState extends State<_ReportsFilter> {
  double buttonsHeight = 32;

  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenSize(context).width;
    return SizedBox(
      width: screenWidth,
      height: buttonsHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 0
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            child: Text(
              AppLocalizations.of(context)!.all,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsList(query: ''));
              setState(() {
                _selectedButtonIndex = 0;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.favorite,
              color: Colors.grey,
              size: 24.0,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 1
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            label: Text(
              AppLocalizations.of(context)!.favorite,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsListByFavorites(groupIndex: '1'));
              setState(() {
                _selectedButtonIndex = 1;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 2
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            child: Text(
              AppLocalizations.of(context)!.me,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsListByGroup(groupIndex: '1'));

              setState(() {
                _selectedButtonIndex = 2;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 3
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            child: Text(
              AppLocalizations.of(context)!.family,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsListByGroup(groupIndex: '2'));

              setState(() {
                _selectedButtonIndex = 3;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 4
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            child: Text(
              AppLocalizations.of(context)!.work,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsListByGroup(groupIndex: '3'));
              setState(() {
                _selectedButtonIndex = 4;
              });
            },
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(20, buttonsHeight),
              backgroundColor: _selectedButtonIndex == 5
                  ? AppColors.beige
                  : AppColors.beige50,
            ),
            child: Text(
              AppLocalizations.of(context)!.friends,
              style: AppTextStyle.arsenal14Light,
            ),
            onPressed: () {
              BlocProvider.of<ReportsListBloc>(context)
                  .add(const FilterReportsListByGroup(groupIndex: '4'));
              setState(() {
                _selectedButtonIndex = 5;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _ReportsSearch extends StatelessWidget {
  const _ReportsSearch();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        onChanged: (value) {
          BlocProvider.of<ReportsListBloc>(context)
              .add(FilterReportsList(query: value));
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class _ReportsItemBuilder extends StatefulWidget {
  const _ReportsItemBuilder({
    Key? key,
  }) : super(key: key);

  final double buttonHeight = 37;

  @override
  State<_ReportsItemBuilder> createState() => _ReportsItemBuilderState();
}

class _ReportsItemBuilderState extends State<_ReportsItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsListBloc, ReportsListState>(
      builder: (context, state) {
        if (state is ReportsListLoaded) {
          return ListView.builder(
            itemCount: state.filteredListOfReports.length,
            itemBuilder: (context, index) {
              return ReportCardWidget(
                index: index,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ReportCardWidget extends StatefulWidget {
  ReportCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final double buttonHeight = 37;
  bool categoryIsVisible = false;
  final int index;

  @override
  State<ReportCardWidget> createState() => _ReportCardWidgetState();
}

class _ReportCardWidgetState extends State<ReportCardWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;

    return BlocBuilder<ReportsListBloc, ReportsListState>(
      builder: (context, state) {
        if (state is ReportsListLoaded) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.name,
                    style: AppTextStyle.arsenal14Light,
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.dateOfBirth,
                    style: AppTextStyle.arsenal14Light,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          (widget.index + 1).toString(),
                          style: AppTextStyle.arsenal16LightBold,
                        ),
                        const Text(
                          '. ',
                          style: AppTextStyle.arsenal16LightBold,
                        ),
                        Flexible(
                          child: Text(
                            state.filteredListOfReports[widget.index].title,
                            style: AppTextStyle.arsenal16LightBold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        gapW12,
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              widget.categoryIsVisible =
                                  !widget.categoryIsVisible;
                            });
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.beige,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat("dd.MM.yy")
                        .format(state.filteredListOfReports[widget.index].datar)
                        .toString(),
                    style: AppTextStyle.arsenal16LightBold,
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height:
                    widget.categoryIsVisible ? widget.buttonHeight + 24 : 0.0,
                child: Visibility(
                  visible: widget.categoryIsVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
                    child: _CategoryWidget(index: widget.index),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(20, widget.buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<ReportScreenBloc>(context).add(
                            GetReportItem(int.parse(
                                state.filteredListOfReports[widget.index].id)));

                        BlocProvider.of<MainScreenBloc>(context)
                            .add(const SetTabIndex(0));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.open,
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: widget.buttonHeight,
                    color: AppColors.light,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(20, widget.buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        bool networkIsConnected =
                            await InternetConnectionChecker().hasConnection;
                        if (!networkIsConnected) {
                          showSnackBarWidget(
                              AppLocalizations.of(context)!.checkNetwork,
                              context);
                        } else {
                          BlocProvider.of<EditUserBloc>(context).add(
                              EditUserLoadReport(
                                  index: int.parse(state
                                      .filteredListOfReports[widget.index]
                                      .id)));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: widget.buttonHeight,
                    color: AppColors.light,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(20, widget.buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                      ),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: AppColors.dark,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          content: Text(
                            AppLocalizations.of(context)!.deleteReport,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppLocalizations.of(context)!.no),
                            ),
                            TextButton(
                              onPressed: () async {
                                BlocProvider.of<ReportsListBloc>(context).add(
                                    DeleteReportsListItem(
                                        reportIndex: int.parse(state
                                            .filteredListOfReports[widget.index]
                                            .id),
                                        listIndex: widget.index));

                                Navigator.pop(context);
                              },
                              child: Text(AppLocalizations.of(context)!.yes),
                            ),
                          ],
                        ),
                      ),
                      child: AutoSizeText(
                        AppLocalizations.of(context)!.delete,
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(20, widget.buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<ReportScreenBloc>(context).add(
                            LoadReportItem(int.parse(
                                state.filteredListOfReports[widget.index].id)));

                        BlocProvider.of<TransiteBloc>(context).add(
                            FetchTransite(
                                reportIndex: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                date: DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(DateTime.now())));

                        BlocProvider.of<MainScreenBloc>(context)
                            .add(const SetTabIndex(1));

                        context.goNamed(AppPage.transits.toName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.transits,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: widget.buttonHeight,
                    color: AppColors.light,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(20, widget.buttonHeight),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                            reportIndex: int.parse(
                                state.filteredListOfReports[widget.index].id),
                            date: DateFormat('yyyy-MM-dd hh:mm:ss')
                                .format(DateTime.now())));

                        BlocProvider.of<ReportScreenBloc>(context).add(
                            LoadReportItem(int.parse(
                                state.filteredListOfReports[widget.index].id)));

                        BlocProvider.of<MainScreenBloc>(context)
                            .add(const SetTabIndex(2));

                        context.goNamed(AppPage.lunarCalendar.toName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.calendar,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _CategoryWidget extends StatefulWidget {
  const _CategoryWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final double buttonHeight = 37;
  final int index;

  @override
  State<_CategoryWidget> createState() => __CategoryWidgetState();
}

class __CategoryWidgetState extends State<_CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;

    return BlocListener<ReportsListBloc, ReportsListState>(
      listener: (context, state) {
        if (state is ReportsListItemEdited) {
          BlocProvider.of<CacheManagerCubit>(context).cacheReportsList();
          BlocProvider.of<CacheManagerCubit>(context)
              .cacheReportItem(state.reportId);
        }
      },
      child: BlocBuilder<ReportsListBloc, ReportsListState>(
        builder: (context, state) {
          if (state is ReportsListLoaded) {
            final isInCategory = state.categoryList[widget.index];
            final isFavorite = state.favoritesList[widget.index];

            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 60,
                    height: widget.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          side: BorderSide(color: AppColors.beige, width: 1.0),
                        ),
                        backgroundColor: AppColors.beige10,
                      ),
                      onPressed: () async {
                        BlocProvider.of<ReportsListBloc>(context).add(
                            EditReportsListItem(
                                reportId: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                favorite: isFavorite ? '0' : '1'));
                      },
                      child: isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: AppColors.beige,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color: AppColors.beige,
                            ),
                      // child: const AutoSizeText(
                      //   'Избранное',
                      //   maxLines: 1,
                      //   // AppLocalizations.of(context)!.open,
                      //   // style: AppTextStyle.arsenal14Light,
                      // ),
                    ),
                  ),
                ),
                Container(
                  width: 0.4,
                  height: widget.buttonHeight,
                  color: AppColors.beige,
                ),
                Expanded(
                  child: SizedBox(
                    width: 60,
                    height: widget.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                          side: BorderSide(color: AppColors.beige, width: 1.0),
                        ),
                        backgroundColor: isInCategory == '1'
                            ? AppColors.beige
                            : AppColors.beige10,
                      ),
                      onPressed: () async {
                        BlocProvider.of<ReportsListBloc>(context).add(
                            EditReportsListItem(
                                reportId: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                groups: isInCategory != '1' ? '1' : '0'));
                      },
                      child: Text(
                        'Я',
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.4,
                  height: widget.buttonHeight,
                  color: AppColors.beige,
                ),
                Expanded(
                  child: SizedBox(
                    height: widget.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                          side: BorderSide(color: AppColors.beige, width: 1.0),
                        ),
                        backgroundColor: isInCategory == '2'
                            ? AppColors.beige
                            : AppColors.beige10,
                      ),
                      onPressed: () async {
                        BlocProvider.of<ReportsListBloc>(context).add(
                            EditReportsListItem(
                                reportId: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                groups: isInCategory != '2' ? '2' : '0'));
                        // checkStatus();
                      },
                      child: Text(
                        'Семья',
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.4,
                  height: widget.buttonHeight,
                  color: AppColors.beige,
                ),
                Expanded(
                  child: SizedBox(
                    height: widget.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                          side: BorderSide(color: AppColors.beige, width: 1.0),
                        ),
                        backgroundColor: isInCategory == '3'
                            ? AppColors.beige
                            : AppColors.beige10,
                      ),
                      onPressed: () async {
                        BlocProvider.of<ReportsListBloc>(context).add(
                            EditReportsListItem(
                                reportId: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                groups: isInCategory != '3' ? '3' : '0'));
                        // checkStatus();
                      },
                      child: Text(
                        'Работа',
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.4,
                  height: widget.buttonHeight,
                  color: AppColors.beige,
                ),
                Expanded(
                  child: SizedBox(
                    height: widget.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          side: BorderSide(color: AppColors.beige, width: 1.0),
                        ),
                        backgroundColor: isInCategory == '4'
                            ? AppColors.beige
                            : AppColors.beige10,
                      ),
                      onPressed: () async {
                        BlocProvider.of<ReportsListBloc>(context).add(
                            EditReportsListItem(
                                reportId: int.parse(state
                                    .filteredListOfReports[widget.index].id),
                                groups: isInCategory != '4' ? '4' : '0'));
                        // checkStatus();
                      },
                      child: Text(
                        'Друзья',
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth < 400 ? 12 : 16),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// class DeleteDialogWidget extends StatelessWidget {
//   const DeleteDialogWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

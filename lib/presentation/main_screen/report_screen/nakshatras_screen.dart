// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class DegreesAndNakshatrasScreen extends StatefulWidget {
  const DegreesAndNakshatrasScreen({super.key});

  @override
  State<DegreesAndNakshatrasScreen> createState() =>
      _DegreesAndNakshatrasScreenState();
}

class _DegreesAndNakshatrasScreenState
    extends State<DegreesAndNakshatrasScreen> {
  bool planetsIsActive = true;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.degreesNakshatras;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
        appBar: AppBar(
          leadingWidth: appBarLeadingWidth,
          toolbarHeight: appBarHeight.calculateLeadingAndActionsHeight(),
          title: Text(title, maxLines: 4),
          actions: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 4),
                child: IconButton(
                  icon: const ImageIcon(
                    AssetImage('assets/images/account_icon.png'),
                    size: 20,
                  ),
                  onPressed: () {
                    context.pushNamed(AppPage.myAccount.toName);
                  },
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ReportScreenBloc, ReportScreenState>(
            builder: (context, state) {
          if (state is ReportScreenReportLoaded) {
            return Container(
              width: screenWidth,
              height: screenHeight,
              padding: ConstantSize.screenPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: AppTextStyle.arsenal14Light,
                            backgroundColor: planetsIsActive
                                ? AppColors.beige
                                : AppColors.beige50),
                        onPressed: () {
                          setState(() {
                            planetsIsActive = !planetsIsActive;
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.planets),
                      ),
                    ),
                    gapH8,
                    state.reportItem.source?.timelite != '0'
                        ? SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: AppTextStyle.arsenal14Light,
                                  backgroundColor: planetsIsActive
                                      ? AppColors.beige50
                                      : AppColors.beige),
                              onPressed: () {
                                setState(() {
                                  planetsIsActive = !planetsIsActive;
                                });
                              },
                              child: Text(AppLocalizations.of(context)!.houses),
                            ),
                          )
                        : const SizedBox.shrink(),
                    // _ButtonsWidget(),
                    gapH16,
                    state.reportItem.source?.timelite != '0'
                        ? planetsIsActive
                            ? _PlanetsWidget(
                                key: UniqueKey(),
                              )
                            : _HomesWidget(key: UniqueKey())
                        : _NoDataPlanetsWidget(),

                    // _HousesWidget(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return Container();
        }));
  }
}

// class _ButtonsWidget extends StatefulWidget {
//   const _ButtonsWidget({super.key});

//   @override
//   State<_ButtonsWidget> createState() => __ButtonsWidgetState();
// }

// class __ButtonsWidgetState extends State<_ButtonsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 38,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 textStyle: AppTextStyle.arsenal14Light),
//             onPressed: () {},
//             child: Text(AppLocalizations.of(context)!.planets),
//           ),
//         ),
//         gapH8,
//         SizedBox(
//           height: 38,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 textStyle: AppTextStyle.arsenal14Light),
//             onPressed: () {},
//             child: Text(AppLocalizations.of(context)!.houses),
//           ),
//         ),
//       ],
//     );
//   }
// }

const double _planetColumn = 110;
const double _degreeColumn = 100;
const double _signColumn = 80;
const double _nakshartaColumn = 70;
const double _houseColumn = 50;
const double _relationColumn = 140;

const double _colPadding = 20;

class _PlanetsWidget extends StatelessWidget {
  _PlanetsWidget({super.key});

  ScrollController scrollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final model = state.reportItem.table;
        return Scrollbar(
          controller: scrollBarController,
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(20),
          scrollbarOrientation: ScrollbarOrientation.top,
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SingleChildScrollView(
              controller: scrollBarController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _planetColumn,
                        child: Text(
                          model?.planets?.head?['1'] ?? "",
                          style: AppTextStyle.arsenal12Light,
                        ),
                      ),
                      SizedBox(
                        width: _degreeColumn,
                        child: Text(model?.planets?.head?['2'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      SizedBox(
                        width: _signColumn,
                        child: Text(model?.planets?.head?['3'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _nakshartaColumn,
                        child: Text(model?.planets?.head?['4'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _houseColumn,
                        child: Text(model?.planets?.head?['5'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      SizedBox(
                        width: _relationColumn,
                        child: Text(model?.planets?.head?['6'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                    ],
                  ),
                  gapH16,
                  const _PlanetsRowBuilder(),
                  gapH16,
                  // const _PlanetsRowBuilder(),
                  // gapH16,
                  // const _PlanetsRowBuilder(),
                  // gapH16,
                  // const _PlanetsRowBuilder(),
                ],
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }
}

class _PlanetsRowBuilder extends StatefulWidget {
  const _PlanetsRowBuilder();

  @override
  State<_PlanetsRowBuilder> createState() => __PlanetsRowBuilderState();
}

class __PlanetsRowBuilderState extends State<_PlanetsRowBuilder> {
  bool containerIsOpen = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        List<Widget> list = [];
        final model = state.reportItem.table?.planets?.content;
        if (model != null) {
          for (var element in model) {
            final item = Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _planetColumn,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            // style: TextButton.styleFrom(
                            //     alignment: Alignment.topLeft,
                            //     padding: EdgeInsets.all(0)),
                            // onPressed: () {},
                            onTap: () {
                              // setState(() {
                              //   containerIsOpen = !containerIsOpen;
                              // });
                            },
                            child: containerIsOpen
                                ? RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: element['1'],
                                          style: AppTextStyle.arsenal14Light,
                                        ),
                                        const WidgetSpan(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(Icons.arrow_upward,
                                                size: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: element['1'],
                                          style: AppTextStyle.arsenal14Light,
                                        ),
                                        const WidgetSpan(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(Icons.arrow_downward,
                                                size: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: _degreeColumn,
                        child: Text(
                          element['2'],
                          style: AppTextStyle.arsenal14Light,
                        ),
                      ),
                      SizedBox(
                        width: _signColumn,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element['3'],
                              style: AppTextStyle.arsenal14Light,
                            ),
                            // Text(
                            //   '45\'',
                            //   style: AppTextStyle.arsenal14Light,
                            // ),
                            // Text(
                            //   '24"',
                            //   style: AppTextStyle.arsenal14Light,
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _nakshartaColumn,
                        child: Text(
                          element['4'],
                          style: AppTextStyle.arsenal14Light,
                        ),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _houseColumn,
                        child: Text(
                          element['5'].toString(),
                          style: AppTextStyle.arsenal14Light,
                        ),
                      ),
                      SizedBox(
                        width: _relationColumn,
                        child: Text(
                          element['6'],
                          style: AppTextStyle.arsenal14Light,
                        ),
                      ),
                    ],
                  ),
                  containerIsOpen
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.beige50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Время нахождения в знаке ',
                                style: AppTextStyle.arsenal14Light,
                              ),
                              gapH4,
                              Container(
                                height: 2,
                                width: _planetColumn +
                                    _degreeColumn +
                                    _signColumn +
                                    _nakshartaColumn +
                                    _houseColumn +
                                    _relationColumn -
                                    40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                ),
                              ),
                              gapH4,
                              const Text(
                                'Время начала: 00 Июль 1997 - 00:00 (00д 00ч 00мин). Был: близнецы',
                                style: AppTextStyle.arsenal12Light,
                              ),
                              const Text(
                                'Время завершения: 00 Август 1997 - 00:00 (00д 00ч 00мин). Будет: лев',
                                style: AppTextStyle.arsenal12Light,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
            list.add(item);
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        );
      }
      return Container();
    });
  }
}

class _NoDataPlanetsWidget extends StatelessWidget {
  _NoDataPlanetsWidget();

  ScrollController scrollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        final model = state.reportItem.table;
        return Scrollbar(
          controller: scrollBarController,
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(20),
          scrollbarOrientation: ScrollbarOrientation.top,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              controller: scrollBarController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _planetColumn,
                        child: Text(
                          model?.planets?.head?['1'] ?? "",
                          style: AppTextStyle.arsenal12Light,
                        ),
                      ),
                      SizedBox(
                        width: _signColumn,
                        child: Text(model?.planets?.head?['3'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _nakshartaColumn,
                        child: Text(model?.planets?.head?['4'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                      const SizedBox(width: _colPadding),
                      SizedBox(
                        width: _relationColumn,
                        child: Text(model?.planets?.head?['6'] ?? "",
                            style: AppTextStyle.arsenal12Light),
                      ),
                    ],
                  ),
                  gapH16,
                  const _NoDataPlanetsRowBuilder(),
                  gapH16,
                ],
              ),
            ),
          ),
        );
      }
      return Container(
          // child: const Text('123123123'),
          );
    });
  }
}

class _NoDataPlanetsRowBuilder extends StatefulWidget {
  const _NoDataPlanetsRowBuilder();

  @override
  State<_NoDataPlanetsRowBuilder> createState() =>
      __NoDataPlanetsRowBuilderState();
}

class __NoDataPlanetsRowBuilderState extends State<_NoDataPlanetsRowBuilder> {
  bool containerIsOpen = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        List<Widget> list = [];
        final Map<String, dynamic> model =
            state.reportItem.table?.planets?.content;
        // final childList = model.reportItem?.homePlanets.child;
        model.forEach((key, value) {
          final item = Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _planetColumn,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          // style: TextButton.styleFrom(
                          //     alignment: Alignment.topLeft,
                          //     padding: EdgeInsets.all(0)),
                          // onPressed: () {},
                          onTap: () {
                            // setState(() {
                            //   containerIsOpen = !containerIsOpen;
                            // });
                          },
                          child: containerIsOpen
                              ? RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: key[1],
                                        style: AppTextStyle.arsenal14Light,
                                      ),
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.arrow_upward,
                                              size: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: value['1'],
                                        style: AppTextStyle.arsenal14Light,
                                      ),
                                      const WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.arrow_downward,
                                              size: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _signColumn,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value['3'],
                            style: AppTextStyle.arsenal14Light,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: _colPadding),
                    SizedBox(
                      width: _nakshartaColumn,
                      child: Text(
                        value['4'],
                        style: AppTextStyle.arsenal14Light,
                      ),
                    ),
                    const SizedBox(width: _colPadding),
                    SizedBox(
                      width: _relationColumn,
                      child: Text(
                        value['6'],
                        style: AppTextStyle.arsenal14Light,
                      ),
                    ),
                  ],
                ),
                containerIsOpen
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.beige50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Время нахождения в знаке ',
                              style: AppTextStyle.arsenal14Light,
                            ),
                            gapH4,
                            Container(
                              height: 2,
                              width: _planetColumn +
                                  _degreeColumn +
                                  _signColumn +
                                  _nakshartaColumn +
                                  _houseColumn +
                                  _relationColumn -
                                  40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                              ),
                            ),
                            gapH4,
                            const Text(
                              'Время начала: 00 Июль 1997 - 00:00 (00д 00ч 00мин). Был: близнецы',
                              style: AppTextStyle.arsenal12Light,
                            ),
                            const Text(
                              'Время завершения: 00 Август 1997 - 00:00 (00д 00ч 00мин). Будет: лев',
                              style: AppTextStyle.arsenal12Light,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
          list.add(item);
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        );
      }
      return Container();
    });
  }
}

class _HomesWidget extends StatelessWidget {
  const _HomesWidget({super.key});

  final rowSpacer = const TableRow(children: [
    SizedBox(height: 8),
    SizedBox(height: 8),
    SizedBox(height: 8),
    SizedBox(height: 8)
  ]);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollBarController = ScrollController();

    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        List<Widget> list = [];
        final model = state.reportItem.table?.homes;

        makeRow(int index) {
          list = [
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text((index + 1).toString(),
                        style: AppTextStyle.arsenal14Light)
                  ]),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(model?.content?[index]['2'] ?? '',
                  style: AppTextStyle.arsenal14Light)
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(model?.content?[index]['3'] ?? '',
                  style: AppTextStyle.arsenal14Light)
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(model?.content?[index]['4'] ?? '',
                  style: AppTextStyle.arsenal14Light)
            ]),
          ];

          return list;
        }

        return Scrollbar(
          controller: scrollBarController,
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(20),
          scrollbarOrientation: ScrollbarOrientation.top,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
              controller: scrollBarController,
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                columnWidths: const {
                  0: FixedColumnWidth(40.0),
                  1: FixedColumnWidth(120.0),
                  2: FixedColumnWidth(130.0),
                  3: FixedColumnWidth(140.0),
                },
                children: [
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model?.head?['1'] ?? '',
                              style: AppTextStyle.arsenal12Light)
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model?.head?['2'] ?? '',
                              style: AppTextStyle.arsenal12Light)
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model?.head?['3'] ?? '',
                              style: AppTextStyle.arsenal12Light)
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model?.head?['4'] ?? '',
                              style: AppTextStyle.arsenal12Light)
                        ]),
                  ]),
                  rowSpacer,
                  TableRow(children: makeRow(0)),
                  rowSpacer,
                  TableRow(children: makeRow(1)),
                  rowSpacer,
                  TableRow(children: makeRow(2)),
                  rowSpacer,
                  TableRow(children: makeRow(3)),
                  rowSpacer,
                  TableRow(children: makeRow(4)),
                  rowSpacer,
                  TableRow(children: makeRow(5)),
                  rowSpacer,
                  TableRow(children: makeRow(6)),
                  rowSpacer,
                  TableRow(children: makeRow(7)),
                  rowSpacer,
                  TableRow(children: makeRow(8)),
                  rowSpacer,
                  TableRow(children: makeRow(9)),
                  rowSpacer,
                  TableRow(children: makeRow(10)),
                  rowSpacer,
                  TableRow(children: makeRow(11)),
                  rowSpacer,
                ],
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }
}

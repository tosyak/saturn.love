// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/main_screen/moon_screen/about_moon_screen.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/presentation/widgets/expansion_tile_widget.dart';
import 'package:saturn/bloc/moon_screen_bloc.dart';
import 'package:saturn/presentation/widgets/no_internet_widget.dart';

class MoonScreen extends StatelessWidget {
  const MoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.calendar;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
        appBar: AppBar(
          leadingWidth: appBarLeadingWidth,
          title: Text(title, maxLines: 4),
          toolbarHeight: appBarHeight.calculateActionsHeight(),
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
        body: BlocBuilder<MoonBloc, MoonState>(
          builder: (context, state) {
            if (state is MoonNetworkNotConnected) {
              return const NoInternetWidget();
            } else if (state is MoonLoaded) {
              return Container(
                width: screenWidth,
                height: screenHeight,
                padding: ConstantSize.screenPadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.moonReportItem.source?.title ?? '',
                        style: AppTextStyle.playfairDisplay19Beige,
                      ),
                      gapH20,
                      // const _CopyLink(),
                      // gapH24,
                      // const _ConnectTelegram(),
                      // gapH16,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.transitCalendarDate,
                          style: AppTextStyle.arsenal16Light,
                        ),
                      ),
                      gapH16,
                      _CalendarButton(),
                      const SizedBox(height: 5),

                      gapH8,
                      SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AboutLunarCalendarScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.whatIsLunarCalendar,
                          ),
                        ),
                      ),
                      gapH24,
                      const _LunarInfo(),
                      gapH24,

                      const _MoonReportCardRowOne(),
                      gapH16,
                      const _MoonReportCardRowTwo(),
                      gapH16,
                      state.moonReportItem.source?.timelite == '1'
                          ? const _HappinessCard()
                          : const SizedBox.shrink(),

                      const _TransitCards(),
                    ],
                  ),
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.beige,
            ));
          },
        ));
  }
}

class _CalendarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          Future<void> selectDate() async {
            final DateTime? picked = await showDatePicker(
              context: context,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dialogBackgroundColor: AppColors.dark,
                    dialogTheme: DialogTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side:
                            const BorderSide(width: 2, color: AppColors.beige),
                      ),
                    ),
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.beige,
                      onPrimary: AppColors.light,
                      onSurface: AppColors.light,
                    ),
                  ),
                  child: child!,
                );
              },
              initialDate: DateTime.parse(state.selectedDate),
              firstDate: DateTime(1872),
              lastDate: DateTime(2072),
            );

            if (picked != null) {
              BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                reportIndex: int.parse(state.moonReportItem.source!.id!),
                date: DateFormat('yyyy-MM-dd hh:mm:ss').format(picked),
              ));
            }
          }

          return Column(
            children: [
              OutlinedButton.icon(
                icon: const ImageIcon(
                  AssetImage('assets/images/calendar_icon.png'),
                  size: 18,
                  color: AppColors.beige,
                ),
                label: Text(
                  DateFormat('kk:mm  d-MMMM-yyyy', state.languageCode)
                      .format(DateTime.parse(state.selectedDate)),
                ),
                onPressed: () {
                  selectDate();
                },
              ),
              gapH8,
              Row(
                children: [
                  Flexible(
                    child: OutlinedButton(
                      onPressed: () {
                        DateTime today = DateTime.parse(state.selectedDate);
                        DateTime yesterday =
                            today.subtract(const Duration(days: 1));

                        BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                          reportIndex:
                              int.parse(state.moonReportItem.source!.id!),
                          date: DateFormat('yyyy-MM-dd hh:mm:ss')
                              .format(yesterday),
                        ));
                      },
                      child: const ImageIcon(
                        AssetImage('assets/images/chevron_left.png'),
                        size: 18,
                        color: AppColors.beige,
                      ),
                    ),
                  ),
                  gapW16,
                  Flexible(
                    child: OutlinedButton(
                      onPressed: () {
                        DateTime today = DateTime.parse(state.selectedDate);
                        DateTime tomorrow = today.add(const Duration(days: 1));

                        BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                          reportIndex:
                              int.parse(state.moonReportItem.source!.id!),
                          date: DateFormat('yyyy-MM-dd hh:mm:ss')
                              .format(tomorrow),
                        ));
                      },
                      child: const ImageIcon(
                        AssetImage('assets/images/chevron_right.png'),
                        size: 18,
                        color: AppColors.beige,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _LunarInfo extends StatelessWidget {
  const _LunarInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          final String? string =
              state.moonReportItem.moon?.child?[0].content.toString();
          final List<String> infoStringList = string!.split('\r\n');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          infoStringList[0],
                          style: AppTextStyle.arsenal16Light,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                      height: 105,
                      child: Image.asset('assets/images/new_moon.png'),
                    ),
                  ),
                ],
              ),
              gapH24,
              Text(
                infoStringList[1].replaceAll(RegExp(' {3,}'), ''),
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.light,
                ),
              ),
              // gapH8,
              // const Text(
              //   "",
              //   // 'Начало: ${DateFormat('dd MMMM yyyy - HH:mm').format(value.time?.start?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
              //   style: AppTextStyle.arsenal12Light,
              // ),
              // gapH4,
              // const Text(
              //   "",
              //   //  'Завершение: ${DateFormat('dd MMMM yyyy - HH:mm').format(value.time?.end?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
              //   style: AppTextStyle.arsenal12Light,
              // ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _MoonReportCardRowOne extends StatelessWidget {
  const _MoonReportCardRowOne();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          if (state.moonReportItem.source?.timelite == '0') {
            return Column(
              children: [
                ExpansionTileListCustomWidget(
                  isExpanded: true,
                  title: state.moonReportItem.moon?.child?[1].title ?? "",
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.moonReportItem.moon?.child?[1].content ?? "",
                            style: AppTextStyle.arsenal16Light,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                ExpansionTileListCustomWidget(
                  isExpanded: true,
                  title: state.moonReportItem.moon?.child?[1].title ?? "",
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.moonReportItem.moon?.child?[1].content ?? "",
                            style: AppTextStyle.arsenal16Light,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                gapH16,
                ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: state.moonReportItem.moon?.child?[2].title ?? "",
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.moonReportItem.moon?.child?[2].content ?? "",
                            style: AppTextStyle.arsenal16Light,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }
        }
        return Container();
      },
    );
  }
}

class _MoonReportCardRowTwo extends StatelessWidget {
  const _MoonReportCardRowTwo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          final List<Widget> cardsList = [];

          if (state.moonReportItem.source?.timelite == '0') {
            for (var i = 2; i < 5; i++) {
              final String? string =
                  state.moonReportItem.moon?.child?[i].content.toString();
              final List<String>? contentStringList = string?.split('\r\n');
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: state.moonReportItem.moon?.child?[i].title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contentStringList?[0] ?? '',
                            style: AppTextStyle.arsenal16LightBold,
                          ),
                          gapH16,
                          contentStringList?.length == 1
                              ? const SizedBox.shrink()
                              : Text(
                                  contentStringList?[1]
                                          .replaceAll(RegExp(' {3,}'), '') ??
                                      '',
                                  style: AppTextStyle.arsenal16Light,
                                ),
                          gapH16,
                          OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                                reportIndex:
                                    int.parse(state.moonReportItem.source!.id!),
                                date: _dateStringMaker(
                                    contentStringList?[0].trimLeft() ?? ''),
                              ));
                            },
                            child: Text(AppLocalizations.of(context)!.view),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
              cardsList.add(card);
            }
          } else {
            for (var i = 3; i < 6; i++) {
              final String? string =
                  state.moonReportItem.moon?.child?[i].content.toString();
              final List<String>? contentStringList = string?.split('\r\n');
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: state.moonReportItem.moon?.child?[i].title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contentStringList?[0] ?? '',
                            style: AppTextStyle.arsenal16LightBold,
                          ),
                          gapH16,
                          contentStringList?.length == 1
                              ? const SizedBox.shrink()
                              : Text(
                                  contentStringList?[1]
                                          .replaceAll(RegExp(' {3,}'), '') ??
                                      '',
                                  style: AppTextStyle.arsenal16Light,
                                ),
                          gapH16,
                          OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<MoonBloc>(context).add(FetchMoon(
                                reportIndex:
                                    int.parse(state.moonReportItem.source!.id!),
                                date: _dateStringMaker(
                                    contentStringList?[0].trimLeft() ?? ''),
                              ));
                            },
                            child: Text(AppLocalizations.of(context)!.view),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
              cardsList.add(card);
            }
          }

          return Column(
            children: cardsList,
          );
        }
        return Container();
      },
    );
  }
}

String _dateStringMaker(String date) {
  final russianMonths = {
    'января': '01',
    'февраля': '02',
    'марта': '03',
    'апреля': '04',
    'мая': '05',
    'июня': '06',
    'июля': '07',
    'августа': '08',
    'сентября': '09',
    'октября': '10',
    'ноября': '11',
    'декабря': '12',
  };

  final originalDate = date;
  final parts = originalDate.split(' ');
  final month = russianMonths[parts[1]];
  if (parts[0].length == 1) {
    parts[0] = '0${parts[0]}';
  }
  final str = '${parts[2]}-$month-${parts[0]} ${parts[4]}:00';
  return str;
}

class _HappinessCard extends StatelessWidget {
  const _HappinessCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          final String string = state.moonReportItem.moon!.child![6].content!
              .replaceAll(RegExp(' {3,}'), '')
              .trimRight();
          final list = string.split('\r\n');

          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ReportDecoratedCardWidget(
              buttonIsActive: true,
              isTransparent: false,
              dialogText: state.moonReportItem.moon?.child?[6].about ?? '',
              cardTitle: state.moonReportItem.moon?.child?[6].title ?? '',
              bodyText: list,
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _TransitCards extends StatelessWidget {
  const _TransitCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoonBloc, MoonState>(
      builder: (context, state) {
        if (state is MoonLoaded) {
          final dataList = state.moonReportItem.moon?.child;

          final List<Widget> cardsList = [];

          if (state.moonReportItem.source?.timelite == '0') {
            for (var i = 5; i < dataList!.length; i++) {
              final cardItem = Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: dataList[i].title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.light),
                          ),
                          gapH8,
                          Text(
                            '${AppLocalizations.of(context)!.start} ${DateFormat(
                              'dd MMMM yyyy - HH:mm',
                              state.languageCode,
                            ).format(dataList[i].time?.start?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                            style: AppTextStyle.arsenal12Light,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.end} ${DateFormat(
                              'dd MMMM yyyy - HH:mm',
                              state.languageCode,
                            ).format(dataList[i].time?.end?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                            style: AppTextStyle.arsenal12Light,
                          ),
                          gapH8,
                          dataList[i].content != '0'
                              ? Text(
                                  dataList[i]
                                          .content
                                          ?.replaceAll('\n', '\n\n')
                                          .replaceAll(RegExp(' {3,}'), '') ??
                                      '',
                                  style: AppTextStyle.arsenal16Light,
                                )
                              : Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .makeSubscription,
                                      style:
                                          AppTextStyle.playfairDisplay19Beige,
                                    ),
                                    gapH16,
                                    SizedBox(
                                      height: 40,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          // foregroundColor: AppColors.beige,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .checkoutSubscription,
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              );
              cardsList.add(cardItem);
            }
          } else {
            for (var i = 7; i < dataList!.length; i++) {
              final cardItem = Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: dataList[i].title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.light),
                          ),
                          gapH8,
                          Text(
                            '${AppLocalizations.of(context)!.start} ${DateFormat(
                              'dd MMMM yyyy - HH:mm',
                              state.languageCode,
                            ).format(dataList[i].time?.start?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                            style: AppTextStyle.arsenal12Light,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.end} ${DateFormat(
                              'dd MMMM yyyy - HH:mm',
                              state.languageCode,
                            ).format(dataList[i].time?.end?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                            style: AppTextStyle.arsenal12Light,
                          ),
                          gapH8,
                          dataList[i].content != '0'
                              ? Text(
                                  dataList[i]
                                          .content
                                          ?.replaceAll('\n', '\n\n')
                                          .replaceAll(RegExp(' {3,}'), '') ??
                                      '',
                                  style: AppTextStyle.arsenal16Light,
                                )
                              : Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .makeSubscription,
                                      style:
                                          AppTextStyle.playfairDisplay19Beige,
                                    ),
                                    gapH16,
                                    SizedBox(
                                      height: 40,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          // foregroundColor: AppColors.beige,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .checkoutSubscription,
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              );
              cardsList.add(cardItem);
            }
          }

          return Column(
            children: cardsList,
          );
        }
        return Container();
      },
    );
  }
}

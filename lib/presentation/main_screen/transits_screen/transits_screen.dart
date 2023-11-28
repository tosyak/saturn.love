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
import 'package:saturn/presentation/main_screen/transits_screen/about_transits_screen.dart';
import 'package:saturn/presentation/widgets/expansion_tile_widget.dart';
import 'package:saturn/bloc/transits_screen_bloc.dart';
import 'package:saturn/presentation/widgets/no_internet_widget.dart';

class TransitsScreen extends StatelessWidget {
  const TransitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.planetaryTransits;

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
        body: BlocBuilder<TransiteBloc, TransiteState>(
          builder: (context, state) {
             if (state is TransiteNetworkNotConnected) {
              return const NoInternetWidget();
            } else
            if (state is TransiteLoaded) {
              return Container(
                width: screenWidth,
                height: screenHeight,
                padding: ConstantSize.screenPadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.transitsReportItem.source?.title ?? '',
                        style: AppTextStyle.playfairDisplay19Beige,
                      ),
                      gapH20,
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.transitCalendarDate,
                          style: AppTextStyle.arsenal16Light,
                        ),
                      ),
                      gapH16,
                      _CalendarButton(),
                      gapH16,
                      SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AboutTransitsScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.whatAreTransit,
                            // style: AppTextStyle.arsenal16Light,
                          ),
                        ),
                      ),
                      gapH24,
                      const _TransitsHint(),
                      gapH24,
                      Text(
                        AppLocalizations.of(context)!.whatAreTransit,
                        style: AppTextStyle.arsenal22Light,
                      ),
                      gapH16,
                      const _TransitsCards(),
                      gapH16,
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
    return BlocBuilder<TransiteBloc, TransiteState>(
      builder: (context, state) {
        if (state is TransiteLoaded) {
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
              BlocProvider.of<TransiteBloc>(context).add(FetchTransite(
                reportIndex: int.parse(state.transitsReportItem.source!.id!),
                date: DateFormat('yyyy-MM-dd hh:mm:ss').format(picked),
              ));
            }
          }

          return SizedBox(
            height: 38,
            child: OutlinedButton.icon(
              icon: const ImageIcon(
                AssetImage('assets/images/calendar_icon.png'),
                size: 18,
                color: AppColors.beige,
              ),
              label: Text(
                DateFormat('kk:mm  dd-MMMM-yyyy', state.languageCode)
                    .format(DateTime.parse(state.selectedDate)),
              ),
              onPressed: () {
                selectDate();
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _TransitsHint extends StatelessWidget {
  const _TransitsHint();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransiteBloc, TransiteState>(
      builder: (context, state) {
        if (state is TransiteLoaded) {
          return RichText(
            text: TextSpan(
              // text: AppLocalizations.of(context)!.transitsHint1,
              text: state.transitsReportItem.transite?.about,
              style: AppTextStyle.arsenal16Light,
              children: const <TextSpan>[
                // TextSpan(
                //   text: AppLocalizations.of(context)!.transitsHint2,
                //   style: AppTextStyle.arsenal16BeigeBold,
                // ),
                // TextSpan(
                //   text: AppLocalizations.of(context)!.transitsHint3,
                // ),
                // TextSpan(
                //   text: AppLocalizations.of(context)!.transitsHint4,
                //   style: AppTextStyle.arsenal16BeigeBold,
                // ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _TransitsCards extends StatelessWidget {
  const _TransitsCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransiteBloc, TransiteState>(
      builder: (context, state) {
        if (state is TransiteLoaded) {
          final reportChild = state.transitsReportItem.transite?.child;

          final List<Widget> listWidget = [];
          int counter = 1;

          reportChild?.forEach((key, value) {
            final cardItem = Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ExpansionTileListCustomWidget(
                isExpanded: counter == 1 ? true : false,
                title: value.title ?? '',
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
                          ).format(value.time?.start?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                          style: AppTextStyle.arsenal12Light,
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.end} ${DateFormat(
                            'dd MMMM yyyy - HH:mm',
                            state.languageCode,
                          ).format(value.time?.end?.date ?? DateTime(0000, 0, 00, 00, 00, 00)).toString()}',
                          style: AppTextStyle.arsenal12Light,
                        ),
                        gapH8,
                        value.content != '0'
                            ? Text(
                                value.content
                                        ?.replaceFirst(RegExp('^\\r\\n'), '')
                                        .replaceAll('\n', '\n\n')
                                        .replaceAll(RegExp(' {3,}'), '') ??
                                    '',
                                style: AppTextStyle.arsenal16Light,
                              )
                            : Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.toAccess,
                                    style: AppTextStyle.playfairDisplay19Beige,
                                  ),
                                  gapH16,
                                  SizedBox(
                                    height: 40,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        // foregroundColor: AppColors.beige,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      onPressed: () {
                                        context
                                            .pushNamed(AppPage.tariffs.toName);
                                      },
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
            counter += 1;
            listWidget.add(cardItem);
          });
          return Column(
            children: listWidget,
          );
        }
        return Container();
      },
    );
  }
}

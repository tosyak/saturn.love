// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/expansion_tile_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class PlanetsInHousesScreen extends StatelessWidget {
  const PlanetsInHousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.planetsInHouses;
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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlanetsInHousesCards(),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanetsInHousesCards extends StatelessWidget {
  const PlanetsInHousesCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (context, state) {
        if (state is ReportScreenReportLoaded) {
          List<Widget> list = [];
          final childList = state.reportItem.homePlanets?.child;
          childList?.forEach((key, value) {
            if (childList[key]['content'] == '0') {
              final homeCard = Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ExpansionTileSubscribeCustomWidget(
                  isExpanded: key == '1' ? true : false,
                  header: childList[key]['title'] ?? '',
                  title: '$key ${AppLocalizations.of(context)!.house}',
                  titleStyle: AppTextStyle.arsenal22Light,
                  // body: childList[key]['content'].replaceAll(RegExp(' {3,}'), '') ?? '',
                ),
              );
              list.add(homeCard);
            } else {
              final homeCard = Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ExpansionTileCustomWidget(
                  isExpanded: key == '1' ? true : false,
                  header: childList[key]['title'] ?? '',
                  title: '$key ${AppLocalizations.of(context)!.house}',
                  titleStyle: AppTextStyle.arsenal22Light,
                  body: childList[key]['content']
                          .replaceAll(RegExp(' {3,}'), '') ??
                      '',
                ),
              );
              list.add(homeCard);
            }
            if (childList[key].containsKey('child') &&
                childList[key]['child'] != null) {
              if (childList[key]['child'] is Map<String, dynamic>) {
                childList[key]['child'].forEach((key1, value1) {
                  if (childList[key]['child'][key1]['content'] == '0') {
                    final mapCard = Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ExpansionTileSubscribeCustomWidget(
                        isExpanded: false,
                        title: childList[key]['child'][key1]['title'] ?? '',
                        titleStyle: AppTextStyle.arsenal22Light,
                      ),
                    );
                    list.add(mapCard);
                  } else {
                    final mapCard = Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ExpansionTileCustomWidget(
                        isExpanded: false,
                        title: childList[key]['child'][key1]['title'] ?? '',
                        titleStyle: AppTextStyle.arsenal22Light,
                        body: childList[key]['child'][key1]['content']
                                .replaceAll(RegExp(' {3,}'), '') ??
                            '',
                      ),
                    );
                    list.add(mapCard);
                  }
                });
              } else {
                for (var i = 0; i < childList[key]['child'].length; i++) {
                  if (childList[key]['child'][i]['content'] == '0') {
                    final card = Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ExpansionTileSubscribeCustomWidget(
                        isExpanded: false,
                        title: childList[key]['child'][i]['title'] ?? '',
                        titleStyle: AppTextStyle.arsenal22Light,
                      ),
                    );

                    list.add(card);
                  } else {
                    final card = Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ExpansionTileCustomWidget(
                        isExpanded: false,
                        title: childList[key]['child'][i]['title'] ?? '',
                        titleStyle: AppTextStyle.arsenal22Light,
                        body: childList[key]['child'][i]['content']
                                .replaceAll(RegExp(' {3,}'), '') ??
                            '',
                      ),
                    );

                    list.add(card);
                  }
                }
              }
            }
          });

          return Column(
            children: list,
          );
        }
        return Container();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/widgets/decorated_card_widget.dart';
import 'package:saturn/bloc/report_screen_bloc.dart';

class WorkingMethodsScreen extends StatelessWidget {
  const WorkingMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.workingMethods;
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
                    const _WorkingMethodsHint(),
                    gapH24,
                    state.reportItem.downPlanet?.child[0]['content'] == '0'
                        ? ReportDecoratedCardSubscribeWidget(
                            buttonIsActive: false,
                            isTransparent: false,
                            cardTitle: state.reportItem.downPlanet?.child[0]
                                    ['title'] ??
                                '')
                        : const DownPlanetCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _WorkingMethodsHint extends StatelessWidget {
  const _WorkingMethodsHint();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.workingMethodsHint,
        style: AppTextStyle.arsenal16Light,
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint1,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint2,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint3,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint4,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint5,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint6,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint7,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.workingMethodsHint8,
          ),
        ],
      ),
    );
  }
}

class DownPlanetCard extends StatelessWidget {
  const DownPlanetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;

    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
        builder: (context, state) {
      if (state is ReportScreenReportLoaded) {
        var string =
            state.reportItem.downPlanet?.child[0]['content'].toString();
        string = string!.replaceAll('\r', '');
        string = string.replaceAll('\n', '');

        List<String> convertedString = string.split('<p>');

        final List<String> cardList = convertedString[0]
            .replaceAll('<ul><li>', '')
            .replaceAll('</li><li>', '&')
            .replaceAll('</li></ul>', '')
            .split('&');

        final String cardString = convertedString[1].replaceAll('</p>', '');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.reportItem.downPlanet?.title ?? '',
              style: AppTextStyle.arsenal22Light,
            ),
            Stack(
              children: [
                Container(
                  width: screenWidth - paddingSize * 2,
                  margin: const EdgeInsets.only(top: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.beige10,
                      border: Border.all(
                        width: 2,
                        color: AppColors.beige,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 16.0, right: 20, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: ImageIcon(
                                        AssetImage(
                                            "assets/images/star_icon.png"),
                                        color: AppColors.beige,
                                        size: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SizedBox(
                                      width: screenWidth - 85,
                                      child: Text(
                                        cardList[index],
                                        style: AppTextStyle.arsenal16Light,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: cardList.length,
                          ),
                          gapH16,
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              cardString,
                              style: AppTextStyle.arsenal16Light,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 1,
                  right: 15,
                  child: ImageIcon(
                    AssetImage("assets/images/card_icon.png"),
                    color: AppColors.beige,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        );
      }
      return Container();
    });
  }
}

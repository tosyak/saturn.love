// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:saturn/presentation/main_screen/sade_sati_screen/about_sade_sati_screen.dart';
import 'package:saturn/presentation/widgets/expansion_tile_widget.dart';
import 'package:saturn/bloc/sadisati_screen_bloc.dart';
import 'package:saturn/presentation/widgets/no_internet_widget.dart';

class SadeSatieScreen extends StatelessWidget {
  const SadeSatieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.sadeSatie;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);

    return Scaffold(
        appBar: AppBar(
          leadingWidth: appBarLeadingWidth,
          toolbarHeight: appBarHeight.calculateActionsHeight(),
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
        body: BlocBuilder<SadiSatiBloc, SadiSatiState>(
          builder: (context, state) {
            if (state is SadiSatiNetworkNotConnected) {
              return const NoInternetWidget();
            } else if (state is SadiSatiLoaded) {
              return Container(
                width: screenWidth,
                height: screenHeight,
                padding: ConstantSize.screenPadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.sadiSatiReportItem.source?.title ?? '',
                        style: AppTextStyle.playfairDisplay19Beige,
                      ),
                      gapH16,
                      SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AboutSadeSatiScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.whatIsSadeSati,
                          ),
                        ),
                      ),
                      gapH16,
                      const _SadeSatiCards(),
                      gapH16,
                      const _SadeSatiHint(),
                      gapH16,
                      state.sadiSatiReportItem.sadisati?.child?.length == 2
                          ? Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.sadeSatiTips9,
                                  style: AppTextStyle.arsenal22Light,
                                ),
                                gapH16,
                                const _SadeSatiHousesCards(),
                              ],
                            )
                          : const SizedBox.shrink(),
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

class _SadeSatiCards extends StatelessWidget {
  const _SadeSatiCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SadiSatiBloc, SadiSatiState>(builder: (context, state) {
      if (state is SadiSatiLoaded) {
        final list = state.sadiSatiReportItem.sadisati?.child?[0].child;
        List<Widget> cardsList = [];
        list?.forEach(
          (element) {
            List<Widget> startList = [];
            List<Widget> endList = [];
            element.time?.start?.forEach((element) {
              final date = Text(
                DateFormat('dd MMMM yyyy - HH:mm', state.languageCode)
                    .format(element.date ?? DateTime(0000, 0, 00, 00, 00, 00)),
                style: AppTextStyle.arsenal14Light,
              );
              startList.add(date);
            });
            element.time?.end?.forEach((element) {
              final date = Text(
                DateFormat('dd MMMM yyyy - HH:mm', state.languageCode)
                    .format(element.date ?? DateTime(0000, 0, 00, 00, 00, 00)),
                style: AppTextStyle.arsenal14Light,
              );
              endList.add(date);
            });

            final card = Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ExpansionTileListCustomWidget(
                isExpanded: false,
                title: element.title ?? '',
                titleStyle: AppTextStyle.arsenal16LightBold,
                body: [
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          startList.isEmpty
                              ? const SizedBox.shrink()
                              : Text(
                                  AppLocalizations.of(context)!.start,
                                  style:
                                      const TextStyle(color: AppColors.beige),
                                ),
                          gapH4,
                          startList.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: startList,
                                ),
                          gapH16,
                          Text(
                            AppLocalizations.of(context)!.end,
                            style: const TextStyle(color: AppColors.beige),
                          ),
                          gapH4,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: endList,
                          ),
                        ],
                      )

                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Column(
                      //         children: startList,
                      //       ),
                      //       Column(
                      //         children: endList,
                      //       )
                      //     ]),
                      )
                ],
              ),
            );
            cardsList.add(card);
          },
        );

        return Column(
          children: cardsList,
        );
      }
      return Container();
    });
  }
}

class _SadeSatiHint extends StatelessWidget {
  const _SadeSatiHint();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SadiSatiBloc, SadiSatiState>(
      builder: (context, state) {
        if (state is SadiSatiLoaded) {
          return RichText(
            text: TextSpan(
              // text: AppLocalizations.of(context)!.sadeSatiHint,
              text: state.sadiSatiReportItem.sadisati?.about,
              style: AppTextStyle.arsenal16Light,
              children: const <TextSpan>[
                // TextSpan(
                //   text: AppLocalizations.of(context)!.sadeSatiHint1,
                //   style: AppTextStyle.arsenal16Light,
                // ),
                // TextSpan(
                //   text: AppLocalizations.of(context)!.sadeSatiHint2,
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

class _SadeSatiHousesCards extends StatelessWidget {
  const _SadeSatiHousesCards();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SadiSatiBloc, SadiSatiState>(builder: (context, state) {
      if (state is SadiSatiLoaded) {
        final list = state.sadiSatiReportItem.sadisati?.child?[1].child;
        List<Widget> cardsList = [];
        list?.forEach(
          (element) {
            if (element.content == '0') {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExpansionTileSubscribeCustomWidget(
                  isExpanded: false,
                  title: element.title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                ),
              );
              cardsList.add(card);
            } else {
              final card = Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExpansionTileListCustomWidget(
                  isExpanded: false,
                  title: element.title ?? '',
                  titleStyle: AppTextStyle.arsenal16LightBold,
                  body: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        element.content ?? '',
                        style: AppTextStyle.arsenal16Light,
                      ),
                    )
                  ],
                ),
              );
              cardsList.add(card);
            }
          },
        );

        return Column(
          children: cardsList,
        );
      }
      return Container();
    });
  }
}

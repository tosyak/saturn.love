// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';

import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/utils/url_launcher.dart';

class TariffsScreen extends StatelessWidget {
  const TariffsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.allRates;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(title, maxLines: 4),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.chooseSubscription,
              style: AppTextStyle.arsenal22Light,
            ),
            const SizedBox(height: 15),
            const Expanded(
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _FreeTariffCard(),
                    SizedBox(height: 15),
                    _LiteTariffCard(),
                    SizedBox(height: 15),
                    _ProTariffCard(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FreeTariffCard extends StatelessWidget {
  const _FreeTariffCard();

  @override
  Widget build(BuildContext context) {
    List freeCard = [
      AppLocalizations.of(context)!.freeCard1,
      AppLocalizations.of(context)!.freeCard2,
      AppLocalizations.of(context)!.freeCard3,
      AppLocalizations.of(context)!.freeCard4,
      AppLocalizations.of(context)!.freeCard5,
      AppLocalizations.of(context)!.freeCard6,
    ];

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Card(
            color: AppColors.beige10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 16.0, right: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.free,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: freeCard
                        .map(
                          (element) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    element,
                                    style: AppTextStyle.arsenal14Light,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppPage.getReportForm.toName);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.getReportMap,
                      style: AppTextStyle.arsenal16LightBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: -1,
          right: 15,
          // height: 130,
          child: ImageIcon(
            AssetImage("assets/images/card_icon.png"),
            color: AppColors.beige,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _LiteTariffCard extends StatelessWidget {
  const _LiteTariffCard();

  @override
  Widget build(BuildContext context) {
    List liteCard = [
      AppLocalizations.of(context)!.liteCard1,
      AppLocalizations.of(context)!.liteCard2,
      AppLocalizations.of(context)!.liteCard3,
      AppLocalizations.of(context)!.liteCard4,
      AppLocalizations.of(context)!.liteCard5,
      AppLocalizations.of(context)!.liteCard6,
      AppLocalizations.of(context)!.liteCard7,
      AppLocalizations.of(context)!.liteCard8,
      AppLocalizations.of(context)!.liteCard9,
      AppLocalizations.of(context)!.liteCard10,
      AppLocalizations.of(context)!.liteCard11,
      AppLocalizations.of(context)!.liteCard12,
      AppLocalizations.of(context)!.liteCard13,
      AppLocalizations.of(context)!.liteCard14,
      AppLocalizations.of(context)!.liteCard15,
      AppLocalizations.of(context)!.liteCard16,
      AppLocalizations.of(context)!.liteCard17,
      AppLocalizations.of(context)!.liteCard18,
      AppLocalizations.of(context)!.liteCard19,
    ];

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Card(
            color: AppColors.beige10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 16.0, right: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.lite,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: liteCard
                        .map(
                          (element) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    element,
                                    style: AppTextStyle.arsenal14Light,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String locale =
                          await LocaleHiveBox().getLocaleHive();
                      if (locale == 'ru') {
                        LoginLinkLauncher()
                            .fetchResourcesListApi(LinkType.subscribeRu);
                      } else {
                        LoginLinkLauncher()
                            .fetchResourcesListApi(LinkType.subscribe);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.checkoutSubscription,
                      style: AppTextStyle.arsenal16LightBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: -1,
          right: 15,
          // height: 130,
          child: ImageIcon(
            AssetImage("assets/images/card_icon.png"),
            color: AppColors.beige,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _ProTariffCard extends StatelessWidget {
  const _ProTariffCard();

  @override
  Widget build(BuildContext context) {
    List proCard = [
      AppLocalizations.of(context)!.proCard1,
      AppLocalizations.of(context)!.proCard2,
      AppLocalizations.of(context)!.proCard3,
      AppLocalizations.of(context)!.proCard4,
      AppLocalizations.of(context)!.proCard5,
      AppLocalizations.of(context)!.proCard6,
      AppLocalizations.of(context)!.proCard7,
      AppLocalizations.of(context)!.proCard8,
      AppLocalizations.of(context)!.proCard9,
      AppLocalizations.of(context)!.proCard10,
      AppLocalizations.of(context)!.proCard11,
      AppLocalizations.of(context)!.proCard12,
      AppLocalizations.of(context)!.proCard13,
      AppLocalizations.of(context)!.proCard14,
      AppLocalizations.of(context)!.proCard15,
      AppLocalizations.of(context)!.proCard16,
      AppLocalizations.of(context)!.proCard17,
      AppLocalizations.of(context)!.proCard18,
      AppLocalizations.of(context)!.proCard19,
    ];

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Card(
            color: AppColors.beige10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 16.0, right: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.pro,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: proCard
                        .map(
                          (element) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 0.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    element,
                                    style: AppTextStyle.arsenal14Light,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      LoginLinkLauncher()
                          .fetchResourcesListApi(LinkType.subscribe);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.selectPeriod,
                      style: AppTextStyle.arsenal16LightBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: -1,
          right: 15,
          // height: 130,
          child: ImageIcon(
            AssetImage("assets/images/card_icon.png"),
            color: AppColors.beige,
            size: 30,
          ),
        ),
      ],
    );
  }
}

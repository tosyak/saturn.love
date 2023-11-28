import 'package:flutter/material.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutJyotishScreen extends StatelessWidget {
  const AboutJyotishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.aboutJyotish;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(
          title,
          maxLines: 3,
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: ConstantSize.screenPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.whatIsJyotish,
                style: AppTextStyle.arsenal22Light,
              ),
              // const SizedBox(height: 16),
              const _AboutJyotishCard(),
              gapH24,
              Text(
                AppLocalizations.of(context)!.imorpantAboutAstrology,
                style: AppTextStyle.arsenal22Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.astrologyIs,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH24,
              Text(
                AppLocalizations.of(context)!.jyotishAnswer,
                style: AppTextStyle.arsenal22BeigeBold,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish15,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish16,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish17,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish18,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish19,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish20,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish21,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish22,
                style: AppTextStyle.arsenal16BeigeBold,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish23,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish24,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish25,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish26,
                style: AppTextStyle.arsenal16Light,
              ),
              gapH16,
              Text(
                AppLocalizations.of(context)!.aboutJyotish27,
                style: AppTextStyle.arsenal16BeigeBold,
              ),
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutJyotishCard extends StatelessWidget {
  const _AboutJyotishCard();

  @override
  Widget build(BuildContext context) {
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
                children: [
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.aboutJyotish1,
                      style: AppTextStyle.arsenal16Light,
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish2,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish3,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish4,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish5,
                        ),
                      ],
                    ),
                  ),
                  gapH16,
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.aboutJyotish6,
                      style: AppTextStyle.arsenal16Light,
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish7,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish8,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish9,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                      ],
                    ),
                  ),
                  gapH16,
                  RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.aboutJyotish10,
                      style: AppTextStyle.arsenal16Light,
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish11,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish12,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish13,
                          style: AppTextStyle.arsenal16BeigeBold,
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.aboutJyotish14,
                        ),
                      ],
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

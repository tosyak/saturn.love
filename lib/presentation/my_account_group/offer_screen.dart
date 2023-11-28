import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/utils/url_launcher.dart';

class MyAccountOfferScreen extends StatelessWidget {
  const MyAccountOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UrlLauncher urlLauncher = UrlLauncher();
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.offer;
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.shopOffer,
                        style: AppTextStyle.arsenal22Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.contactsIP,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.contacts,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: "",
                        children: [
                          TextSpan(
                              text: "info@saturn.love",
                              style: AppTextStyle.arsenal16Light.copyWith(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>urlLauncher.sendEmail('info@saturn.love')),
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    TextButton(
                      onPressed: () async => urlLauncher.openDialer('+7(8453)680022'),
                      child: const Text('+7(8453)680022'),
                    ),
                    const SizedBox(height: 16),
                    const _OfferText()
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


class _OfferText extends StatelessWidget {
  const _OfferText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.offerPage,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage1,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage2,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage3,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage4,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage5,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage6,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage7,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage8,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage9,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage10,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage11,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage12,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage13,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage14,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage15,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage16,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        // 4

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage17,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.offerPage18,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage19,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage20,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage21,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        // 5

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage22,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.offerPage23,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage24,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage25,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        // 6

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage26,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.offerPage27,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage28,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage29,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage30,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage31,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage32,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage33,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage34,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage35,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage36,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage37,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage38,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage39,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage40,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage41,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage42,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage43,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage44,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage45,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage46,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage47,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage48,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage49,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage50,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage51,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        //7

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage52,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.offerPage53,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        // 8

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage54,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 16),

        Text(AppLocalizations.of(context)!.offerPage55,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage56,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage57,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.offerPage58,
            style: AppTextStyle.arsenal16Light),
        const SizedBox(height: 8),

        //

        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.offerPage59,
            style: AppTextStyle.arsenal22BeigeBold),
        const SizedBox(height: 26),
      ],
    );
  }
}

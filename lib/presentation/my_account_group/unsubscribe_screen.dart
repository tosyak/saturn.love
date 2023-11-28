import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/utils/url_launcher.dart';

class MyAccountUnsubscribeScreen extends StatelessWidget {
  const MyAccountUnsubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.unsubscribe;
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ray_background.png"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.howToUnsubscribe,
                      style: AppTextStyle.arsenal22Light,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.howToUnsubscribe0,
                      style: AppTextStyle.arsenal12Light,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.howToUnsubscribe1,
                      style: AppTextStyle.arsenal16Light,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.howToUnsubscribe2,
                        children: [
                          TextSpan(
                              text: "https://saturn.love/ru/payhistory.html",
                              style: AppTextStyle.arsenal16Light.copyWith(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final String languageCode =
                                      await LocaleHiveBox().getLocaleHive();
                                  languageCode == 'ru'
                                      ? UrlLauncher().launchLink(
                                          'https://saturn.love/ru/payhistory.html')
                                      : UrlLauncher().launchLink(
                                          'https://saturn.love/en/payhistory.html');
                                }),
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.howToUnsubscribe3,
                      style: AppTextStyle.arsenal16Light,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.howToUnsubscribe4,
                      style: AppTextStyle.arsenal16Light,
                    ),
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

// Future<void> launchUrlStart({required String url}) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     throw 'Could not launch $url';
//   }
// }

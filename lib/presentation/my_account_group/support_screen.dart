import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/utils/url_launcher.dart';
import 'package:saturn/presentation/my_account_group/offer_screen.dart';
import 'package:saturn/presentation/my_account_group/privacy_policy_screen.dart';
import 'package:saturn/presentation/my_account_group/subscription_agreement_screen.dart';

class MyAccountSupportScreen extends StatelessWidget {
  const MyAccountSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.support;
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
                    const _Buttons(),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.anyQuestions,
                      style: AppTextStyle.arsenal22BeigeBold,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.anyQuestions2,
                      style: AppTextStyle.arsenal16Light,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.workingHours,
                        style: AppTextStyle.arsenal16LightBold,
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.workingHours2,
                            style: AppTextStyle.arsenal16Light,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.inTheMail,
                      style: AppTextStyle.arsenal16BeigeBold,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: "",
                        children: [
                          TextSpan(
                              text: "support@saturn.love",
                              style: AppTextStyle.arsenal16Light.copyWith(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => UrlLauncher()
                                    .sendEmail('support@saturn.love')),
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    // Text(
                    //   "support@saturn.love",
                    //   style: AppTextStyle.arsenal16Light,
                    // ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.socialMedia,
                      style: AppTextStyle.arsenal16BeigeBold,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: "",
                        children: [
                          TextSpan(
                              text: 'telegram @SaturnLove_Support_bot',
                              style: AppTextStyle.arsenal16Light.copyWith(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => UrlLauncher().launchTelegram(
                                    'https://t.me/SaturnLove_Support_bot')),
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    // Text(
                    //   "telegram @Saturn.Love",
                    //   style: AppTextStyle.arsenal16Light,
                    // ),
                  ],
                ),
              ),
            ),
            gapH20
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () async {
            final String locale = await LocaleHiveBox().getLocaleHive();
            if (locale == 'ru') {
              LoginLinkLauncher()
                  .fetchResourcesListApi(LinkType.cancelSubscriptionRu);
            } else {
              LoginLinkLauncher()
                  .fetchResourcesListApi(LinkType.cancelSubscription);
            }
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.unsubscribe,
                  style: AppTextStyle.arsenal22Light,
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            final String locale = await LocaleHiveBox().getLocaleHive();
            if (locale == 'ru') {
              LoginLinkLauncher().fetchResourcesListApi(LinkType.refundRu);
            } else {
              LoginLinkLauncher().fetchResourcesListApi(LinkType.refund);
            }
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.refunds,
                  style: AppTextStyle.arsenal22Light,
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyAccountOfferScreen()),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.offer,
                  style: AppTextStyle.arsenal22Light,
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyAccountPrivacyPolicyScreen()),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.privacyPolicy,
                  style: AppTextStyle.arsenal22Light,
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubscriptionAgreementScreen()),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.agreement,
                  style: AppTextStyle.arsenal22Light,
                ),
                const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward, size: 21),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

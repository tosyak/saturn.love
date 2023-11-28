import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/my_account_screen.dart';

class AboutTransitsScreen extends StatelessWidget {
  const AboutTransitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.whatAreTransit;
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAccountScreen()),
                  );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AboutTransitsFirst(),
              gapH24,
              Text(
                AppLocalizations.of(context)!.aboutTransits2,
                style: AppTextStyle.arsenal22Light,
              ),
              gapH24,
              const _AboutTransitsSecond(),
              gapH24,
              Text(
                AppLocalizations.of(context)!.aboutTransits15,
                style: AppTextStyle.arsenal16BeigeBold,
              ),
              gapH24,
              gapH16,
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutTransitsFirst extends StatelessWidget {
  const _AboutTransitsFirst();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.aboutTransits3,
        style: AppTextStyle.arsenal16Light,
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits4,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits5,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits6,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits7,
          ),
        ],
      ),
    );
  }
}

class _AboutTransitsSecond extends StatelessWidget {
  const _AboutTransitsSecond();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: AppLocalizations.of(context)!.aboutTransits8,
        style: AppTextStyle.arsenal16Light,
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits9,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits10,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits11,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits12,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits13,
            style: AppTextStyle.arsenal16BeigeBold,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.aboutTransits14,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';

class MyAccountPrivacyPolicyScreen extends StatelessWidget {
  const MyAccountPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.privacyPolicy;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(
          title,
          maxLines: 4,
          style: const TextStyle(fontSize: 23),
        ),
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
                    Text(AppLocalizations.of(context)!.privacyPolicy1,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy2,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy3,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy4,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy5,
                        style: AppTextStyle.arsenal16Light),

                    //

                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy6,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy7,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy8,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy9,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy10,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy11,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy12,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy13,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy14,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy15,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy16,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy17,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy18,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //

                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy19,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //
                    Text(AppLocalizations.of(context)!.privacyPolicy20,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy21,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy23,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy24,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy25,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy26,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy27,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy28,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy29,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy30,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy31,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy32,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy33,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy34,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy35,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy36,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy37,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy38,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy39,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy40,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy41,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy42,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy43,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy44,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy45,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy46,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy47,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy48,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy49,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy50,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy51,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy52,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy53,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy54,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy55,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy56,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy57,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy58,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy59,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy60,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy61,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy62,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy63,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy64,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.privacyPolicy65,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.privacyPolicy67,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy68,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.privacyPolicy69,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 28),
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

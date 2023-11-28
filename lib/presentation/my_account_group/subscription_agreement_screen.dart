import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';

class SubscriptionAgreementScreen extends StatelessWidget {
  const SubscriptionAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.agreement;
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
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage1,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage2,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),

                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage3,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage4,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage5,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage6,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage7,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage8,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage9,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage10,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage11,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage12,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage13,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage14,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage15,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage16,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage17,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage18,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage19,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage20,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage21,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage22,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage23,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage24,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage25,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage26,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage27,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage28,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage29,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage30,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage31,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage32,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage33,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage34,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage35,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage36,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage37,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage38,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage39,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage40,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage41,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage42,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage43,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage44,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage45,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage46,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage47,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage48,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage49,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage50,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage51,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage52,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),

                    //
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage53,
                        style: AppTextStyle.arsenal22BeigeBold),
                    const SizedBox(height: 16),
                    //

                    Text(AppLocalizations.of(context)!.subscriptionAgrPage54,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage55,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage56,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.subscriptionAgrPage57,
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

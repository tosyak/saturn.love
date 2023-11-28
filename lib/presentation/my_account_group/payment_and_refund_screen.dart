import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/subscription_agreement_screen.dart';

class MyAccountPaymentAndRefundScreen extends StatelessWidget {
  const MyAccountPaymentAndRefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.paymentRefunds;
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
                    Text(AppLocalizations.of(context)!.paymentRefunds1,
                        style: AppTextStyle.arsenal22Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.paymentRefunds2,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.paymentRefunds3,
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.agreement,
                            style: AppTextStyle.arsenal16LightBold
                                .copyWith(color: AppColors.beige),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SubscriptionAgreementScreen(),
                                  ),
                                );
                              },
                          )
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.refunds,
                        style: AppTextStyle.arsenal22Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.paymentRefunds4,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.paymentRefunds5,
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.agreement,
                            style: AppTextStyle.arsenal16LightBold
                                .copyWith(color: AppColors.beige),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SubscriptionAgreementScreen(),
                                  ),
                                );
                              },
                          )
                        ],
                        style: AppTextStyle.arsenal16Light,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            gapH20,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/confirm_subscription_screen.dart';

class MyAccountProSubscriptionScreen extends StatelessWidget {
  const MyAccountProSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.subscriptionPro;
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
              AppLocalizations.of(context)!.subscriptionProPeriod,
              style: AppTextStyle.arsenal22Light,
            ),
            const SizedBox(height: 12),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _OneMonthCard(),
                    SizedBox(height: 10),
                    _ThreeMonthCard(),
                    SizedBox(height: 10),
                    _SixMonthCard(),
                    SizedBox(height: 10),
                    _OneYearCard(),
                    SizedBox(height: 10),
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

class _OneMonthCard extends StatelessWidget {
  const _OneMonthCard();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.oneMonthUnlimited,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.oneMonthPrice,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.numberOfReports,
                    style: AppTextStyle.arsenal16Light,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyAccountConfirmSubscriptionScreen()),
                      );
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

class _ThreeMonthCard extends StatelessWidget {
  const _ThreeMonthCard();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.threeMonthUnlimited,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.threeMonthPrice,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.numberOfReports,
                    style: AppTextStyle.arsenal16Light,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
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

class _SixMonthCard extends StatelessWidget {
  const _SixMonthCard();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sixMonthUnlimited,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.sixMonthPrice,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.numberOfReports,
                    style: AppTextStyle.arsenal16Light,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
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

class _OneYearCard extends StatelessWidget {
  const _OneYearCard();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.oneYearUnlimited,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.oneYearPrice,
                    style: AppTextStyle.playfairDisplay22Beige,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.numberOfReports,
                    style: AppTextStyle.arsenal16Light,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
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

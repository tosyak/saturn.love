// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/tariffs_screen.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.subscription;
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
          // mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              AppLocalizations.of(context)!.subscriptionHistory,
              style: AppTextStyle.arsenal22Light,
            ),
            const SizedBox(height: 27),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.subscription,
                  style: AppTextStyle.arsenal14LightBold,
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.daysLeft,
                  style: AppTextStyle.arsenal14LightBold,
                ),
                const SizedBox(width: 30),
                Text(
                  AppLocalizations.of(context)!.price,
                  style: AppTextStyle.arsenal14LightBold,
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Flexible(child: _SubscriptionItem()),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TariffsScreen()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.allRates,
                    style: AppTextStyle.arsenal22Light,
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionItem extends StatelessWidget {
  const _SubscriptionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Trial Telegram',
                  style: AppTextStyle.arsenal14Light,
                ),
                Spacer(),
                Text('0', style: AppTextStyle.arsenal14Light),
                SizedBox(width: 30),
                Text('\$ 0,00', style: AppTextStyle.arsenal14Light)
              ],
            ),
            SizedBox(height: 8),
            Text(
              'NULL',
              style: AppTextStyle.arsenal14Light,
            ),
            SizedBox(height: 8),
            Text('ID: 179774 | ID платежа: D9EAA875 |',
                style: AppTextStyle.arsenal10Light),
            Text('Начать: 07 января 2022 | Заканчивается:',
                style: AppTextStyle.arsenal10Light),
            Text('07 января 2022', style: AppTextStyle.arsenal10Light),
            SizedBox(height: 25)
          ],
        );
      },
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/presentation/my_account_group/my_account_report_form_screen.dart';

class MyAccountConfirmSubscriptionScreen extends StatelessWidget {
  const MyAccountConfirmSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.confirmSubscription;
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
                    Row(
                      children: [
                        const Text('#', style: AppTextStyle.arsenal14LightBold),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 7,
                          child: Text(
                              AppLocalizations.of(context)!.subscriptionName,
                              style: AppTextStyle.arsenal14LightBold),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: Text(AppLocalizations.of(context)!.price,
                              style: AppTextStyle.arsenal14LightBold),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _SubscriptionCard(),
                    const SizedBox(height: 24),
                    Text(AppLocalizations.of(context)!.couponCode,
                        style: AppTextStyle.arsenal22Light),
                    const SizedBox(height: 16),
                    const _CouponCodeForm(),
                    const SizedBox(height: 24),
                    Text(AppLocalizations.of(context)!.agreementBox,
                        style: AppTextStyle.arsenal22Light),
                    const _AgreementCheckBox(),
                    Text(AppLocalizations.of(context)!.autoPaymentInfo,
                        style: AppTextStyle.arsenal14Light),
                    const SizedBox(height: 24),
                    const _RussianBankCard(),
                    const SizedBox(height: 16),
                    const _ForeignBankCard(),
                    const SizedBox(height: 16),
                    const _WorldwideBankCard(),
                    const SizedBox(height: 16),
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

class _SubscriptionCard extends StatelessWidget {
  const _SubscriptionCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1', style: AppTextStyle.arsenal14LightBold),
            SizedBox(width: 15),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Подписка на Джйотиш Pro на месяц Джйотиш',
                      style: AppTextStyle.arsenal14Light),
                  SizedBox(height: 8),
                  Text('Полный доступ на месяц к Джйотиш',
                      style: AppTextStyle.arsenal10Light),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: Text('999,00 руб', style: AppTextStyle.arsenal14Light),
            ),
            // SizedBox(width: 60),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 50),
            const Expanded(flex: 7, child: SizedBox()),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.total,
                    style: AppTextStyle.arsenal14Light,
                  ),
                  const SizedBox(height: 16),
                  const Text('999,00 руб', style: AppTextStyle.arsenal14Light),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CouponCodeForm extends StatelessWidget {
  const _CouponCodeForm();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(child: TextFormField()),
          const SizedBox(width: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 40),
              // maximumSize: Size(100, 40),
            ),
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.apply,
              // style: AppTextStyle.arsenal22Light,
            ),
          )
        ],
      ),
    );
  }
}

class _AgreementCheckBox extends StatefulWidget {
  const _AgreementCheckBox();

  @override
  State<_AgreementCheckBox> createState() => _AgreementCheckBoxState();
}

class _AgreementCheckBoxState extends State<_AgreementCheckBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CheckboxListTile(
        activeColor: Colors.transparent,
        checkColor: AppColors.beige,
        contentPadding: const EdgeInsets.all(0),
        side: const BorderSide(color: AppColors.beige),
        value: _isSelected,
        onChanged: (bool) {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: RichText(
          text: TextSpan(
            text: AppLocalizations.of(context)!.accepting,
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.agreement,
                style: AppTextStyle.arsenal10Light
                    .copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyAccountReportFormScreen()),
                      ),
              ),
            ],
            style: AppTextStyle.arsenal10Light,
          ),
        ),
      ),
    );
  }
}

class _RussianBankCard extends StatelessWidget {
  const _RussianBankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.beige,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: AppColors.beige10,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: ScreenSize(context).width,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              AppLocalizations.of(context)!.payOption1,
              style: AppTextStyle.arsenal14Light,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.payOption1Desc,
              style: AppTextStyle.arsenal14LightBold,
            ),
          ]),
        ),
      ),
    );
  }
}

class _ForeignBankCard extends StatelessWidget {
  const _ForeignBankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.beige,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: AppColors.beige10,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: ScreenSize(context).width,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              AppLocalizations.of(context)!.payOption2,
              style: AppTextStyle.arsenal14Light,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.payOption2Desc,
              style: AppTextStyle.arsenal14LightBold,
            ),
          ]),
        ),
      ),
    );
  }
}

class _WorldwideBankCard extends StatelessWidget {
  const _WorldwideBankCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.beige,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: AppColors.beige10,
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: ScreenSize(context).width,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              AppLocalizations.of(context)!.payOption3,
              style: AppTextStyle.arsenal14Light,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.payOption3Desc,
              style: AppTextStyle.arsenal14LightBold,
            ),
          ]),
        ),
      ),
    );
  }
}

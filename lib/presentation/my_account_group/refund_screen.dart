import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';

final TextEditingController _userNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();

final TextEditingController _checkLinkController = TextEditingController();
final TextEditingController _paymentNumberController = TextEditingController();
final TextEditingController _reasoningController = TextEditingController();

class MyAccountRefundScreen extends StatelessWidget {
  const MyAccountRefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.refunds;
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
                    Text(AppLocalizations.of(context)!.requestRefund,
                        style: AppTextStyle.arsenal22Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund1,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund2,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund3,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund4,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund5,
                        style: AppTextStyle.arsenal12Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund6,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.payerInfo,
                        style: AppTextStyle.arsenal16BeigeBold),
                    const SizedBox(height: 16),
                    const _PayerInfoForm(),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.paymentData,
                        style: AppTextStyle.arsenal16BeigeBold),
                    const SizedBox(height: 16),
                    const _PaymentInfoForm(),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.requestRefund8,
                        style: AppTextStyle.arsenal16Light),
                    const SizedBox(height: 16),
                    const _SubmitButton(),
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

class _PayerInfoForm extends StatelessWidget {
  const _PayerInfoForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.fullName,
            style: AppTextStyle.arsenal12Light),
        TextFormField(
          onChanged: (value) => _userNameController.text = value,
        ),
        const SizedBox(height: 16),
        Text('${AppLocalizations.of(context)!.email}*',
            style: AppTextStyle.arsenal12Light),
        TextFormField(
          onChanged: (value) => _emailController.text = value,
        ),
      ],
    );
  }
}

class _PaymentInfoForm extends StatelessWidget {
  const _PaymentInfoForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.linkToCheck,
                      style: AppTextStyle.arsenal12Light),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) => _checkLinkController.text = value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.checkScreenShot,
                      style: AppTextStyle.arsenal12Light),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      // maximumSize: Size(100, 40),
                    ),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.select,
                      // style: AppTextStyle.arsenal22Light,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.paymentNumber,
            style: AppTextStyle.arsenal12Light),
        SizedBox(
          height: 40,
          child: TextFormField(
            onChanged: (value) => _paymentNumberController.text = value,
          ),
        ),
        const SizedBox(height: 16),
        Text(AppLocalizations.of(context)!.groundsForRefund,
            style: AppTextStyle.arsenal12Light),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintText: AppLocalizations.of(context)!.requestRefund7,
            hintStyle: AppTextStyle.arsenal12Light
                .copyWith(color: const Color(0x78F5F5F5)),
          ),
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => _reasoningController.text = value,
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {},
          child: Text(AppLocalizations.of(context)!.sendRequest),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';

TextEditingController _emailController = TextEditingController();

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.forgotpass;
    final appBarHeight = AppBarHeightCalc(title: title, width: screenWidth);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: appBarLeadingWidth,
        toolbarHeight: appBarHeight.calculateLeadingHeight(),
        title: Text(title),
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          padding: ConstantSize.screenPadding,
          decoration: const BoxDecoration(
            image: DecorationImage(
              scale: 3.5,
              image: AssetImage(
                "assets/images/moon.png",
              ),
              alignment: Alignment(0, 0.9),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Text(
                  AppLocalizations.of(context)!.forgotpasshint,
                  style: AppTextStyle.arsenal14Light,
                ),
                const SizedBox(height: 40),
                _ResetPassEmail(emailController: _emailController),
                const SizedBox(height: 36),
                _SubmitButton(
                  email: _emailController.text,
                ),
              ],
            ),
          )),
    );
  }
}

class _ResetPassEmail extends StatelessWidget {
  const _ResetPassEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.email,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _emailController.text = value,
            // controller: emailController,
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  // final AuthService _authService = FirebaseAuthService(
  //   authService: FirebaseAuth.instance,
  // );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {
            try {
              // await _authService.createUserWithEmailAndPassword(
              //   email: _emailController.text,
              //   password: _passwordController.text,
              //   name: _userNameController.text,
              // );
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => Home(),
              //   ),
              // );
            } catch (e) {
              // print(e);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
          child: Text(AppLocalizations.of(context)!.send),
        ),
      ),
    );
  }
}

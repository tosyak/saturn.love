import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/auth_screen/auth_loader_screen.dart';
import 'package:saturn/bloc/google_auth_bloc.dart';
import 'package:saturn/utils/url_launcher.dart';
import 'package:saturn/bloc/vk_auth_bloc.dart';
import 'package:saturn/bloc/yandex_auth_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/bloc/sign_in_screen_bloc.dart';

final TextEditingController _loginController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.signIn;
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
            image: AssetImage("assets/images/auth_background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SignInEmail(loginController: _loginController),
              _SignInPassword(passwordController: _passwordController),
              const SizedBox(height: 30.0),
              const _SubmitButton(),
              const SizedBox(height: 30.0),
              const _SignInWithSocial(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInEmail extends StatelessWidget {
  const _SignInEmail({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final TextEditingController loginController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(AppLocalizations.of(context)!.login),
            const Text(' / email'),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _loginController.text = value,
          ),
        ),
        Align(
          heightFactor: 0.5,
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () async {
                final String languageCode =
                    await LocaleHiveBox().getLocaleHive();
                languageCode == 'ru'
                    ? UrlLauncher()
                        .launchLink('https://saturn.love/ru/restore.html')
                    : UrlLauncher()
                        .launchLink('https://saturn.love/en/restore.html');
              },
              child: Text(
                AppLocalizations.of(context)!.forgotlogin,
                style: AppTextStyle.arsenal12Light
                    .copyWith(decoration: TextDecoration.underline),
              )),
        )
      ],
    );
  }
}

class _SignInPassword extends StatefulWidget {
  const _SignInPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<_SignInPassword> createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<_SignInPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.password,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            obscureText: _obscureText,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashRadius: 18,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.beige,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: (value) => _passwordController.text = value,
          ),
        ),
        Align(
          heightFactor: 0.5,
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () async {
                final String languageCode =
                    await LocaleHiveBox().getLocaleHive();

                languageCode == 'ru'
                    ? UrlLauncher()
                        .launchLink('https://saturn.love/ru/passedit.html')
                    : UrlLauncher()
                        .launchLink('https://saturn.love/en/passedit.html');
              },
              child: Text(
                AppLocalizations.of(context)!.forgotpass,
                style: AppTextStyle.arsenal12Light
                    .copyWith(decoration: TextDecoration.underline),
              )),
        )
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
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInNotTUser) {
          showSnackBarWidget(
              AppLocalizations.of(context)!.invalidLogin, context);
        } else if (state is SignInError) {
          showSnackBarWidget(
              AppLocalizations.of(context)!.invalidPassword, context);
        } else if (state is SignInSuccess) {
          context.goNamed(AppPage.splash.toName);
        }
      },
      child: ElevatedButton(
        onPressed: () async {
          bool stringIsEmail = EmailValidator.validate(_loginController.text);
          if (_loginController.text == '' || _passwordController.text == '') {
            showSnackBarWidget(
                AppLocalizations.of(context)!.fillAllFields, context);
          } else {
            BlocProvider.of<SignInBloc>(context).add(SignInRequest(
                email: stringIsEmail ? _loginController.text : '',
                username: _loginController.text,
                password: _passwordController.text));
          }
        },
        child: Text(AppLocalizations.of(context)!.logIn),
      ),
    );
  }
}

class _SignInWithSocial extends StatelessWidget {
  const _SignInWithSocial();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.singInWith,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 30),
        const _SignInWithGoogle(),
        gapH24,
        const _SignInWithYandex(),
        gapH24,
        const _SignInWithVK(),
        gapH24,
      ],
    );
  }
}

class _SignInWithGoogle extends StatelessWidget {
  const _SignInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {},
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          BlocProvider.of<GoogleAuthBloc>(context).add(GoogleAuthSignIn());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInLoaderScreen()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 18,
                height: 18,
                child: Image.asset('assets/images/google_button_icon.png')),
            gapW24,
            Text(
              AppLocalizations.of(context)!.loginGoogle,
              style: AppTextStyle.arsenal16Light
                  .copyWith(color: Colors.grey.shade700),
            )
          ],
        ),
      ),
    );
  }
}

class _SignInWithYandex extends StatelessWidget {
  const _SignInWithYandex();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () {
        BlocProvider.of<YandexAuthBloc>(context).add(YandexAuthSignIn());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInLoaderScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 18,
              height: 18,
              child: Image.asset('assets/images/yandex_button_icon.png')),
          gapW24,
          Text(
            AppLocalizations.of(context)!.loginYandex,
            style: AppTextStyle.arsenal16Light.copyWith(color: Colors.black),
          )
        ],
      ),
      // ),
    );
  }
}

class _SignInWithVK extends StatelessWidget {
  const _SignInWithVK();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4376A6)),
      onPressed: () async {
        BlocProvider.of<VKAuthBloc>(context).add(SignInWithVK());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInLoaderScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 18,
              height: 18,
              child: Image.asset('assets/images/vk_button_icon.png')),
          gapW24,
          Text(
            AppLocalizations.of(context)!.loginVK,
            style: AppTextStyle.arsenal16Light.copyWith(color: Colors.white),
          )
        ],
      ),
      // ),
    );
  }
}

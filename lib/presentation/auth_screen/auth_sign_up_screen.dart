import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/navigation/app_router.dart';
import 'package:saturn/presentation/auth_screen/auth_loader_screen.dart';
import 'package:saturn/bloc/google_auth_bloc.dart';
import 'package:saturn/bloc/vk_auth_bloc.dart';
import 'package:saturn/bloc/yandex_auth_bloc.dart';
import 'package:saturn/presentation/widgets/snackbar_widget.dart';
import 'package:saturn/bloc/sign_up_screen_bloc.dart';

TextEditingController _loginController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.signUp;
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
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SignUpUserName(),
              gapH12,
              _SignUpUserEmail(),
              gapH12,
              _SignUpPassword(),
              SizedBox(height: 30.0),
              _SubmitButton(),
              SizedBox(height: 30.0),
              _SignUpWithSocial(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpUserName extends StatelessWidget {
  const _SignUpUserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.login),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _loginController.text = value,
          ),
        ),
      ],
    );
  }
}

class _SignUpUserEmail extends StatelessWidget {
  const _SignUpUserEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email'),
        const SizedBox(height: 8),
        SizedBox(
          height: ConstantSize.textFieldHeight,
          child: TextFormField(
            onChanged: (value) => _emailController.text = value,
          ),
        ),
      ],
    );
  }
}

class _SignUpPassword extends StatefulWidget {
  const _SignUpPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<_SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<_SignUpPassword> {
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
        const SizedBox(height: 4),
        Text(
          AppLocalizations.of(context)!.minimumSix,
          style: AppTextStyle.arsenal12Light
              .copyWith(decoration: TextDecoration.underline),
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
    bool validateLatinInput() {
      RegExp latinRegex = RegExp(r'^[a-zA-Z0-9!@#$%^&*:";()-_=+<>,./?]*$');
      bool emailIsValid = latinRegex.hasMatch(_emailController.text);
      bool loginIsValid = latinRegex.hasMatch(_loginController.text);

      if (emailIsValid && loginIsValid) {
        return true;
      } else {
        showSnackBarWidget(AppLocalizations.of(context)!.useOnlyLatin, context);
        return false;
      }
    }

    bool validateEmptyForm() {
      if (_loginController.text == '' ||
          _passwordController.text == '' ||
          _emailController.text == '') {
        showSnackBarWidget(
            AppLocalizations.of(context)!.fillAllFields, context);
        return false;
      } else {
        return true;
      }
    }

    bool validatePasswordLength() {
      if (_passwordController.text.length < 6) {
        showSnackBarWidget(
            AppLocalizations.of(context)!.passwordTooShort, context);
        return false;
      } else {
        return true;
      }
    }

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.goNamed(AppPage.getReportForm.toName);
        } else if (state is SignUpFindEmail) {
          showSnackBarWidget(AppLocalizations.of(context)!.emailInUse, context);
        } else if (state is SignUpFindUser) {
          showSnackBarWidget(
              AppLocalizations.of(context)!.usernameInUse, context);
        } else if (state is SignUpInvalidEmail) {
          showSnackBarWidget(AppLocalizations.of(context)!.checkEmail, context);
        } else if (state is SignUpError) {
          showSnackBarWidget('Sign up error', context);
        }
      },
      child: ElevatedButton(
        onPressed: () {
          if (validateEmptyForm() &&
              validateLatinInput() &&
              validatePasswordLength()) {
            BlocProvider.of<SignUpBloc>(context).add(SignUpRequest(
                username: _loginController.text,
                email: _emailController.text,
                password: _passwordController.text));
          }
        },
        child: Text(AppLocalizations.of(context)!.signUp),
      ),
    );
  }
}

class _SignUpWithSocial extends StatelessWidget {
  const _SignUpWithSocial();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.singUpWith,
          style: AppTextStyle.arsenal16Light,
        ),
        const SizedBox(height: 30),
        const _SignUpWithGoogle(),
        gapH24,
        const _SignUpWithYandex(),
        gapH24,
        const _SignUpWithVK(),
        gapH24,
      ],
    );
  }
}

class _SignUpWithGoogle extends StatelessWidget {
  const _SignUpWithGoogle();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () async {
        BlocProvider.of<GoogleAuthBloc>(context).add(GoogleAuthSignUp());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpLoaderScreen()),
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
            AppLocalizations.of(context)!.signupGoogle,
            style: AppTextStyle.arsenal16Light
                .copyWith(color: Colors.grey.shade700),
          )
        ],
      ),
      // ),
    );
  }
}

class _SignUpWithYandex extends StatelessWidget {
  const _SignUpWithYandex();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () {
        BlocProvider.of<YandexAuthBloc>(context).add(YandexAuthSignUp());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpLoaderScreen()),
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
            AppLocalizations.of(context)!.signupYandex,
            style: AppTextStyle.arsenal16Light.copyWith(color: Colors.black),
          )
        ],
      ),
      // ),
    );
  }
}

class _SignUpWithVK extends StatelessWidget {
  const _SignUpWithVK();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4376A6)),
      onPressed: () async {
        BlocProvider.of<VKAuthBloc>(context).add(SignUpWithVK());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpLoaderScreen()),
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
            AppLocalizations.of(context)!.signupVK,
            style: AppTextStyle.arsenal16Light.copyWith(color: Colors.white),
          )
        ],
      ),
      // ),
    );
  }
}

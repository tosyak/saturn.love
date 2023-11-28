import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:saturn/config/app_bar_config.dart';
import 'package:saturn/config/app_colors.dart';
import 'package:saturn/config/app_text_style.dart';
import 'package:saturn/config/constants.dart';
import 'package:saturn/utils/url_launcher.dart';

class MyAccountAboutUsScreen extends StatelessWidget {
  const MyAccountAboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize(context).width;
    final double screenHeight = ScreenSize(context).height;
    final String title = AppLocalizations.of(context)!.aboutUs;
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
                    const _AboutUs(),
                    // gapH16,
                    // Text(
                    //   AppLocalizations.of(context)!.reviews,
                    //   style: AppTextStyle.arsenal22Light,
                    // ),
                    // gapH16,
                    // const SizedBox(
                    //   height: 230,
                    //   child: CarouselWithIndicatorDemo(),
                    // ),
                    const SizedBox(height: 26),
                    Text(
                      AppLocalizations.of(context)!.details,
                      style: AppTextStyle.arsenal22Light,
                    ),
                    gapH16,
                    Text(
                      AppLocalizations.of(context)!.owner,
                      style: AppTextStyle.arsenal16BeigeBold,
                    ),
                    gapH16,
                    const _Details(),
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

class _AboutUs extends StatelessWidget {
  const _AboutUs();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.whoDid,
          style: AppTextStyle.arsenal22Light,
        ),
        gapH16,
        RichText(
          text: TextSpan(
            text: AppLocalizations.of(context)!.catherine,
            style: AppTextStyle.arsenal16BeigeBold,
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.catherineIs,
                style: AppTextStyle.arsenal16Light,
              )
            ],
          ),
        ),
        gapH16,
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.socialMedia,
              style: AppTextStyle.arsenal16Light,
            ),
            IconButton(
              onPressed: () {
                UrlLauncher().launchLink(
                    'https://instagram.com/kzavaley?igshid=MWI4MTIyMDE=');
              },
              icon: const ImageIcon(
                AssetImage('assets/images/instagram_icon.png'),
                color: AppColors.beige,
              ),
            ),
          ],
        ),
        gapH16,
        RichText(
          text: TextSpan(
            text: AppLocalizations.of(context)!.sergey,
            style: AppTextStyle.arsenal16BeigeBold,
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.sergeyIs,
                style: AppTextStyle.arsenal16Light,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.email,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                'support@saturn.love',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.legalAddress,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.legalAddress1,
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.inn,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '643905793610',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.ogrn,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '313643914700015',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.paymentAccount,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '40802810000000025402',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.bank,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.bank1,
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.bankAddress,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.bankAddress1,
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.corrBankAcc,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '30101810145250000974',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.bankInn,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '7710140679',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.bankBic,
                style: AppTextStyle.arsenal12LightBold,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                '044525974',
                style: AppTextStyle.arsenal12Light,
              ),
            )
          ],
        ),
      ],
    );
  }
}

// final List<Widget> reviews = [
//   Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: AppColors.beige,
//         style: BorderStyle.solid,
//         width: 1.0,
//       ),
//       color: AppColors.beige10,
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     // width: ScreenSize(context).width,
//     child: Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               minRadius: 23,
//               maxRadius: 23,
//               // child: Image.asset('assets/images/avatar_image.png'),
//               child: Image.asset('assets/images/moon.png'),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Наталья М.',
//               style: AppTextStyle.arsenal16LightBold,
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           'Купила подписку на вашем сайте и уже несколько часов любуюсь своей картой со всех сторон. Всё, что вы делаете, просто уникально!',
//           style: AppTextStyle.arsenal12Light,
//         )
//       ],
//     ),
//   ),
//   Container(
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: AppColors.beige,
//         style: BorderStyle.solid,
//         width: 1.0,
//       ),
//       color: AppColors.beige10,
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     // width: ScreenSize(context).width,
//     child: Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               minRadius: 23,
//               maxRadius: 23,
//               // child: Image.asset('assets/images/avatar_image.png'),
//               child: Image.asset('assets/images/moon.png'),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Наталья М.',
//               style: AppTextStyle.arsenal16LightBold,
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           'Купила подписку на вашем сайте и уже несколько часов любуюсь своей картой со всех Купила подписку на вашем сайте и уже несколько часов любуюсь своей картой со всех Купила подписку на вашем сайте и уже несколько часов любуюсь своей картой со всех сторон. Всё, что вы делаете, просто уникально!',
//           style: AppTextStyle.arsenal12Light,
//         )
//       ],
//     ),
//   ),
// ];

// class CarouselWithIndicatorDemo extends StatefulWidget {
//   const CarouselWithIndicatorDemo({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _CarouselWithIndicatorState();
//   }
// }

// class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
//   int _current = 0;
//   final CarouselController _controller = CarouselController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Expanded(
//         child: CarouselSlider(
//           items: reviews,
//           carouselController: _controller,
//           options: CarouselOptions(
//               autoPlay: false,
//               enlargeCenterPage: true,
//               aspectRatio: 2,
//               viewportFraction: 1,
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _current = index;
//                 });
//               }),
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: reviews.asMap().entries.map((entry) {
//           return GestureDetector(
//             onTap: () => _controller.animateToPage(entry.key),
//             child: Container(
//               width: 8.0,
//               height: 8.0,
//               margin:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: (Theme.of(context).brightness == Brightness.dark
//                           ? AppColors.beige
//                           : AppColors.beige50)
//                       .withOpacity(_current == entry.key ? 0.9 : 0.4)),
//             ),
//           );
//         }).toList(),
//       ),
//     ]);
//   }
// }

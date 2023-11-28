import 'package:saturn/data/repository/api_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future<void> launchTelegram(
    String urlString,
  ) async {
    final Uri url = Uri.parse(urlString);
    final canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not open the TG.');
    }
  }

  Future<void> launchLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> openDialer(String phoneNumber) async {
    Uri callUrl = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw Exception('Could not open the dialler.');
    }
  }

  Future<void> sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'saturn.love',
        'body': '',
      },
    );
    final canLaunch = await canLaunchUrl(emailLaunchUri);
    if (canLaunch) {
      await launchUrl(emailLaunchUri);
    } else {
      throw Exception('Could not send mail.');
    }
  }
}

enum LinkType {
  subscribeRu,
  cancelSubscriptionRu,
  refundRu,
  subscribe,
  cancelSubscription,
  refund,
}

class LoginLinkLauncher {
  final repository = SiteLoginRepository();

  makeLoginLink(Map<String, dynamic> response, Enum linkType) async {
    switch (linkType) {
      case LinkType.cancelSubscriptionRu:
        UrlLauncher().launchLink(
            'https://saturn.love/ru/otmenit-podpisku.html/?login_token=${response['token']}');
        break;
      case LinkType.subscribeRu:
        UrlLauncher().launchLink(
            'https://saturn.love/ru/sub/vedic.html/?login_token=${response['token']}');
        break;
      case LinkType.refundRu:
        UrlLauncher().launchLink(
            'https://saturn.love/ru/vozvrat-sredstv.html/?login_token=${response['token']}');
        break;
      case LinkType.cancelSubscription:
        UrlLauncher().launchLink(
            'https://saturn.love/en/otmenit-podpisku.html/?login_token=${response['token']}');
        break;
      case LinkType.subscribe:
        UrlLauncher().launchLink(
            'https://saturn.love/en/sub/vedic.html/?login_token=${response['token']}');
        break;
      case LinkType.refund:
        UrlLauncher().launchLink(
            'https://saturn.love/en/vozvrat-sredstv.html/?login_token=${response['token']}');
        break;

      default:
    }
  }

  Future<void> fetchResourcesListApi(Enum linkType) async {
    final Map<String, dynamic> response = await repository.loginLinkApi();
    makeLoginLink(response, linkType);
  }
}

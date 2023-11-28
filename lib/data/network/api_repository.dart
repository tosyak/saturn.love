import 'package:saturn/data/network/api_endpoints.dart';
import 'package:saturn/data/network/api_services.dart';
import 'package:saturn/data/repository/hive_repository.dart';
import 'package:saturn/data/repository/shared_preferences.dart';
import 'package:saturn/utils/logger.dart';

class ReportsListRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> getReportsListResponse() async {
    final int? userId = await UserSharedPreferences().getUserId();
    final Map<String, int?> reportListRequestMap = {"user_id": userId};
    final dynamic response = await apiServices.getApiResponse(
        AppUrl.reportsListUrl, reportListRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getReportsListResponse error $e, stackTrace $stackTrace');
    }
  }
}

class ReportRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> getReportResponse(int reportIndex) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final int? userId = await UserSharedPreferences().getUserId();
    final Map<String, dynamic> reportRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
      "type": "default",
      "lang": languageCode
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.reportUrl, reportRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getReportResponse error $e, stackTrace $stackTrace');
    }
  }

  Future<Map<String, dynamic>> getReportAlternateResponse(
      int reportIndex) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final int? userId = await UserSharedPreferences().getUserId();
    final reportRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
      "type": "alternate",
      "lang": languageCode
    };
    try {
      dynamic response =
          await apiServices.getApiResponse(AppUrl.reportUrl, reportRequestMap);

      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getReportAlternateResponse error $e, stackTrace $stackTrace');
    }
  }
}

class CreateReportRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> createReportRequest(
    int userId,
    String name,
    String datetime,
    int timelite,
    String city,
    String timezone,
    int offset,
    double lat,
    double lng,
    int transite,
    int moon,
  ) async {
    final newReportRequestMap = {
      "user_id": userId,
      "name": name,
      "datetime": datetime,
      "timelite": timelite,
      "city": city,
      "timezone": timezone,
      "offset": offset,
      "lat": lat,
      "lng": lng,
      "transite": 1,
      "moon": 1,
    };

    logger.i(newReportRequestMap);

    try {
      dynamic response = await apiServices.getApiResponse(
          AppUrl.newReportUrl, newReportRequestMap);
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository createReportRequest error $e, stackTrace $stackTrace');
    }
  }
}

class DeleteReportRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> deleteReportRequest(int reportIndex) async {
    final int? userId = await UserSharedPreferences().getUserId();
    final deleteReportRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
    };
    dynamic response = await apiServices.getApiResponse(
        AppUrl.deleteReportUrl, deleteReportRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository deleteReportRequest error $e, stackTrace $stackTrace');
    }
  }
}

class EditFavoriteRepository {
  BaseApiServices apiServices = ApiService();

  Map<String, dynamic> createRequestDataMap({
    String? favorite,
    String? groups,
  }) {
    Map<String, dynamic> requestMap = {};
    if (favorite != null) requestMap['favorite'] = favorite;
    if (groups != null) requestMap['groups'] = groups;
    return requestMap;
  }

  Future<Map<String, dynamic>> editUserDataRequest({
    required int userId,
    required int reportId,
    String? favorite,
    String? groups,
  }) async {
    final Map<String, dynamic> setReportMap = createRequestDataMap(
      favorite: favorite,
      groups: groups,
    );
    final editUserRequestMap = {
      "user_id": userId,
      "ord": reportId,
      "set_report": setReportMap,
    };
    logger.i(editUserRequestMap);

    dynamic response = await apiServices.getApiResponse(
        AppUrl.editReportUrl, editUserRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository editUserDataRequest error $e, stackTrace $stackTrace');
    }
  }
}

class EditUserDataRepository {
  BaseApiServices apiServices = ApiService();

  Map<String, dynamic> createRequestDataMap({
    String? title,
    String? datar,
    String? timer,
    String? city,
    double? dl,
    double? sh,
    String? p,
    int? timelite,
  }) {
    Map<String, dynamic> requestMap = {};
    if (title != null) requestMap['title'] = title;
    if (datar != null) requestMap['datar'] = datar;
    if (timer != null) requestMap['timer'] = timer;
    if (city != null) requestMap['city'] = city;
    if (dl != null) requestMap['dl'] = dl;
    if (sh != null) requestMap['sh'] = sh;
    if (p != null) requestMap['p'] = p;
    if (timelite != null) requestMap['timelite'] = timelite;
    return requestMap;
  }

  Future<Map<String, dynamic>> editUserDataRequest({
    required int userId,
    required int reportId,
    String? title,
    String? datar,
    String? timer,
    String? city,
    double? dl,
    double? sh,
    String? p,
    int? timelite,
  }) async {
    final Map<String, dynamic> setReportMap = createRequestDataMap(
      title: title,
      datar: datar,
      timer: timer,
      city: city,
      dl: dl,
      sh: sh,
      p: p,
      timelite: timelite,
    );
    final editReportMap = {
      "user_id": userId,
      "ord": reportId,
      "set_report": setReportMap,
    };
    logger.i(editReportMap);

    dynamic response =
        await apiServices.getApiResponse(AppUrl.editReportUrl, editReportMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository editUserDataRequest error $e, stackTrace $stackTrace');
    }
  }
}

class SadiSatiRepository {
  BaseApiServices apiServices = ApiService();

  Future<Map<String, dynamic>> getSadiSatiResponse(int reportIndex) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final int? userId = await UserSharedPreferences().getUserId();
    final sadiSatiRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
      "type": "sadisati",
      "lang": languageCode
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.reportUrl, sadiSatiRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getSadiSatiResponse error $e, stackTrace $stackTrace');
    }
  }
}

class MoonRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> getMoonCalendarResponse(
      int reportIndex, String date) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final int? userId = await UserSharedPreferences().getUserId();
    final moonRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
      "type": "moon",
      "lang": languageCode,
      "date": date
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.reportUrl, moonRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getMoonCalendarResponse error $e, stackTrace $stackTrace');
    }
  }
}

class TransitsRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> getTransitsResponse(
      int reportIndex, String date) async {
    final String languageCode = await LocaleHiveBox().getLocaleHive();
    final int? userId = await UserSharedPreferences().getUserId();
    final reportRequestMap = {
      "ord": reportIndex,
      "user_id": userId,
      "type": "transite",
      "lang": languageCode,
      "date": date
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.reportUrl, reportRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository getTransitsResponse error $e, stackTrace $stackTrace');
    }
  }
}

class SignInRepository {
  BaseApiServices apiServices = ApiService();

  Future<Map<String, dynamic>> signInRequest({
    required String username,
    required String password,
    required String email,
  }) async {
    final loginRequestMap = {
      "email": email,
      "username": username,
      "password": password,
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.loginUrl, loginRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository signInRequest error $e, stackTrace $stackTrace');
    }
  }
}

class SignUpRepository {
  BaseApiServices apiServices = ApiService();

  Future<Map<String, dynamic>> signUpRequest({
    required String username,
    required String email,
    required String password,
  }) async {
    final signUpRequestMap = {
      "username": username,
      "email": email,
      "password": password,
    };
    dynamic response = await apiServices.getApiResponse(
        AppUrl.createUserUrl, signUpRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository signUpRequest error $e, stackTrace $stackTrace');
    }
  }
}

class SocialSignInRepository {
  BaseApiServices apiServices = ApiService();

  Future<Map<String, dynamic>> socialSignInRequest({
    required String email,
    required String provider,
  }) async {
    final loginRequestMap = {
      "email": email,
      "username": email,
      "provider": provider,
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.loginUrl, loginRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository socialSignInRequest error $e, stackTrace $stackTrace');
    }
  }
}

class SocialSignUpRepository {
  BaseApiServices apiServices = ApiService();

  Future<Map<String, dynamic>> socialSignUpRequest({
    required String email,
    required String provider,
  }) async {
    final loginRequestMap = {
      "email": email,
      "username": email,
      "provider": provider,
    };
    dynamic response =
        await apiServices.getApiResponse(AppUrl.createUserUrl, loginRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository socialSignUpRequest error $e, stackTrace $stackTrace');
    }
  }
}

class SiteLoginRepository {
  BaseApiServices apiServices = ApiService();
  Future<Map<String, dynamic>> loginLinkApi() async {
    final int? userId = await UserSharedPreferences().getUserId();
    final loginRequestMap = {
      "user_id": userId,
      "count": 999,
      "period": "P10DT3H"
    };
    dynamic response = await apiServices.getApiResponse(
        'https://saturn.love/get_token', loginRequestMap);
    try {
      return response;
    } catch (e, stackTrace) {
      throw Exception(
          'Api repository loginLinkApi error $e, stackTrace $stackTrace');
    }
  }
}
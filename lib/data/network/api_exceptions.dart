// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  AppExceptions([this._message, this._prefix]);
  final _message;
  final _prefix;
  @override
  String toString() {
    return " $_prefix $_message";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException({String? message})
      : super(message, "Error During Communication");
}

class BadRequestException extends AppExceptions {
  BadRequestException({String? message}) : super(message, "Invalid Request");
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException({String? message})
      : super(message, "Unauthorized request");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({String? message}) : super(message, "Invalid Input");
}

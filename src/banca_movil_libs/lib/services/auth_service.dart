import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:banca_movil_libs/services/audit_service.dart';

class AuthService {
  Future<UserModel> validateUserNameExists(
    String userName, {
    required int channel,
  }) async {
    try {
      final response = await dioClient.post(
        'Authenticate/validate-user-by-username?channel=1',
        data: {'username': userName, "rememberMe": true, "trustedDevice": true},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuditService.logEvent(
          "Validar username",
          AuditActionType.resourceValidation,
        );
        // return response.data["token"];
        final user = UserModel.fromJson(response.data);

        return user;
      } else {
        throw Exception('Failed to login');
      }
    } on Exception {
      AuditService.logEvent("Error", AuditActionType.error);
      rethrow;
    }
  }
  // Future<String> validateUserNameExists(String userName) async {
  //   try {
  //     final response = await dioClient.post(
  //       'Authenticate/username',
  //       data: {'username': userName, "rememberMe": true, "trustedDevice": true},
  //     );

  Future<UserModel> loginUser(String userName, String password) async {
    try {
      final response = await dioClient.post(
        'Authenticate?channel=3',
        data: {
          'username': userName,
          'password': password,
          "rememberMe": true,
          "trustedDevice": true,
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuditService.logEvent("Login usuario", AuditActionType.login);
        final user = UserModel.fromJson(response.data);

        return user;
      } else {
        throw Exception(response.data["errorKey"] ?? 'Failed to login');
      }
    } on Exception {
      AuditService.logEvent("Error", AuditActionType.error);
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      final response = await dioClient.get('Authenticate/logout?logoutType=1');

      if (response.statusCode! >= 400) {
        throw Exception('Failed to logout ${response.data}');
      } else {
        AuditService.logEvent("Logout usuario", AuditActionType.logout);
      }
    } on Exception {
      rethrow;
    }
  }
}

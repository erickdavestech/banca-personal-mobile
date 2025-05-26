import 'package:banca_movil_libs/banca_movil_libs.dart';

class AuthController {
  static final AuthService _authService = AuthService();

  static Future<UserModel> loginUser(String userName, String password) async {
    try {
      final user = await _authService.loginUser(userName, password);
      // final data = JwtDecoder.decode(info.token);
      // final user = UserModel.fromJson(data);
      await preferences.setClientID(user.user?.clientNumber ?? '');
      await preferences.setToken(user.token ?? '');
      await preferences.setName(user.user?.name ?? '');

      await preferences.setUsuario(userName);
      await preferences.setUsuarioFaceID(userName);
      await preferences.setPassword(password);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> validateUserNameExists(
    String userName, {
    required int channel,
  }) async {
    try {
      final user = await _authService.validateUserNameExists(
        userName,
        channel: channel,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logOut() async {
    try {
      await _authService.logoutUser();
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final preferences = SecurePreferences();

class SecurePreferences {
  static final SecurePreferences _instancia = SecurePreferences._internal();

  factory SecurePreferences() => _instancia;

  SecurePreferences._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // 🔄 Cache en memoria
  String _cachedToken = '';
  String _cachedUser = '';
  String _cachedUserFaceID = '';
  String _cachedPass = '';
  String _cachedLanguaje = 'es';
  String _cachedClientID = '';
  bool _cachedFaceIdEnabled = false;
  String _name = '';
  bool _deviceRegistered = false;

  /// Inicializa los datos y los cachea
  Future<void> init() async {
    // _cachedToken = await _getEncrypted('uToken');
    // _cachedUser = await _getEncrypted('uUsuario');
    // _cachedUserFaceID = await _getEncrypted('uUsuarioFaceID');
    // _cachedPass = await _getEncrypted('uPassword');
    _cachedToken = await _secureStorage.read(key: 'uToken') ?? '';
    _cachedUser = await _secureStorage.read(key: 'uUsuario') ?? '';
    _cachedUserFaceID = await _secureStorage.read(key: 'uUsuarioFaceID') ?? '';
    _cachedPass = await _secureStorage.read(key: 'uPassword') ?? '';
    _cachedLanguaje = await _secureStorage.read(key: 'uLanguaje') ?? 'es';
    _cachedClientID = await _secureStorage.read(key: 'uClientID') ?? '';

    final faceIdStr = await _secureStorage.read(key: 'uFaceIdEnabled');
    _cachedFaceIdEnabled = faceIdStr == "true";
    _name = await _secureStorage.read(key: 'uName') ?? '';
    final deviceRegisteredStr =
        await _secureStorage.read(key: 'uDeviceRegistered') ?? '';
    _deviceRegistered = deviceRegisteredStr == "true";
  }

  // Cifrado / Descifrado
  // String _encrypt(String plainText) {
  //   final encrypt = EncryptHelper.encryptData(EncryptType.encrypt, plainText);

  //   return encrypt;
  // }

  // String _decrypt(String? encryptedText) {
  //   try {
  //     final encrypt = EncryptHelper.encryptData(
  //       EncryptType.decrypt,
  //       encryptedText ?? "",
  //     );

  //     return encrypt;
  //   } on Exception catch (e) {
  //     log('Error al desencriptar: $e');
  //     throw Exception('Error al desencriptar $e');
  //   }
  // }

  // Future<String> _getEncrypted(String key) async {
  //   final encrypted = await _secureStorage.read(key: key);
  //   return _decrypt(encrypted);
  // }

  // Future<void> _setEncrypted(String key, String value) async {
  //   if (value.isEmpty) return;

  //   final encrypted = _encrypt(value);
  //   await _secureStorage.write(key: key, value: encrypted);
  // }

  // ---------------- Getters sincronizados (prefijados con 'u') ----------------

  String get uToken => _cachedToken;
  String get uUsuario => _cachedUser;
  String get uUsuarioFaceID => _cachedUserFaceID;
  String get uPassword => _cachedPass;
  String get uLanguaje => _cachedLanguaje;
  String get uClientID => _cachedClientID;
  bool get uFaceIdEnabled => _cachedFaceIdEnabled;
  String get uName => _name;
  bool get uDeviceRegistered => _deviceRegistered;

  // ---------------- Setters asincrónicos ----------------

  Future<void> setToken(String value) async {
    _cachedToken = value;
    // await _setEncrypted('uToken', value);
    await _secureStorage.write(key: 'uToken', value: value);
  }

  Future<void> setUsuario(String value) async {
    _cachedUser = value;
    // await _setEncrypted('uUsuario', value);
    await _secureStorage.write(key: 'uUsuario', value: value);
  }

  Future<void> setUsuarioFaceID(String value) async {
    _cachedUserFaceID = value;
    // await _setEncrypted('uUsuarioFaceID', value);
    await _secureStorage.write(key: 'uUsuarioFaceID', value: value);
  }

  Future<void> setPassword(String value) async {
    _cachedPass = value;
    // await _setEncrypted('uPassword', value);
    await _secureStorage.write(key: 'uPassword', value: value);
  }

  Future<void> setName(String value) async {
    _name = value;
    await _secureStorage.write(key: 'uName', value: value);
  }

  Future<void> setLanguaje(String value) async {
    _cachedLanguaje = value;
    await _secureStorage.write(key: 'uLanguaje', value: value);
  }

  Future<void> setClientID(String value) async {
    _cachedClientID = value;
    await _secureStorage.write(key: 'uClientID', value: value.toString());
  }

  Future<void> setFaceIdEnabled(bool value) async {
    _cachedFaceIdEnabled = value;
    await _secureStorage.write(key: 'uFaceIdEnabled', value: value.toString());
  }

  Future<void> setDeviceRegistered(bool value) async {
    _deviceRegistered = value;
    await _secureStorage.write(
      key: 'uDeviceRegistered',
      value: value.toString(),
    );
  }

  // ---------------- Reset de preferencias ----------------

  Future<void> delPrefs() async {
    await setToken('');
    await setUsuario('');
    await setPassword('');
    await setLanguaje('es');
    await setClientID("");
    // await setFaceIdEnabled(false);
  }
}

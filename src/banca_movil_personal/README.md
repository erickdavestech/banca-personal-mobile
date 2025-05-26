# Caja De Ahorros Mobile

Caja De Ahorros Mobile es una aplicación móvil desarrollada en Flutter.

## Requisitos del Sistema

### Requisitos Mínimos:
- **Flutter**: 3.27.1
- **Dart**: Incluido en Flutter
- **Android Studio** o **Visual Studio Code** con los plugins de Flutter y Dart
- **Android SDK** (API 21 o superior)
- **Xcode** (para desarrollo en iOS)
- **CocoaPods** (para dependencias en iOS): `sudo gem install cocoapods`

### Requisitos Recomendados:
- **Dispositivo físico o emulador configurado**
- **Java Development Kit (JDK) 11 o superior**
- **Git** para gestión del código fuente
- **Melos** para la gestión de paquetes en proyectos modulares: `dart pub global activate melos`

## Instalación y Configuración

### Clonar el Repositorio
```sh
git clone https://cajadeahorrospa@dev.azure.com/cajadeahorrospa/Proyecto%20Zeta/_git/banca-personal-mobile
cd banca-personal-mobile
```

### Instalar Dependencias
```sh
flutter pub get
```

### Verificar Configuración del Entorno
```sh
flutter doctor
```

### Ejecutar la Aplicación
#### En Android:
```sh
flutter run
```
#### En iOS (Mac Requerido):
```sh
cd ios && pod install && cd ..
flutter run
```

## Estructura del Proyecto
```
banca-personal-mobile/
├── lib/                    # Código fuente principal
│   ├── src/                # Módulos de la aplicación
│   ├── main.dart           # Punto de entrada
│   ├── app.dart            # Configuración general
├── assets/                 # Recursos (imágenes, fuentes, etc.)
├── test/                   # Pruebas unitarias
├── pubspec.yaml            # Dependencias y configuración
├── android/                # Configuración para Android
├── ios/                    # Configuración para iOS
├── README.md               # Este archivo
```

## Assets

El directorio `assets` contiene imágenes, fuentes y otros archivos necesarios para la aplicación.

Las imágenes se encuentran en `assets/images`, siguiendo la guía de [imágenes con resolución adaptable](https://flutter.dev/to/resolution-aware-images).

## Localización

Este proyecto soporta internacionalización utilizando archivos ARB en `lib/src/localization`. Para agregar un nuevo idioma, sigue la guía oficial de [Internacionalización en Flutter](https://flutter.dev/to/internationalization).

## Comandos Útiles

- **Formatear Código:**
  ```sh
  flutter format .
  ```
- **Ejecutar Pruebas:**
  ```sh
  flutter test
  ```
- **Verificar Errores de Linter:**
  ```sh
  flutter analyze
  ```

## Contribución
Si deseas contribuir, por favor abre un issue o envía un pull request siguiendo las mejores prácticas de desarrollo colaborativo.

## Licencia
Este proyecto está bajo la licencia MIT. Para más información, consulta el archivo LICENSE.

---

Si tienes algún problema o duda, consulta la documentación oficial de Flutter en [docs.flutter.dev](https://docs.flutter.dev).

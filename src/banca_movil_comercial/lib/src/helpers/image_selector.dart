// import 'dart:ui' as ui;
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ImageSelect {
//   static Future<List<String>> selectImage({required ImageSource source}) async {
//     await Permission.camera.request();
//     switch (source) {
//       case ImageSource.gallery:
//         List<String> imagesFile = [];
//         final images = await ImagePicker().pickMultiImage(
//           limit: 10,
//           imageQuality: 20,
//         );

//         for (final image in images) {
//           final file = await resizeImageWithCodec(image.path);

//           imagesFile.add(file.path);
//         }

//         return imagesFile;

//       default:
//     }
//     File image = File((await ImagePicker().pickImage(
//       source: source,
//       imageQuality: 25,
//     ))!
//         .path);

//     // final compressedImage = await compressAndGetFile(File(image.path));

//     final file = await resizeImageWithCodec(image.path);

//     return [file.path];
//   }

//   // static Future<File> compressAndGetFile(File file) async {
//   //   Uint8List? result = await FlutterImageCompress.compressWithFile(
//   //     file.absolute.path,
//   //     quality: 30,
//   //     format: CompressFormat.jpeg,
//   //     minHeight: 500,
//   //   );

//   //   final tempDir = await getTemporaryDirectory();

//   //   final resultFile = File("${tempDir.path}/${file.path.split('/').last}");
//   //   await resultFile.writeAsBytes(result!);

//   //   return resultFile;
//   // }

//   static Future<File> resizeImageWithCodec(String filePath) async {
//     try {
//       // Leer el archivo como bytes
//       File imageFile = File(filePath);
//       Uint8List imageBytes = await imageFile.readAsBytes();

//       // Crear un codec para decodificar y redimensionar la imagen
//       final codec = await ui.instantiateImageCodec(
//         imageBytes,
//         targetWidth: 600,
//         targetHeight: 950,
//       );

//       // Obtener el primer fotograma del codec
//       final frameInfo = await codec.getNextFrame();
//       final resizedImage = frameInfo.image;

//       // Convertir la imagen redimensionada a bytes (en formato PNG)
//       final ByteData? byteData =
//           await resizedImage.toByteData(format: ui.ImageByteFormat.png);

//       final bytes = byteData!.buffer.asUint8List();

//       final tempDir = await getTemporaryDirectory();

//       final resultFile = File("${tempDir.path}/${filePath.split('/').last}");

//       resultFile.writeAsBytesSync(bytes);

//       return resultFile;
//     } catch (e) {
//       throw e.toString(); // Retornar un Uint8List vacío en caso de error
//     }
//   }
// }

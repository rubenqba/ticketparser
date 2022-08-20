import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:intl/intl.dart';

class ImagePickerConfiguration {
  static ImagePickerConfigs configImagePicker() {
    final configs = ImagePickerConfigs();
    // AppBar text color
    // configs.appBarTextColor = Colors.white;
    // configs.appBarBackgroundColor = Colors.orange;

    // Disable select images from album
    // configs.albumPickerModeEnabled = false;

    // Only use front camera for capturing
    // configs.cameraLensDirection = 0;

    // Translate function
    configs.translateFunc = (name, value) => Intl.message(value, name: name);

    // Disable edit function, then add other edit control instead
    configs.adjustFeatureEnabled = false;
    // configs.externalImageEditors['external_image_editor_1'] = EditorParams(
    //   title: 'Edit image',
    //   icon: Icons.edit_rounded,
    //   onEditorEvent: (
    //           {required BuildContext context,
    //           required File file,
    //           required String title,
    //           int maxWidth = 1080,
    //           int maxHeight = 1920,
    //           int compressQuality = 90,
    //           ImagePickerConfigs? configs}) async =>
    //       Navigator.of(context).push(
    //     MaterialPageRoute(
    //       fullscreenDialog: true,
    //       builder: (context) => ImageEdit(
    //         file: file,
    //         title: title,
    //         maxWidth: maxWidth,
    //         maxHeight: maxHeight,
    //         configs: configs,
    //       ),
    //     ),
    //   ),
    // );
    // configs.externalImageEditors['external_image_editor_2'] = EditorParams(
    //   title: 'external_image_editor_2',
    //   icon: Icons.edit_attributes,
    //   onEditorEvent: (
    //           {required BuildContext context,
    //           required File file,
    //           required String title,
    //           int maxWidth = 1080,
    //           int maxHeight = 1920,
    //           int compressQuality = 90,
    //           ImagePickerConfigs? configs}) async =>
    //       Navigator.of(context).push(
    //     MaterialPageRoute(
    //       fullscreenDialog: true,
    //       builder: (context) => ImageSticker(
    //         file: file,
    //         title: title,
    //         maxWidth: maxWidth,
    //         maxHeight: maxHeight,
    //         configs: configs,
    //       ),
    //     ),
    //   ),
    // );

    // Example about label detection & OCR extraction feature.
    // You can use Google ML Kit or TensorflowLite for this purpose
    // configs.labelDetectFunc = (String path) async {
    //   return <DetectObject>[
    //     DetectObject(label: 'dummy1', confidence: 0.75),
    //     DetectObject(label: 'dummy2', confidence: 0.75),
    //     DetectObject(label: 'dummy3', confidence: 0.75)
    //   ];
    // };
    // configs.ocrExtractFunc = (String path, {bool? isCloudService = false}) async {
    //   if (isCloudService!) {
    //     return 'Cloud dummy ocr text';
    //   } else {
    //     return 'Dummy ocr text';
    //   }
    // };

    // Example about custom stickers
    // configs.customStickerOnly = true;
    // configs.customStickers = [
    //   'assets/icon/cus1.png',
    //   'assets/icon/cus2.png',
    //   'assets/icon/cus3.png',
    //   'assets/icon/cus4.png',
    //   'assets/icon/cus5.png',
    // ];

    return configs;
  }
}

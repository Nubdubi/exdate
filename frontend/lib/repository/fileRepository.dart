import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:frontend/util/fileapi.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FileRepository {
  final _api = FileApi();

  Future<bool> uploadedFile(Uint8List image, String photoname) async {
    try {
      await _api.uploadImage(image, photoname);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
    bool multiple = false,
  }) async {
    if (multiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    final file = await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);
    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop(
    context, {
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    if (kIsWeb) {
      await _imageCropper.cropImage(
          sourcePath: file.path,
          cropStyle: cropStyle,
          compressQuality: 100,
          uiSettings: [WebUiSettings(context: context)]);
    }
    if (Platform.isAndroid && Platform.isIOS) {
      await _imageCropper.cropImage(
          sourcePath: file.path,
          cropStyle: cropStyle,
          compressQuality: 100,
          uiSettings: [IOSUiSettings(), AndroidUiSettings()]);
    }
  }
}

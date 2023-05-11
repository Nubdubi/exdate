import 'dart:typed_data';

import 'package:frontend/repository/fileRepository.dart';

class MainViewmodel {
  final _repository = FileRepository();
  var isLoading = false;

  Future uploadImage(Uint8List image, String photoname) async {
    await _repository.uploadedFile(image, photoname);
  }
}

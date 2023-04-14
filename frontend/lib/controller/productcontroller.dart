import 'package:frontend/model/product.dart';
import 'package:hive/hive.dart';

const String Status_box = 'Status_box';

class StatusHelper {
  static final StatusHelper _statusHelper = StatusHelper._internal();
  factory StatusHelper() {
    return _statusHelper;
  }
  StatusHelper._internal();

  Box<Products>? characterStatus;

  Future openBox() async {
    characterStatus = await Hive.openBox(Status_box);
  }
  //만들기

  Future createStatus(Products newCharactermodel) async {
    return characterStatus!.add(newCharactermodel);
  }

  //리스트로 읽기
  Future<List<Products>> readStatus() async {
    return characterStatus!.values.toList();
  }

  //수정
  Future updateStat(int index, Products updatecharacterstat) async {
    characterStatus!.putAt(index, updatecharacterstat);
  }

  //삭제
  Future deleteStat(int index) async {
    characterStatus!.deleteAt(index);
  }
}

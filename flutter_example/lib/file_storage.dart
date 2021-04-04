import 'dart:convert';
import 'dart:io';

import 'package:flutter_example/entities/entity.dart';

class FileStorage<T extends Entity> {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
      this.tag,
      this.getDirectory,
      );

  Future<List<T>> load(Function fromJson) async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final items = (json[T.runtimeType.toString()])
        .map<T>((item) => fromJson(item) as T)
        .toList();

    return items;
  }

  Future<File> save(List<T> items) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      T.runtimeType.toString(): items.map((item) => item.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
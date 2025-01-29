import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// 📂 **File Manager - Handles Saving & Loading Game Data**
class FileManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename.txt');
  }

  static Future<void> writeFile(String filename, String data) async {
    final file = await _localFile(filename);
    await file.writeAsString(data);
  }

  static Future<String?> readFile(String filename) async {
    try {
      final file = await _localFile(filename);
      return await file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

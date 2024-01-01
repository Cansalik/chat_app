import 'dart:io';

import 'package:chat_app/service/API.dart';
import 'package:http/http.dart' as http;

class FileServices {
  api _api = api();

  Future<void> uploadVideo(String _title, String _key, String _path, String _token) async {

    try {
      const subUrl = '/api/v1/file/file-encrption';

      print("$_title $_key $_path");
      File file = File(_path);
      if (!file.existsSync())
      {
        print("File not found!");
        return;
      }

      var videoBytes = await file!.readAsBytes();
      var request = http.MultipartRequest('POST', Uri.parse("${_api.baseUrl}${subUrl}"),);
      // Video dosyasını ekleyin
      request.files.add(http.MultipartFile.fromBytes(
        'video',
        videoBytes,
      ));
      request.headers['Authorization'] = 'Bearer $_token';
      request.fields['title'] = _title;
      request.fields['pass'] = _key;

      final response = await request.send();
      print("Response: $response");

      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}





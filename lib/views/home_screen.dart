import 'dart:convert';
import 'package:chat_app/service/user_services.dart';
import 'package:chat_app/views/mydecryptedfiles_screen.dart';
import 'package:chat_app/views/myencryptedfiles_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class homePage extends StatefulWidget {
  homePage({super.key, required this.token});
  final String token;
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController tfKey = TextEditingController();
  TextEditingController tfFileName = TextEditingController();

  Future<void> uploadVideo(String _title, String _pass, String _token) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile == null)
    {
      print("Video seçilmedi.");
      return;
    }

    try {
      Dio dio = Dio();
      String apiEndpoint = "https://aes-project-one.azurewebsites.net/api/v1/file/file-encrption";

      FormData formData = FormData.fromMap({
        "title": _title,
        "pass": _pass,
        "video": await MultipartFile.fromFile(
          pickedFile.path,
          filename: "video.mp4",
          contentType: MediaType('video', 'mp4'),
        ),
      });

      Options options = Options(
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        },
      );

      Response response = await dio.post(
        apiEndpoint,
        data: formData,
        options: options,
      );
      final Map<String, dynamic> data = json.decode(response.toString());
      print("Response Data: $data");

      if (response.statusCode == 200)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xff21254A),
            content: Text("Dosya Yüklendi.",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xff21254A),
            content: Text("Bilinmeyen Hata.",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  Future<void> uploadImage(String _title, String _pass, String _token) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null)
    {
      print("Fotoğraf seçilmedi.");
      return;
    }
    print("Token2: $_token");
    try {
      Dio dio = Dio();
      String apiEndpoint = "https://aes-project-one.azurewebsites.net/api/v1/file/image-encrption";
      FormData formData = FormData.fromMap({
        "title": _title,
        "pass": _pass,
        "image": await MultipartFile.fromFile(
          pickedFile.path,
          filename: "image.jpg",
          contentType: MediaType('image', 'jpg'),
        ),
      });

      Options options = Options(
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'multipart/form-data',
        },
      );

      Response response = await dio.post(
        apiEndpoint,
        data: formData,
        options: options,
      );
      final Map<String, dynamic> data = json.decode(response.toString());
      print("Response Data: $data");

      if (response.statusCode == 200)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xff21254A),
            content: Text("Dosya Yüklendi.",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 2000),
          ),
        );
      } else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xff21254A),
            content: Text("Bilinmeyen Hata.",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ], stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'İşleminizi seçin',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 275,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 150,
                              width: 275,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: tfKey,
                                    decoration: InputDecoration(
                                      hintText: "Anahtar kelime ?",
                                    ),
                                  ),
                                  TextField(
                                    controller: tfFileName,
                                    decoration: InputDecoration(
                                      hintText: "Dosya Adı ?",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                              TextButton(
                                child: Text("Şifrele"),
                                onPressed: () {
                                  uploadVideo(tfFileName.text, tfKey.text, widget.token);
                                  Navigator.pop(context);
                                  tfFileName.clear();
                                  tfKey.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'VİDEO YÜKLE',
                      style: TextStyle(
                        color: Color(0xFF527DAA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 275,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 150,
                              width: 275,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: tfKey,
                                    decoration: InputDecoration(
                                      hintText: "Anahtar kelime ?",
                                    ),
                                  ),
                                  TextField(
                                    controller: tfFileName,
                                    decoration: InputDecoration(
                                      hintText: "Dosya Adı ?",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                              TextButton(
                                child: Text("Şifrele"),
                                onPressed: () {
                                  uploadImage(tfFileName.text, tfKey.text, widget.token);
                                  Navigator.pop(context);
                                  tfFileName.clear();
                                  tfKey.clear();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'FOTOĞRAF YÜKLE',
                      style: TextStyle(
                        color: Color(0xFF527DAA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 275,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> myEncryptedFilesScreen(token: widget.token)));
                    },
                    child: const Text(
                      'ŞİFRELİ DOSYALARIM',
                      style: TextStyle(
                        color: Color(0xFF527DAA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 275,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> myDecryptedFilesScreen(token: widget.token,)));
                    },
                    child: const Text(
                      'ÇÖZÜLMÜŞ DOSYALARIM',
                      style: TextStyle(
                        color: Color(0xFF527DAA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                //_buildFilePreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

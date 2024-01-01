import 'dart:io';
import 'package:chat_app/service/file_services.dart';
import 'package:chat_app/views/mydecryptedfiles_screen.dart';
import 'package:chat_app/views/myencryptedfiles_screen.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:grock/grock.dart';
import 'package:video_player/video_player.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});


  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  FileServices fileServices = new FileServices();
  File? _selectedFile;
  TextEditingController tfKey = TextEditingController();
  TextEditingController tfVideoName = TextEditingController();
  VideoPlayerController? _videoController;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });

      if(_selectedFile != null)
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: tfKey,
                    decoration: InputDecoration(
                      hintText: "Şifrelemek İçin Anahtar Kelime Girin.",
                    ),
                  ),
                  TextField(
                    controller: tfVideoName,
                    decoration: InputDecoration(
                      hintText: "Video Adı ?",
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                TextButton(
                  child: Text("Şifrele"),
                  onPressed: () {_uploadFile();},
                ),
              ],
            );
          },
        );
      }
      else
      {
        Grock.snackBar(title: "Hata", description: "Dosya Yükelnirken Hata Oluştu", color: Colors.red);
      }
    }
  }



  void _uploadFile() async {
    if (_selectedFile != null && _selectedFile!.path.endsWith('.mp4')) {
      fileServices.uploadVideo(tfVideoName.text, tfKey.text, _selectedFile!.path,"token");
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
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
                      _pickFile();
                      if(_selectedFile != null)
                      {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: 275,
                                child: TextField(
                                  controller: tfKey,
                                  decoration: InputDecoration(
                                    hintText: "Şifrelemek İçin Anahtar Kelime Girin.",
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                                TextButton(
                                  child: Text("Şifrele"),
                                  onPressed: () {

                                    /* if (_selectedFile != null)
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
                                  }*/
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      'DOSYA YÜKLE',
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> myEncryptedFilesScreen()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> myDecryptedFilesScreen()));
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

  Widget _buildFilePreview() {
    if (_selectedFile == null) {
      return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Image.asset("assets/images/empty-folder.png"));
    } else if (_selectedFile!.path.endsWith('.mp4')) {
      if (_videoController != null && _videoController!.value.isInitialized) {
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        );
      }
    } else {
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Image.file(
          _selectedFile!,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(); // Diğer durumlar için boş bir container döndür
  }



  /*
  *
  *  void _initializeFilePreview() {
    if (_selectedFile != null) {
      if (_selectedFile!.path.endsWith('.mp4')) {
        _initializeVideoController();
      }
    }
  }

  void _initializeVideoController() {
    if (_videoController != null) {
      _videoController!.dispose(); // Eğer varsa önceki video oynatıcıyı serbest bırak
    }

    _videoController = VideoPlayerController.file(_selectedFile!)
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play(); // Videoyu otomatik olarak başlat
      });

    _videoController!.addListener(() {
      if (_videoController!.value.position >= _videoController!.value.duration) {
        // Video tamamlandığında veya sona erdiğinde isteğe bağlı olarak bir işlem yapabilirsiniz.
      }
    });
  }
  * */
}

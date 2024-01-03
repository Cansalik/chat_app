import 'package:chat_app/views/myencryptedphoto_screen.dart';
import 'package:chat_app/views/myencryptedvideo_screen.dart';
import 'package:flutter/material.dart';

class myEncryptedFilesScreen extends StatefulWidget {
  myEncryptedFilesScreen({Key? key, required this.token}) : super(key: key);

  final String token;@override
  State<myEncryptedFilesScreen> createState() => _myEncryptedFilesScreenState();
}

class _myEncryptedFilesScreenState extends State<myEncryptedFilesScreen> {
  bool _isSearching = false;

  TextEditingController tfKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        title: Text("Dosya Türü seçin")
      ),
      body: Stack(
        children: [
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
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 275,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => myEncryptedVideos(token: widget.token)));
                    },
                    child: const Text(
                      'ŞİFRELİ VİDEOLAR',
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => myEncryptedPhotos(token: widget.token)));
                    },
                    child: const Text(
                      'ŞİFRELİ FOTOĞRAFLAR',
                      style: TextStyle(
                        color: Color(0xFF527DAA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

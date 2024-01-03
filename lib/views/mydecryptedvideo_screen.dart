import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../service/API.dart';
import 'package:http/http.dart' as http;

class myDecryptedVideos extends StatefulWidget {
  myDecryptedVideos({super.key, required this.token});

  final String token;
  @override
  State<myDecryptedVideos> createState() => _myDecryptedVideosState();
}

class _myDecryptedVideosState extends State<myDecryptedVideos> {
  Api _api = new Api();
  String subUrl = "/api/v1/file/file-decrypt-list";
  bool _isSearching = false;
  TextEditingController tfKey = TextEditingController();


  List<Map<String, dynamic>> videoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri uri = Uri.parse('${_api.baseUrl}$subUrl');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${widget.token}', // Token ekleniyor.
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        videoList = List<Map<String, dynamic>>.from(data['data']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


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
        title: _isSearching
            ? TextField(
          style: TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(color: Colors.black),
          ),
          autofocus: true,
          onChanged: (aramaSonucu) {},
        )
            : const Text("Çözülmüş Fotoğraflar"),
        actions: [
          _isSearching
              ? IconButton(
            onPressed: () {
              setState(() {
                _isSearching = false;
              });
            },
            icon: Icon(Icons.cancel),
          )
              : IconButton(
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
            icon: Icon(Icons.search),
          )
        ],
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
          // ListView eklenmiş kısım
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index)
              {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Video URL'sini alın ve oynatıcıyı başlatın
                            String videoUrl = videoList[index]['video_url'];
                            _playVideo(videoUrl);
                          },
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/play-button.png"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(videoList[index]['title'],style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text(videoList[index]['createdAt'],style: TextStyle(fontSize: 16,color: Colors.blue),),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(onPressed: ()
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
                                  TextButton(child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                                  TextButton(
                                    child: Text("Şifrele"),
                                    onPressed: ()
                                    {
                                      tfKey.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Color(0xff21254A),
                                          content: Text("Dosya şifrelendi.",
                                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                          duration: Duration(milliseconds: 2000),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }, icon: Icon(Icons.lock),color: Colors.red[400],),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _playVideo(String videoUrl) {
    VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {
        });
      });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 275,
            height: 275,
            child: VideoPlayer(controller),
          ),
          actions: [
            TextButton(
              child: Text("Başlat"),
              onPressed: () {
                controller.play();
              },
            ),
            TextButton(
              child: Text("Durdur"),
              onPressed: () {
                controller.pause();
              },
            ),
            TextButton(
              child: Text("Kapat"),
              onPressed: () {
                controller.pause();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

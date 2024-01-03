import 'dart:convert';
import 'package:flutter/material.dart';
import '../service/API.dart';
import 'package:http/http.dart' as http;

class myDecryptedPhotos extends StatefulWidget {
  myDecryptedPhotos({super.key, required this.token});

  final String token;
  @override
  State<myDecryptedPhotos> createState() => _myDecryptedPhotosState();
}

class _myDecryptedPhotosState extends State<myDecryptedPhotos> {
  Api _api = new Api();
  String subUrl = "/api/v1/file/image-decrypt-list";
  bool _isSearching = false;
  TextEditingController tfKey = TextEditingController();


  List<Map<String, dynamic>> photoList = [];

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
        photoList = List<Map<String, dynamic>>.from(data['data']);
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
        title: const Text("Çözülmüş Fotoğraflar"),
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
              itemCount: photoList.length,
              itemBuilder: (context, index)
              {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Fotoğrafı göster
                            String imageUrl = photoList[index]['image_url'];
                            _showImage(imageUrl);
                          },
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/folder.png"), // Örnek bir fotoğraf ikonu
                          ),
                        ),                         Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(photoList[index]['title'],style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text(photoList[index]['createdAt'],style: TextStyle(fontSize: 16,color: Colors.blue),),
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

  void _showImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 275,
            height: 275,
            child: Image.network(imageUrl),
          ),
          actions: [
            TextButton(
              child: Text("Kapat"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}

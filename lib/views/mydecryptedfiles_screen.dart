import 'package:flutter/material.dart';

class myDecryptedFilesScreen extends StatefulWidget {
  const myDecryptedFilesScreen({super.key});

  @override
  State<myDecryptedFilesScreen> createState() => _myDecryptedFilesScreenState();
}

class _myDecryptedFilesScreenState extends State<myDecryptedFilesScreen> {
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
            : const Text("Listem"),
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
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        SizedBox(width: 50,height: 50,child: Image.asset("assets/images/folder.png")),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Dosya İsmi",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text("Yüklenme Tarihi",style: TextStyle(fontSize: 16,color: Colors.blue),),
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
                                    keyboardType: TextInputType.number,
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
                                      print("Şifrelendi");
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

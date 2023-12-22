import 'package:flutter/material.dart';

class myEncryptedFilesScreen extends StatefulWidget {
  const myEncryptedFilesScreen({Key? key}) : super(key: key);

  @override
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
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
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
                                  width: 225,
                                  child: TextField(
                                    controller: tfKey,
                                    decoration: InputDecoration(
                                      hintText: "Anahatar Kelime ?",
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(child: Text("İptal"), onPressed: () => Navigator.pop(context)),
                                  TextButton(
                                    child: Text("Dosyayı Aç"),
                                    onPressed: ()
                                    {
                                      tfKey.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Color(0xff21254A),
                                          content: Text("Dosyanın şifresi çözüldü..",
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
                        }, icon: Icon(Icons.lock_open),color: Colors.green[400],),
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

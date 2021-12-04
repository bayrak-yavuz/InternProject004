// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanici_giris/profilsayfasi.dart';

class duzenlemeSayfasi extends StatefulWidget {
  const duzenlemeSayfasi({Key? key}) : super(key: key);

  @override
  _duzenlemeSayfasiState createState() => _duzenlemeSayfasiState();
}

class _duzenlemeSayfasiState extends State<duzenlemeSayfasi> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
        title: Text("Düzenle"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: Colors.blueGrey.shade600.withOpacity(.50),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  //başlık
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Başlık',
                  ),
                  //controller: t1,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  //içerik
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'İçerik',
                  ),
                  maxLines: 3,
                  // controller: t2,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Güncelle"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

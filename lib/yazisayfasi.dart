// ignore_for_file: prefer_const_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YaziEkrani extends StatefulWidget {
  @override
  _YaziEkraniState createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController(); //başlık
  TextEditingController t2 = TextEditingController(); //içerik

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";
  var currentUser = FirebaseAuth.instance.currentUser;

  yaziEkle() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    FirebaseFirestore.instance.collection("notes").doc(t1.text).set({
      'content': t2.text,
      'created_date': formattedDate,
      'is_deleted': false,
      //'noteid':
      //'shared_users':
      'title': t1.text,
      'uid': currentUser!.uid,
    });
  }

  /* yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text});
  }

  yaziSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
        title: Text("Yazı Ekle"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey.shade600,
      body: Center(
        child: Card(
          color: Colors.blueGrey.shade200.withOpacity(.75),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Başlık',
                  ),
                  controller: t1,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'İçerik',
                  ),
                  maxLines: 4,
                  controller: t2,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: yaziEkle,
                  child: Text("Ekle"),
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

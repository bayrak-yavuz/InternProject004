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
    return Scaffold(
      appBar: AppBar(
        title: Text("Yazı Ekranı"),
      ),
      body: Container(
        margin: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              Row(
                children: [
                  ElevatedButton(child: Text("Ekle"), onPressed: yaziEkle),
                  /*ElevatedButton(
                      child: Text("Güncelle"), onPressed: yaziGuncelle),
                  ElevatedButton(child: Text("Sil"), onPressed: yaziSil),*/
                ],
              ),
              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

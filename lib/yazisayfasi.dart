// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanici_giris/profilsayfasi.dart';

class YaziEkrani extends StatefulWidget {
  @override
  _YaziEkraniState createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
  TextEditingController t1 = TextEditingController(); //başlık
  TextEditingController t2 = TextEditingController(); //içerik
  TextEditingController t3 = TextEditingController(); //e mail

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";
  final List<String> permission = <String>[];
  var currentUser = FirebaseAuth.instance.currentUser;
  yaziEkle() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    FirebaseFirestore.instance.collection("notes").doc(t1.text).set({
      'content': t2.text,
      'created_date': formattedDate,
      'is_deleted': false,
      //'noteid':
      'shared_users': permission,
      'title': t1.text,
      'uid': currentUser!.uid,
    });
  }

  getMail() {
    permission.add(t3.text);
  }

  listClear() {
    permission.clear();
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
                  controller: t1,
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
                  controller: t2,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 295,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Yazıyı Görecek Olan Kullanıcılar',
                        ),
                        controller: t3,
                      ),
                    ),
                    Container(
                      height: 48,
                      padding: EdgeInsets.fromLTRB(2, 5, 0, 5),
                      child: ElevatedButton(
                        //kullanıcı ekleme
                        onPressed: () {
                          if (t3.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Eksik Tuşlama Yaptınız',
                                backgroundColor: Colors.red.shade600,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 2,
                                fontSize: 16.0);
                          } else {
                            getMail();
                            t3.clear();
                          }
                        },
                        child: Text("Ekle"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey.shade800),
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (t1.text.isEmpty && t2.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Eksik Yerleri Doldurunuz',
                          backgroundColor: Colors.red.shade600,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          fontSize: 16.0);
                    } else {
                      yaziEkle();
                      Fluttertoast.showToast(
                          msg: 'Yazı Eklendi',
                          backgroundColor: Colors.red.shade600,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 3,
                          fontSize: 16.0);
                    }
                    listClear();
                    t1.clear();
                    t2.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => ProfilEkrani()),
                        (Route<dynamic> route) => true);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey.shade800),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Yazı Ekle",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                /* ElevatedButton(
                  onPressed: yaziEkle,
                  child: Text("Yazıyı Ekle"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade800),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

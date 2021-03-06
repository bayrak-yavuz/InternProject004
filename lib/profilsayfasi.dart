// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanici_giris/duzenlemesayfasi.dart';
import 'package:kullanici_giris/main.dart';
import 'package:kullanici_giris/yazisayfasi.dart';

import 'anasayfa.dart';

class ProfilEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
        title: Text("Profil Sayfası"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => AnaSayfa()),
                  (Route<dynamic> route) => true);
            },
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((deger) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Iskele()),
                      (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.blueGrey.shade800,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => YaziEkrani()),
                (Route<dynamic> route) => true);
          }),
      body: Container(
        child: KullaniciYazilari(),
      ),
    );
  }
}

class KullaniciYazilari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    //yorum satrisifadsadsa
    Query blogYazilari = FirebaseFirestore.instance
        .collection('notes')
        .where("uid", isEqualTo: currentUser!.uid)
        .where("is_deleted", isEqualTo: false);

    return StreamBuilder<QuerySnapshot>(
      stream: blogYazilari.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Bir şeyler ters gitti!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Yükleniyor..");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Card(
              color: Colors.blueGrey.shade200.withOpacity(.75),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.text_snippet_rounded),
                    title: Text(data['title']),
                    subtitle: Text(data['content']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.red.shade700,
                        ),
                        child: Text(
                          'Sil',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          String willDeleted = data['title'];
                          FirebaseFirestore.instance
                              .collection("notes")
                              .doc(willDeleted)
                              .update({
                            "is_deleted": true,
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.lightGreen.shade800,
                        ),
                        child: Text(
                          'Düzenle',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          String title = data['title'];
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => duzenlemeSayfasi()),
                              (Route<dynamic> route) => true);
                        },
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

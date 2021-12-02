// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanici_giris/main.dart';
import 'package:kullanici_giris/yazisayfasi.dart';

import 'anasayfa.dart';

class ProfilEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Icon(Icons.add),
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

    Query blogYazilari = FirebaseFirestore.instance
        .collection('notes')
        .where("uid", isEqualTo: currentUser!.uid);

    return StreamBuilder<QuerySnapshot>(
      stream: blogYazilari.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
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
                    subtitle:
                        Text(data['content']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.red.shade700,
                        ),
                        child: Text('Sil'),
                        onPressed: () {
                          String willDeleted = data['title'];
                          FirebaseFirestore.instance.collection("notes").doc(willDeleted).delete();
                        },
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.lightGreen.shade800,
                        ),
                        child: Text('Düzenle'),
                        onPressed: () {/* ... */},
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

            /*ListTile(
              title: Text(data['title']),
              subtitle: Text(data['content']),
            );*/
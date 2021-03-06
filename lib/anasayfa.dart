// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        title: Text("Anasayfa"),
        backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
      ),
      body: TumYazilar(),
    );
  }
}

class TumYazilar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    //var mail = FirebaseAuth.instance.currentUser!.email;
    Query users = FirebaseFirestore.instance
        .collection('notes')
        .where("uid", isEqualTo: currentUser!.uid)
        .where("is_deleted", isEqualTo: false);
        //.where("shared_users", arrayContains: mail);

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Bir şeyler ters gitti!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Yükleniyor..");
        }

        return new ListView(
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
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

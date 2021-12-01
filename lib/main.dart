// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
//yorum satiri
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kullanici_giris/kayitol.dart';
import 'package:kullanici_giris/profilsayfasi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  /*Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(t1.text)
          .set({"KullaniciEposta": t1.text, "KullaniciSifre": t2.text});
    });
  }*/

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ProfilEkrani()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: size.height * .5,
          width: size.width * .85,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade800.withOpacity(.75),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.75),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: t1,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.blue,
                      ),
                      hintText: 'E-Posta',
                      prefixText: ' ',
                      hintStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      focusColor: Colors.blue,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                    controller: t2,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    cursorColor: Colors.blue,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.blue,
                      ),
                      hintText: 'Parola',
                      prefixText: ' ',
                      hintStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      focusColor: Colors.blue,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  InkWell(
                    onTap: () {
                      girisYap();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((deger) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => kayitSayfasi()),
                            (Route<dynamic> route) => false);
                      });
                      //kayitOl();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          width: 75,
                          color: Colors.blue,
                        ),
                        Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Container(
                          height: 1,
                          width: 75,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  /*Row(
                      children: [
                        ElevatedButton(child: Text("Kaydol"), onPressed: kayitOl),
                        ElevatedButton(child: Text("Giriş Yap"), onPressed: girisYap),
                      ],
                    ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

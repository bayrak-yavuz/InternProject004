// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kullanici_giris/kayitol.dart';
import 'package:kullanici_giris/profilsayfasi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanici_giris/sifremi_unuttum.dart';

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
  bool isValid = false;
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

  girisYap() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: t1.text, password: t2.text)
          .then((kullanici) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ProfilEkrani()),
            (Route<dynamic> route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        Fluttertoast.showToast(
            msg: 'Hatalı Şifre',
            backgroundColor: Colors.red.shade600,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            fontSize: 16.0);
      } else if (e.code == "user-not-found") {
        Fluttertoast.showToast(
            msg: 'Kullanıcı Bulunamadı',
            backgroundColor: Colors.red.shade600,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Eksik veya Hatalı Giriş',
            backgroundColor: Colors.red.shade600,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5,
            fontSize: 16.0);
      }

      /*Fluttertoast.showToast(
          msg: 'Hata Kodu: ${e.code}',
          backgroundColor: Colors.red.shade600,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          fontSize: 16.0);*/

      //print('Hata Kodu: ${e.message}');

      //print('Failed with error code: ${e.code}');
      //print(e.message);
    }

    /* FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) { 
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ProfilEkrani()),
          (Route<dynamic> route) => false);
    });*/
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
                  TextFormField(
                    controller: t1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      hintText: 'E-Posta',
                      prefixText: ' ',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    controller: t2,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      hintText: 'Parola',
                      prefixText: ' ',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      girisYap();

                      /*isValid = EmailValidator.validate(t1.text);
                      if (isValid) {
                        girisYap();
                      } else if (t1.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Mail Adresinizi Giriniz',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Geçerli Bir Mail Adresi Giriniz',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      }*/
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              color: Colors.white,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => sifremiUnuttum()),
                            );
                      });
                      //şifremi unuttum
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Şifremi Unuttum",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((deger) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => kayitSayfasi(),
                            ));
                      });
                      //kayitOl();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 4,
                          width: 75,
                          color: Colors.white,
                        ),
                        Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Container(
                          height: 4,
                          width: 75,
                          color: Colors.white,
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

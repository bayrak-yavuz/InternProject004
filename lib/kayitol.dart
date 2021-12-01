// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class kayitSayfasi extends StatefulWidget {
  const kayitSayfasi({Key? key}) : super(key: key);

  @override
  _kayitSayfasiState createState() => _kayitSayfasiState();
}

class _kayitSayfasiState extends State<kayitSayfasi> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  displayName(String mail) {
    int deger = mail.indexOf('@');
    String result = mail.substring(0, deger);
    return result;
  }

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance.collection("user").doc(currentUser!.uid).set({
        "userMail": t1.text,
        "displayName": displayName(t1.text),
        "uid": currentUser!.uid
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
          leading: BackButton(color: Colors.white),
          title: Text("Kayıt Ol"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: size.height * .50,
              width: size.width * .75,
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
                      TextFormField(
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
                          hintText: 'Parola Tekrar',
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
                        height: size.height * 0.08,
                      ),
                      InkWell(
                        onTap: () {
                          kayitOl();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text(
                                "Kayıt Ol",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
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

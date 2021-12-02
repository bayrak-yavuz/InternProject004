// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanici_giris/main.dart';


class sifremiUnuttum extends StatefulWidget {
  const sifremiUnuttum({Key? key}) : super(key: key);

  @override
  _sifremiUnuttumState createState() => _sifremiUnuttumState();
}


class _sifremiUnuttumState extends State<sifremiUnuttum> {

  bool isValid = false;
  TextEditingController t1 = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800.withOpacity(.75),
          leading: BackButton(color: Colors.white),
          title: Text("Şifre Sıfırla"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: size.height * .25,
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
                      InkWell(
                        onTap: () {
                          isValid = EmailValidator.validate(t1.text);
                          if (isValid) {
                            Fluttertoast.showToast(
                                msg: 'Şifre Sıfırlama Bağlantısı E-Posta Adresinize Gönderilmiştir.',
                                backgroundColor: Colors.red.shade600,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 5,
                                fontSize: 16.0);

                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                     email: t1.text)
                                .then((kullanici) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Iskele()),
                                  (Route<dynamic> route) => false);
                                  }
                                );}
                           else if (t1.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'E-postanızı giriniz!',
                                backgroundColor: Colors.red.shade600,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Geçersiz e-posta!',
                                backgroundColor: Colors.red.shade600,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          }
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
                                "Şifremi Sıfırla",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
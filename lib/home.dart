import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'list-rs.dart';

class home extends StatelessWidget {
  const home({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              color: Color(0xff57C5B6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ListView(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "CaCekKes",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 37,
                            color: Color(0xff002B5B),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Silahkan pilih menu",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Image.asset('images/cekkes.png'),
                              Text(
                                "List Ulasan Cek Kesehatan ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Anda dapat melihat catatan ulasan cek",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "kesahatan disini",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    dashboard()),
                                          );
                                        },
                                        child: Text("Lanjutkan"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Color(
                                                  0xff18AE8E)), // Change to your desired color
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Image.asset('images/hostpital.png'),
                              Text(
                                "List Rumah Sakit",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Anda dapat melihat daftar rumah sakit di",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Jember",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff002B5B)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    list_rs()),
                                          );
                                        },
                                        child: Text("Lanjutkan"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Color(
                                                  0xff18AE8E)), // Change to your desired color
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

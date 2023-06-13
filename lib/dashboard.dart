import 'package:flutter/material.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: body(),
      ),
    );
  }
}

//body nya ini
class body extends StatefulWidget {
  const body({super.key});

  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: SizedBox(
          width: 110,
          child: FloatingActionButton(
            onPressed: () {
              // Add your button click logic here
            },
            child: Text("Tambahkan"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Color(0xFF002B5B),
          ),
        ),
        body: ListView(
          children: [
            Container(
              color: Color(0xff57C5B6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "CaCekKes",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 37,
                          color: Color(0xff002B5B)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Daftar Riwayat Cek Kesehatanmu",
                      style: TextStyle(color: Colors.white, letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.all(25),
                      width: 370,
                      child: Row(
                        children: [
                          Expanded(
                              child: Image.asset(
                            "images/index.png",
                            width: 100,
                          )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: Column(
                                children: [
                                  Text(
                                    "Cek Kesehatan 1",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF002B5B)),
                                  ),
                                  Text(
                                    "Keterangan :  Cek asam urat, cabut gigi dan konsultasi kesehatan",
                                    style: TextStyle(
                                      color: Color(0xFF002B5B),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Tanggal : 20 Mei 2020             ",
                                    style: TextStyle(color: Color(0xFF002B5B)),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Lokasi : lang: xxxx long xxxx             ",
                                    style: TextStyle(color: Color(0xFF002B5B)),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Biaya :  Rp 500.000,-                 ",
                                    style: TextStyle(color: Color(0xFF002B5B)),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Add your button click logic here
                                          },
                                          child: Image.asset(
                                              "images/location.png"),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Add your button click logic here
                                          },
                                          child: Image.asset("images/edit.png"),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Add your button click logic here
                                          },
                                          child:
                                              Image.asset("images/delete.png"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

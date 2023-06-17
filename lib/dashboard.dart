import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add.dart';

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
  Future<List<QueryDocumentSnapshot>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('data').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: SizedBox(
          width: 110,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
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
                                color: Color(0xff002B5B)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Daftar Riwayat Cek Kesehatanmu",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                          //content
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(25)),
                            // padding: EdgeInsets.all(25),
                            // width: 370,
                            child: FutureBuilder<List<QueryDocumentSnapshot>>(
                              future: fetchData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<QueryDocumentSnapshot>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  List<QueryDocumentSnapshot> data =
                                      snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Map<String, dynamic> documentData =
                                          data[index].data()
                                              as Map<String, dynamic>;
                                      return Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        padding: EdgeInsets.all(25),
                                        width: 370,
                                        child: Row(
                                          children: [
                                            Expanded(

                                                //immage from firebase
                                                child: Image.network(
                                                    documentData['imageUrl'],
                                                    width: 100)),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    30, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      documentData['judul'],
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF002B5B),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Keterangan: ${documentData['keterangan']}",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF002B5B)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      "Tanggal: ${documentData['tanggal']}",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF002B5B)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      "Lokasi: ${documentData['lokasi']}",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF002B5B)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      "Biaya: ${documentData['biaya']}",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF002B5B)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
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
                                                            child: Image.asset(
                                                                "images/edit.png"),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Add your button click logic here
                                                            },
                                                            child: Image.asset(
                                                                "images/delete.png"),
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
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add.dart';
import 'route.dart';

class list_rs extends StatelessWidget {
  const list_rs({Key? key});

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
  final TextEditingController _searchController = TextEditingController();

  Future<List<QueryDocumentSnapshot>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('rumahsakit').get();
    return querySnapshot.docs;
  }

  List<QueryDocumentSnapshot> filterData(
      String query, List<QueryDocumentSnapshot> data) {
    if (query.isEmpty) {
      return data;
    } else {
      return data.where((snapshot) {
        Map<String, dynamic> documentData =
            snapshot.data() as Map<String, dynamic>;
        String title = documentData['kecamatan'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    }
  }

  void openGoogleMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(url);
  }

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
                          "Daftar Rumah Sakit Di Jemnber",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 320,
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: 'Cari berdasarkan Kecamatan',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: FutureBuilder<List<QueryDocumentSnapshot>>(
                            future: fetchData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<QueryDocumentSnapshot>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                List<QueryDocumentSnapshot> data =
                                    snapshot.data!;
                                List<QueryDocumentSnapshot> filteredData =
                                    filterData(_searchController.text, data);

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: filteredData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map<String, dynamic> documentData =
                                        filteredData[index].data()
                                            as Map<String, dynamic>;
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.all(25),
                                      width: 370,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: documentData['imageUrl'] !=
                                                      null
                                                  ? Image.network(
                                                      documentData['imageUrl'])
                                                  : Image.asset(
                                                      "images/hostpital.png")),
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
                                                    documentData['rumah_sakit'],
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Kecamatan: ${documentData['kecamatan']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Alamat: ${documentData['alamat']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Buka: ${documentData['buka']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Kontak: ${documentData['kontak']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          child: SizedBox(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                double
                                                                    latitude =
                                                                    documentData[
                                                                        'latitude'];
                                                                double
                                                                    longitude =
                                                                    documentData[
                                                                        'longitude'];
                                                                openGoogleMaps(
                                                                    latitude,
                                                                    longitude);
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .maps_home_work,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
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

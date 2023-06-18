import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add.dart';
import 'route.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key});

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
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('data')
        .orderBy('tanggal', descending: true)
        .get();
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
        String title = documentData['judul'].toString().toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    }
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
                            color: Color(0xff002B5B),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Daftar Riwayat Cek Kesehatanmu",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: 'Cari berdasarkan Judul',
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
                                            child: Image.network(
                                              documentData['imageUrl'],
                                              width: 100,
                                            ),
                                          ),
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
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Keterangan: ${documentData['keterangan']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Tanggal: ${documentData['tanggal']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Lokasi: ${documentData['lokasi']}",
                                                    style: TextStyle(
                                                      color: Color(0xFF002B5B),
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "Biaya: ${documentData['biaya']}",
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
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            RoutePage(
                                                                      latitude:
                                                                          documentData[
                                                                              'latitude'],
                                                                      longitude:
                                                                          documentData[
                                                                              'longitude'],
                                                                    ),
                                                                  ),
                                                                );
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

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff57C5B6),
        title: Center(
          child: Text(
            "CaCekKes",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 32,
              color: Color(0xff002B5B),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _label = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  File? _image;
  TextEditingController judul = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController biaya = TextEditingController();
  String Judul = '';
  String Keterangan = '';
  String Tanggal = '';
  String Biaya = '';
  String imageUrl = '';
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('data');

  void handleAutoFill() {
    setState(() {
      _label.text = latitude.toString() + " " + longitude.toString();
    });
  }

  Future<void> _getImageFromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child("image");
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(pickedImage.path));
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (error) {
        imageUrl = 'error';
      }
    }
  }

  Future<void> _getgeolocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      handleAutoFill();
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        latitude = position.latitude;
        longitude = position.longitude;
        handleAutoFill();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission to access location denied')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        Tanggal = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Tambah Ulasan Cek",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: Color(0xff002B5B)),
            ),
            Text(
              "Kesehatanmu",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, color: Color(0xff002B5B)),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: _getImageFromCamera,
              child: SizedBox(
                child: GestureDetector(
                  onTap: _getImageFromCamera,
                  child: _image == null
                      ? Image.asset(
                          'images/foto.png',
                          width: 300,
                          height: 200,
                        )
                      : Image.file(
                          _image!,
                          width: 300,
                          height: 200,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "*Tambahkan foto yang",
              style: TextStyle(color: Color(0xFFBC0D0D)),
            ),
            Text(
              "menggambarakan keadaan ulasan",
              style: TextStyle(color: Color(0xFFBC0D0D)),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Text(
                    "Judul ",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: judul,
                      onChanged: (value) {
                        setState(() {
                          Judul = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Masukan nama rumah sakit',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff002B5B))),
                        filled: true,
                        fillColor: Color(0xffACE2DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Row(
                children: [
                  Text(
                    "Keterangan",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: keterangan,
                      onChanged: (value) {
                        setState(() {
                          Keterangan = value;
                        });
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Keterangan Anda',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff002B5B)),
                        ),
                        filled: true,
                        fillColor: Color(0xffACE2DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Row(
                children: [
                  Text(
                    "Tanggal      ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'Tanggal Cek Kesehatan Anda',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff002B5B))),
                        filled: true,
                        fillColor: Color(0xffACE2DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Row(
                children: [
                  Text(
                    "Lokasi         ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _label,
                      decoration: InputDecoration(
                        labelText: "lang xxxxxx lat xxxxxx",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff002B5B))),
                        filled: true,
                        enabled: false,
                        fillColor: Color(0xffACE2DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: ElevatedButton(
                onPressed: _getgeolocation,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(145, 30),
                  backgroundColor: Color(0xff18AE8E),
                ),
                child: Row(
                  children: [
                    Text("lokasi akurat  "),
                    Icon(Icons.location_on),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Row(
                children: [
                  Text(
                    "Biaya           ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: biaya,
                      onChanged: (value) {
                        setState(() {
                          Biaya = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Rp. xxxxxxxxx,-',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff002B5B))),
                        filled: true,
                        fillColor: Color(0xffACE2DA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => dashboard(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(80, 30),
                        backgroundColor: Color(0xffFF0000),
                      ),
                      child: Text('Batal'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (imageUrl.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('foto tidak ada')),
                          );
                          return;
                        }
                        Map<String, dynamic> DataSend = {
                          'judul': Judul,
                          'imageUrl': imageUrl,
                          'keterangan': Keterangan,
                          'tanggal': Tanggal,
                          'longitude': longitude,
                          'latitude': latitude,
                          'biaya': Biaya,
                        };
                        await _reference.add(DataSend);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Berhasil !!"),
                              content: Text("Data Berhasil Disimpan"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => dashboard(),
                                        ),
                                      );
                                    },
                                    child: Text('OK'))
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(100, 30),
                        backgroundColor: Color(0xff002B5B),
                      ),
                      child: Text('Tambah'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Adding extra space at the bottom for illustration
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Aksi yang ingin Anda lakukan saat tombol "Back" ditekan
              // Misalnya, navigasi ke halaman sebelumnya
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
        body: SafeArea(child: Body()),
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

  void handleAutoFill() {
    setState(() {
      _label.text = latitude.toString() + " " + longitude.toString();
    });
  }

  Future<void> _getImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _getgeolocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
    handleAutoFill();
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
              "Tambah Riwayat Cek",
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
                          )),
              ),
            ),
            Text(
              "*Pastikan Resep obat, kwitansi & tampak ",
              style: TextStyle(color: Color(0xFFBC0D0D)),
            ),
            Text(
              "bangunan masuk frame",
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
                      decoration: InputDecoration(
                        labelText: 'Masukkan Judul Catatan Anda',
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
            ElevatedButton(
                onPressed: () {
                  _getgeolocation();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(145, 30),
                    backgroundColor: Color(0xff18AE8E)),
                child: Row(
                  children: [Text("lokasi akurat  "), Icon(Icons.location_on)],
                )),
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
              margin: EdgeInsets.fromLTRB(120, 10, 30, 0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
                      onPressed: () {},
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
            // Adding extra space at the bottom for illustration
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: MyApp(),
    routes: {'/home': (context) => home()},
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Column(
              children: [
                Center(child: Image.asset("images/index.png")),
                Text(
                  "CacekKes",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 37,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color(0xFF57C5B6),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            "Di aplikasi CaCekKes (Catatan  Cek Kesehatan). Aplikasi ini diciptakan untuk memudahkan anda dalam memberikan catatan ulasan setelah melakukan cek kesehatan dan  mendokumentasikan, serta menemukan lokasi anda pada saat melakukan cek kesehatan di tempat kesehatan. Perlu diketahui bahwa catatan ini bersifat publik dan anomim, maka harap memberikan catatan yang baik dan benar.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF18AE8E),
                              shape: StadiumBorder()),
                          child: Text('Lanjutkan'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      )),
    );
  }
}

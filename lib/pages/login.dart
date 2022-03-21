import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas/pages/home.dart';

import 'package:tugas/pages/registrasi.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? nama = "";
  String? password = "";
  late SharedPreferences pref;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getDataPref() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      nama = pref.getString("nama");
      password = pref.getString("password");
    });
  }

  void loginData() {
    if (namaController.text == nama && passController.text == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          "Nama dan Password Belum Ada",
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 3,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orange,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Container(
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  "Nama Akun",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: "Inputkan Nama",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: "Inputkan Password",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      loginData();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Klik DAFTAR untuk Registrasi !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrasiPage(),
                          ));
                    },
                    child: Text(
                      "DAFTAR",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

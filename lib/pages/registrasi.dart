import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas/pages/login.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  late String nama = "";
  late String email = "";
  late String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //function menyimpan data ke page lain dari dalam Drawer menu
  //menggunakan sharedPref
  saveDataRegis() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setString("nama", nama);
      pref.setString("email", email);
      pref.setString("password", password);

      if (formKey.currentState!.validate()) {
        print(nama);
        print(email);
        print(password);
        AlertDialog alert = AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text("Data Berhasil Disimpan"),
          content: Text("Sekarang Anda Bisa Login "),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            ),
          ],
        );

        showDialog(
          context: context,
          builder: (context) => alert,
        );
      }
      return;
    }
  }

  @override
  void initState() {
    saveDataRegis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(
          "Daftar Akun",
          style: TextStyle(letterSpacing: 3, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 80),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Harus Di Isi";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    nama = value!;
                  },
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
                  "Email",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Harus Di Isi";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    email = value!;
                  },
                  decoration: InputDecoration(
                    hintText: "Inputkan Email",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Harus Di Isi";
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    password = value!;
                  },
                  obscureText: true,
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
                      saveDataRegis();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Text(
                        "Simpan",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

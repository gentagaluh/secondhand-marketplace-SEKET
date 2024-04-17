import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/acc/register.dart';
import 'package:app_seket/screen/bnb/bnb.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomorController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    Future login() async {
      var response = await http.post(
          Uri.parse(currentUrl+'api/user/login'),
          body: {
            "nomor_hp": _nomorController.text,
            "password": _passwordController.text
          });
      Map data = json.decode(response.body);
      String msg = data['message'];
      if (msg == 'gagal') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Toast(msg: 'Nomor / sandi salah');
            });
      } else {
        int id = data['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', id.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Bnb(
                      id: id.toString(),
                    )));
      }
    }

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Warna.warna3,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                              MediaQuery.of(context).size.height / 15))),
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.height / 3,
                    child: Image.asset('images/logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(2, 2),
                                blurRadius: 2),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(-2, 2),
                                blurRadius: 2)
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'M a s u k',
                                  style: TextStyle(
                                      color: Warna.warna1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                      controller: _nomorController,
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          hintText: '8xxxxxxxxxx',
                                          prefixIcon: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('+62'),
                                            ],
                                          ),
                                          label: Text('Nomor Handphone'),
                                          labelStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'isi nomor handphone!';
                                        }
                                        return null;
                                      }),
                                ),
                                TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        label: Text('Kata Sandi'),
                                        labelStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'isi kata sandi!';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Toast(
                                                msg: 'Tunggu sebentar...');
                                          });
                                      login();
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Warna.warna1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Center(
                                        child: Text(
                                          'MASUK',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun?',
                style: TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  ' DAFTAR',
                  style: TextStyle(
                      color: Warna.warna1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

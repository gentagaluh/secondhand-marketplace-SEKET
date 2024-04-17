import 'dart:convert';
import 'dart:io';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/screen/bnb/bnb.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/palette.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _kotaController = TextEditingController();

  TextEditingController _tahunController = TextEditingController();

  TextEditingController _nomorController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  File? image;
  Future getCam() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      image = File(photo.path);
    }
    setState(() {});
  }

  Future getGal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.gallery);
    if (foto != null) {
      image = File(foto.path);
    }
    setState(() {});
  }


  Future addSkin(String id, String url) async {
    var response = await http.post(Uri.parse(url+'api/skin/add'), body: {'id_user': id});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    Future register() async {
      var request = http.MultipartRequest(
          'POST', Uri.parse(currentUrl+'api/user/register'));
      request.fields["nama"] = _namaController.text;
      request.fields["kota"] = _kotaController.text;
      request.fields["tahun_kelahiran"] = _tahunController.text;
      request.fields["nomor_hp"] = _nomorController.text;
      request.fields["password"] = _passwordController.text;
      request.files
          .add(await http.MultipartFile.fromPath("foto_profil", image!.path));
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      Map data = json.decode(responsed.body);
      String msg = data['message'];
      if (msg == 'sudah ada') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Toast(msg: 'Nomor hp telah digunakan');
            });
      } else {
        int id = data['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', id.toString());
        addSkin(id.toString(), currentUrl);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Bnb(id: id.toString())));
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
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: image == null
                          ? GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  var status = await Permission
                                                      .camera.status;
                                                  if (!status.isGranted) {
                                                    Permission.camera.request();
                                                  } else {
                                                    getCam();
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera,
                                                        size: 40,
                                                        color: Warna.warna1,
                                                      ),
                                                      Text(
                                                        'KAMERA',
                                                        style: TextStyle(
                                                            color: Warna.warna1,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  getGal();
                                                  Navigator.pop(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        size: 40,
                                                        color: Warna.warna1,
                                                      ),
                                                      Text(
                                                        'GALERI',
                                                        style: TextStyle(
                                                            color: Warna.warna1,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.face,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.height /
                                          8,
                                    ),
                                    Text(
                                      'Foto Profil',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  var status = await Permission
                                                      .camera.status;
                                                  if (!status.isGranted) {
                                                    Permission.camera.request();
                                                  } else {
                                                    getCam();
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.camera,
                                                        size: 40,
                                                        color: Warna.warna1,
                                                      ),
                                                      Text(
                                                        'KAMERA',
                                                        style: TextStyle(
                                                            color: Warna.warna1,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  getGal();
                                                  Navigator.pop(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        size: 40,
                                                        color: Warna.warna1,
                                                      ),
                                                      Text(
                                                        'GALERI',
                                                        style: TextStyle(
                                                            color: Warna.warna1,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                backgroundImage: FileImage(image!),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'UBAH',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
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
                                'D a f t a r',
                                style: TextStyle(
                                    color: Warna.warna1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                    controller: _namaController,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        label: Text('Nama'),
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
                                        return 'isi nama!';
                                      }
                                      return null;
                                    }),
                              ),
                              TextFormField(
                                  controller: _kotaController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.location_city,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      label: Text('Asal Kota'),
                                      labelStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
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
                                      return 'isi asal kota!';
                                    }
                                    return null;
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                    controller: _tahunController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.calendar_month,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        label: Text('Tahun Lahir'),
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
                                        return 'isi tahun lahir!';
                                      }
                                      return null;
                                    }),
                              ),
                              TextFormField(
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
                                          color: Colors.black.withOpacity(0.5)),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
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
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (image != null) {
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Toast(
                                                msg: 'Tunggu sebentar...');
                                          });
                                      register();
                                    }
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Toast(msg: 'isi foto profil');
                                        });
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
                                        'DAFTAR',
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
              'Sudah punya akun?',
              style: TextStyle(fontSize: 12),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                ' MASUK',
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
    ));
  }
}

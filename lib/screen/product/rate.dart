import 'dart:io';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/acc/accuser.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Rate extends StatefulWidget {
  final Map product;
  final String id;
  Rate({
    required this.product,
    required this.id,
  });

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  TextEditingController _rate = TextEditingController();

  int _counter = 1;

  void _tambah() {
    if (_counter < 5) {
      setState(() {
        _counter++;
      });
    }
  }

  void _kurang() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }
Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }
  Future rate(String url) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(url+'api/rate/add'));
    request.fields["id_user"] = widget.product['id'].toString();
    request.fields["id_produk"] = widget.product['id_produk'].toString();
    request.fields["id_buyer"] = widget.id.toString();
    request.fields["total_rating"] = _rate.text;
    request.files
        .add(await http.MultipartFile.fromPath("bukti_pembelian", image!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    return json.decode(responsed.body);
  }

  

  Future addNotif(String url) async {
    
    var response = await http.post(Uri.parse(url+'api/notif/add'), body: {
      'id_user': widget.product['id'].toString(),
      'id_produk': widget.product['id_produk'].toString(),
      'id_buyer': widget.id.toString(),
      'foto': 'rate.png',
      'notif':
          'Seseorang telah memberikan penilaian ke produk anda, klik untuk selengkapnya'
    });
    return json.decode(response.body);
  }

  Future addSkin(int pls,String url) async {
    var response = await http.put(
        Uri.parse(url+'api/skin/plus/' +
            widget.product['id'].toString()),
        body: {"plus": pls.toString()});
    return json.decode(response.body);
  }

  Future rated(String url) async {
    
    var response = await http.put(Uri.parse(url+'api/product/edit/' +
        widget.product['id_produk'].toString()), body: {"sold": "rated"});
    return json.decode(response.body);
  }

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

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    _rate.text = _counter.toString();
    int plus = _counter * 5;

    return Scaffold(
      backgroundColor: Warna.warna4,
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            Container(
              color: Warna.warna3,
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  currentUrl+'image/product/' +
                      widget.product['foto_produk']),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: Warna.warna3,
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Warna.warna2,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CircleAvatar(
                                  backgroundColor: Warna.warna1,
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      currentUrl+'image/userPartner/' +
                                          widget.product['foto_profil']),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Warna.warna4.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.product['nama'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                        Text(
                                          widget.product['kota'],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccUser(
                                        id: widget.id,
                                        product: widget.product)));
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Kunjungi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                  ),
                                  Text(
                                    'Penjual',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Warna.warna1,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            NamaJudul(text1: 'Penilaian', text2: 'Peni'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.product['nama_produk'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.1),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _kurang,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Warna.warna2,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Text(
                        '-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Warna.warna1),
                      )),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(color: Colors.black),
                      enabled: false,
                      controller: _rate,
                    ),
                  ),
                  GestureDetector(
                    onTap: _tambah,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Warna.warna2,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Text(
                        '+',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Warna.warna1),
                      )),
                    ),
                  )
                ],
              ),
            ),
            NamaJudul(text1: 'Bukti', text2: 'Bu'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Sertakan bukti pembelian ' + widget.product['nama_produk'],
                textAlign: TextAlign.center,
              ),
            ),
            image != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
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
                                            var status =
                                                await Permission.camera.status;
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
                                                  MainAxisAlignment.center,
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
                                                          FontWeight.bold),
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
                                                  MainAxisAlignment.center,
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
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.width / 2,
                                width: MediaQuery.of(context).size.width / 2,
                                color: Colors.black,
                                child: Image.file(image!)),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  'UBAH',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: GestureDetector(
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
                                          var status =
                                              await Permission.camera.status;
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
                                                MainAxisAlignment.center,
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
                                                        FontWeight.bold),
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
                                                MainAxisAlignment.center,
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
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.black.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width / 6,
                                ),
                                Text('Unggah Bukti',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  if (image != null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            content: Container(
                              decoration: BoxDecoration(
                                  color: Warna.warna3,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: UnconstrainedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Kirim?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.product['id']
                                                      .toString() ==
                                                  widget.id) {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Toast(
                                                          msg:
                                                              'nilai produk lain');
                                                    });
                                              } else {
                                                rate(currentUrl);
                                                addNotif(currentUrl);
                                                addSkin(plus, currentUrl);
                                                rated(currentUrl);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text(
                                              'Iya',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Batal'))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Toast(msg: 'unggah bukti foto');
                        });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Warna.warna1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'KIRIM',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../model/palette.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddProduct extends StatefulWidget {
  final String id;
  AddProduct({required this.id});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _deskripsiController = TextEditingController();

  TextEditingController _hargaController = TextEditingController();

  TextEditingController _kategoriController = TextEditingController();

  TextEditingController _subkategoriController = TextEditingController();

  Future addProduct(String url) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(url+'api/product/add'));
    request.fields["id_user"] = widget.id;
    request.fields["nama_produk"] = _namaController.text;
    request.fields["kategori"] = _kategoriController.text;
    request.fields["sub_kategori"] = _subkategoriController.text;
    request.fields["deskripsi"] = _deskripsiController.text;
    request.fields["harga"] = _hargaController.text;
    request.files
        .add(await http.MultipartFile.fromPath("foto_produk", image!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    return json.decode(responsed.body);
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

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
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

  Future getKategori(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/kategori/all'));
    return json.decode(response.body);
  }

  String kategori = '...';
  String subkategori = '...';

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    _kategoriController.text = kategori;
    void ubahKategori(ktgr) {
      setState(() {
        kategori = ktgr;
      });
    }

    Future getSub() async {
      var response = await http.get(Uri.parse(
          currentUrl+'api/subkategori/kategori/' +
              kategori));
      return json.decode(response.body);
    }

    _subkategoriController.text = subkategori;
    void ubahSubkategori(sbktgr) {
      setState(() {
        subkategori = sbktgr;
      });
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  'JUAL',
                  style: TextStyle(
                      color: Warna.warna1,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  'Produk',
                  style: TextStyle(
                      color: Warna.warna2,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _namaController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              label: Text('Nama Produk'),
                              labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'isi nama produk!';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Kategori : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(_kategoriController.text)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder(
                            future: getKategori(currentUrl),
                            builder: (context, sp) {
                              if (sp.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ubahKategori(sp.data['data'][index]
                                                ['nama_kategori']);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Warna.warna3,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  sp.data['data'][index]
                                                      ['nama_kategori'],
                                                  style: TextStyle(
                                                      color: Warna.warna1,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: sp.data['data'].length,
                                );
                              } else {
                                return Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Warna.warnaload),
                                    ),
                                  ],
                                );
                              }
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _kategoriController.text == '...'
                          ? Row(
                              children: [
                                Text(
                                  'Sub Kategori : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_subkategoriController.text)
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Sub Kategori : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(_subkategoriController.text)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: FutureBuilder(
                                      future: getSub(),
                                      builder: (context, sp) {
                                        if (sp.hasData) {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      ubahSubkategori(sp
                                                                  .data['data']
                                                              [index]
                                                          ['nama_subkategori']);
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: Warna.warna3,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Text(
                                                            sp.data['data']
                                                                    [index][
                                                                'nama_subkategori'],
                                                            style: TextStyle(
                                                                color: Warna
                                                                    .warna1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: sp.data['data'].length,
                                          );
                                        } else {
                                          return Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Warna.warnaload),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                            controller: _deskripsiController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                label: Text('Deskripsi'),
                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'isi deskripsi!';
                              }
                              return null;
                            }),
                      ),
                      TextFormField(
                          controller: _hargaController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              label: Text('Harga'),
                              labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'isi harga!';
                            }
                            return null;
                          }),
                      image != null
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
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        color: Colors.black,
                                        child: Image.file(image!)),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.black.withOpacity(0.5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_library,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Foto Produk',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          if (_kategoriController.text == '...') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Toast(msg: 'pilih kategori');
                                });
                          } else if (_subkategoriController.text == '...') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Toast(msg: 'pilih subkategori');
                                });
                          } else if (image == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Toast(msg: 'isi foto profil');
                                });
                          } else {
                            if (_formKey.currentState!.validate()) {
                              addProduct(currentUrl);
                              Navigator.pop(context);
                            }
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
                                'JUAL',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

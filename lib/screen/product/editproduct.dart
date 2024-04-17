import 'dart:convert';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../model/palette.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  final Map product;
  EditProduct({required this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _deskripsiController = TextEditingController();

  TextEditingController _hargaController = TextEditingController();

  TextEditingController _kategoriController = TextEditingController();

  TextEditingController _subkategoriController = TextEditingController();

  Future edit(String id,String url) async {
    var response = await http.put(
        Uri.parse(url+'api/product/edit/' + id),
        body: {
          "nama_produk": _namaController.text,
          "deskripsi": _deskripsiController.text,
          "harga": _hargaController.text,
          "kategori": _kategoriController.text,
          "sub_kategori": _subkategoriController.text,
        });

    return json.decode(response.body);
  }

  Future getKategori(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/kategori/all'));
    return json.decode(response.body);
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  String kategori = '...';
  String subkategori = '...';
  void initState() {
    super.initState();
    _namaController.text = widget.product['nama_produk'];
    _deskripsiController.text = widget.product['deskripsi'];
    _hargaController.text = widget.product['harga'].toString();
  }

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
                  'UBAH',
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
                      SizedBox(
                        height: 10,
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
                          } else {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Toast(msg: 'Tunggu sebentar...');
                                  });
                              edit(widget.product['id_produk'].toString(), currentUrl);
                              Navigator.pop(context);
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
                                'UBAH',
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
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

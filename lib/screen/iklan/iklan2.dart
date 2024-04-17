import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../model/palette.dart';

class Iklan2 extends StatefulWidget {
  final Map product;
  final String id;
  Iklan2({
    required this.product,
    required this.id,
  });

  @override
  State<Iklan2> createState() => _Iklan2State();
}

class _Iklan2State extends State<Iklan2> {
  Future iklan2(String url) async {
    
    var response = await http.put(Uri.parse(url+'api/product/edit/' +
        widget.product['id_produk'].toString()), body: {"iklan2": "yes"});
    return json.decode(response.body);
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future getSkin(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/skin/id/' + widget.id.toString()));
    return json.decode(response.body);
  }

  Future min(String url) async {
    var response = await http.put(
        Uri.parse(url+'api/skin/min/' +
            widget.id.toString()),
        body: {"min": "100"});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: refresh,
      color: Warna.warna1,
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  )),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Warna.warna3,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.only(left: 13, top: 10),
                  child: Text(
                    'I k l a n  2',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Warna.warna1,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Text(
              'Produk anda akan dipromosikan',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  'pada bagian ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Beranda',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          NamaJudul(text1: 'Rekomendasi', text2: 'Rekom'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 8 / 9),
              children: [
                Product(
                    namaProduk: widget.product['nama_produk'],
                    harga: widget.product['harga'].toString(),
                    kota: widget.product['kota'],
                    fotoProduk: widget.product['foto_produk'],
                    warna3: Colors.yellow,
                    warna4: Warna.warnak3),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Warna.warnak3),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        content: Container(
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: Warna.warna3,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(
                              children: [
                                FutureBuilder(
                                    future: getSkin(currentUrl),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        int skin =
                                            snapshot.data['data'][0]['skin'];
                                        return Column(
                                          children: [
                                            Text('Skin Kamu',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(skin.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                'perlu 100 skin untuk memasang iklan ini',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            skin > 99
                                                ? GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Toast(
                                                                msg:
                                                                    'Tunggu sebentar...');
                                                          });
                                                      iklan2(currentUrl);
                                                      min(currentUrl).then((value) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Warna.warna1),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Center(
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '*skinmu kurang',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 10),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Warna.warna1),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Center(
                                                              child: Text(
                                                                'KEMBALI',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            Text(
                                              '...',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40),
                                            ),
                                          ],
                                        );
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    });
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
                      'IKLANKAN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

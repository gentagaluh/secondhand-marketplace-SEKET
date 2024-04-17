import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../model/palette.dart';

class Fav extends StatefulWidget {
  final String id;
  Fav({required this.id});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  TextEditingController _search = TextEditingController();
  Future getPic(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/user/pic/id/' + widget.id));
    return json.decode(response.body);
  }

  Future getFav(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/favorit/' + widget.id));
    return json.decode(response.body);
  }

  Future search(String url) async {
    var response = await http.post(
        Uri.parse(url+'api/product/searchfav'),
        body: {"search": _search.text, "id_buyer": widget.id});
    return json.decode(response.body);
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
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
            Container(
              color: Warna.warna3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'F a v o r i t',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Warna.warna1),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Warna.warna1,
                      child: FutureBuilder(
                          future: getPic(currentUrl),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
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
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: UnconstrainedBox(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Keluar?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: logout,
                                                          child: Text(
                                                            'Iya',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('Batal'))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Warna.warna1,
                                  radius: 17,
                                  backgroundImage: NetworkImage(
                                      currentUrl+'image/userPartner/' +
                                          snapshot.data['data'][0]
                                              ['foto_profil']),
                                ),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.grey,
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _search,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    fillColor: Warna.warna4,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
            ),
            _search.text == ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: getFav(currentUrl),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            childAspectRatio: 8 / 9),
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder: (context, index) {
                                      Future deleteFav() async {
                                        var response = await http.delete(Uri.parse(
                                            currentUrl+'api/favorit/delete/' +
                                                widget.id +
                                                '/' +
                                                snapshot.data['data'][index]
                                                        ['id_produk']
                                                    .toString()));
                                        return json.decode(response.body);
                                      }

                                      String nomor = '+62' +
                                          snapshot.data['data'][index]
                                              ['nomor_hp'];
                                      String barang = snapshot.data['data']
                                          [index]['nama_produk'];
                                      String pesan =
                                          'Permisi, saya melihat $barang di aplikasi SeKet, apakah masih tersedia?';
                                      final Uri url = Uri.parse(
                                          'https://wa.me/$nomor?text=$pesan');
                                      Future whatsapp() async {
                                        await launchUrl(url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }

                                      return LayoutBuilder(
                                          builder: (context, constraint) {
                                        return FavModel(
                                          buy: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      content: Container(
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            color: Warna.warna3,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: ListView(
                                                            children: [
                                                              Text(
                                                                  'Pembelian atau transaksi produk ini akan dialihkan ke whatsapp penjual, pastikan untuk tetap berhati-hati dan selamat bertransaksi'),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  whatsapp();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .green),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'OKE, BELI SEKARANG',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              height: constraint.maxWidth * 0.2,
                                              width: constraint.maxWidth * 0.5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    color: Warna.warna4,
                                                    size: constraint.maxWidth *
                                                        0.15,
                                                  ),
                                                  Text(
                                                    'BELI',
                                                    style: TextStyle(
                                                      color: Warna.warna4,
                                                      fontSize:
                                                          constraint.maxWidth *
                                                              0.1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          tujuh: constraint.maxWidth * 0.7,
                                          namaProduk: snapshot.data['data']
                                              [index]['nama_produk'],
                                          fotoProduk: snapshot.data['data']
                                              [index]['foto_produk'],
                                          idProduk: snapshot.data['data'][index]
                                                  ['id_produk']
                                              .toString(),
                                          product: snapshot.data['data'][index],
                                          buttonDelete: GestureDetector(
                                            onTap: () {
                                              deleteFav();
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: constraint.maxWidth * 0.2,
                                              width: constraint.maxWidth * 0.2,
                                              child: Icon(Icons.delete,
                                                  size: constraint.maxWidth *
                                                      0.15),
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              } else {
                                return Load();
                              }
                            }),
                        Center(
                          child: Text(
                            '- HASIL AKHIR -',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: search(currentUrl),
                    builder: (context, sp) {
                      if (sp.hasData) {
                        if (sp.data['message'] == 'tidak ada') {
                          return Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: MediaQuery.of(context).size.width / 4,
                              ),
                              Text(
                                'Produk tidak ditemukan...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder(
                                future: search(currentUrl),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 8 / 9),
                                        itemCount: snapshot.data['data'].length,
                                        itemBuilder: (context, index) {
                                          Future deleteFav() async {
                                            var response = await http.delete(
                                                Uri.parse(
                                                    currentUrl+'api/favorit/delete/' +
                                                        widget.id +
                                                        '/' +
                                                        snapshot.data['data']
                                                                [index]
                                                                ['id_produk']
                                                            .toString()));
                                            return json.decode(response.body);
                                          }

                                          return LayoutBuilder(
                                              builder: (context, constraint) {
                                            return FavModel(
                                              buy: Container(
                                                height:
                                                    constraint.maxWidth * 0.2,
                                                width:
                                                    constraint.maxWidth * 0.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Warna.warna4,
                                                      size:
                                                          constraint.maxWidth *
                                                              0.15,
                                                    ),
                                                    Text(
                                                      'BELI',
                                                      style: TextStyle(
                                                        color: Warna.warna4,
                                                        fontSize: constraint
                                                                .maxWidth *
                                                            0.1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              tujuh: constraint.maxWidth * 0.7,
                                              namaProduk: snapshot.data['data']
                                                  [index]['nama_produk'],
                                              fotoProduk: snapshot.data['data']
                                                  [index]['foto_produk'],
                                              idProduk: snapshot.data['data']
                                                      [index]['id_produk']
                                                  .toString(),
                                              product: snapshot.data['data']
                                                  [index],
                                              buttonDelete: GestureDetector(
                                                onTap: () {
                                                  deleteFav();
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height:
                                                      constraint.maxWidth * 0.2,
                                                  width:
                                                      constraint.maxWidth * 0.2,
                                                  child: Icon(Icons.delete,
                                                      size:
                                                          constraint.maxWidth *
                                                              0.15),
                                                ),
                                              ),
                                            );
                                          });
                                        });
                                  } else {
                                    return Load();
                                  }
                                }),
                          );
                        }
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Load(),
                        );
                      }
                    }),
          ],
        ),
      ),
    );
  }
}

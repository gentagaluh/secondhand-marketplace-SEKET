import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/screen/product/detailproduct.dart';
import 'package:app_seket/screen/product/kategori/subkategori.dart';
import 'package:app_seket/screen/product/search.dart';
import 'package:app_seket/screen/product/sold.dart';
import 'package:app_seket/url.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_seket/model/product.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String id;
  Home({required this.id});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future getPic(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/user/pic/id/' + widget.id));
    return json.decode(response.body);
  }

  Future Iklan1(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/product/iklan1'));
    return json.decode(response.body);
  }

  Future Iklan2(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/product/iklan2'));
    return json.decode(response.body);
  }

  Future getNotSold(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/product/notsold'));
    return json.decode(response.body);
  }

  Future getKategori(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/kategori/all'));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    Future logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('id');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Sold(
                        id: widget.id,
                      )));
        },
        child: Icon(
          Icons.star,
          color: Colors.orange,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: RefreshIndicator(
        color: Warna.warna1,
        onRefresh: refresh,
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
                      'B e r a n d a',
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
                                  radius: 17,
                                  backgroundColor: Warna.warna1,
                                  backgroundImage: NetworkImage(
                                      currentUrl+'image/userPartner/' +
                                          snapshot.data['data'][0]
                                              ['foto_profil']),
                                ),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 17,
                                backgroundColor: Warna.warnaload,
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: Iklan1(currentUrl),
                builder: (context, snapshot2) {
                  if (!snapshot2.hasData) {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Tutor(
                                  foto: 'images/4.jpg',
                                );
                              });
                        },
                        child: Iklan1Null());
                  } else {
                    List dataList = snapshot2.data['data'];
                    if (dataList.length > 0) {
                      return CarouselSlider.builder(
                          itemCount: snapshot2.data['data'].length,
                          itemBuilder: (context, index, realIndex) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailProduct(
                                            id: widget.id,
                                            product: snapshot2.data['data']
                                                [index])));
                              },
                              child: Iklan1Model(
                                  fotoProduk: snapshot2.data['data'][index]
                                      ['foto_produk'],
                                  kategori: snapshot2.data['data'][index]
                                      ['kategori'],
                                  namaProduk: snapshot2.data['data'][index]
                                      ['nama_produk'],
                                  kota: snapshot2.data['data'][index]['kota'],
                                  harga: snapshot2.data['data'][index]['harga']
                                      .toString()),
                            );
                          },
                          options: CarouselOptions(
                              autoPlay: true, viewportFraction: 1));
                    } else {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Tutor(
                                    foto: 'images/4.jpg',
                                  );
                                });
                          },
                          child: Iklan1Null());
                    }
                  }
                }),
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Warna.warna1,
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Warna.warnak2,
                      height: 20,
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            color: Warna.warna4),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(20)),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Kategori  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
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
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Warna.warna4),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: ListView(
                                                  children: [
                                                    FutureBuilder(
                                                        future: getKategori(currentUrl),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return GridView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        mainAxisSpacing:
                                                                            10,
                                                                        childAspectRatio:
                                                                            1.7 /
                                                                                2,
                                                                        crossAxisCount:
                                                                            3),
                                                                    itemCount: snapshot
                                                                        .data[
                                                                            'data']
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => SubKategoriScreen(kategori: snapshot.data['data'][index])));
                                                                          },
                                                                          child: KategoriModel(
                                                                              foto: snapshot.data['data'][index]['foto'],
                                                                              namaKategori: snapshot.data['data'][index]['nama_kategori']));
                                                                    });
                                                          } else {
                                                            return Row(
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.4,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Warna
                                                                          .warnaload),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text('Lihat semua'))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2))
                            ],
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10)),
                            color: Warna.warna4),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FutureBuilder(
                              future: getKategori(currentUrl),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 1.7 / 2,
                                              crossAxisCount: 1),
                                      itemCount: snapshot.data['data'].length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubKategoriScreen(
                                                            kategori:
                                                                snapshot.data[
                                                                        'data']
                                                                    [index])));
                                          },
                                          child: KategoriModel(
                                              foto: snapshot.data['data'][index]
                                                  ['foto'],
                                              namaKategori:
                                                  snapshot.data['data'][index]
                                                      ['nama_kategori']),
                                        );
                                      });
                                } else {
                                  return Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
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
                      ),
                    ),
                  ],
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(id: widget.id)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Warna.warna4),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 5),
                          child: Text(
                            '|',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Cari sesuatu')
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //rekomendasi
            NamaJudul(text1: 'Rekomendasi', text2: 'Rekom'),
            FutureBuilder(
                future: Iklan2(currentUrl),
                builder: (context, snapshot3) {
                  if (snapshot3.hasData) {
                    List dataList = snapshot3.data['data'];
                    if (dataList.length > 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 8 / 9),
                            itemCount: snapshot3.data['data'].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailProduct(
                                              id: widget.id,
                                              product: snapshot3.data['data']
                                                  [index])));
                                },
                                child: LayoutBuilder(
                                    builder: (context, constriant) {
                                  return Stack(
                                    children: [
                                      Product(
                                        namaProduk: snapshot3.data['data']
                                            [index]['nama_produk'],
                                        harga: snapshot3.data['data'][index]
                                                ['harga']
                                            .toString(),
                                        kota: snapshot3.data['data'][index]
                                            ['kota'],
                                        fotoProduk: snapshot3.data['data']
                                            [index]['foto_produk'],
                                        warna3: Colors.yellow,
                                        warna4: Warna.warnak3,
                                      ),
                                      Container(
                                        width: constriant.maxWidth * 0.2,
                                        height: constriant.maxWidth * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                            color: Colors.orange),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: constriant.maxHeight * 0.15,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }),
                      );
                    } else {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Tutor(foto: 'images/5.jpg');
                                });
                          },
                          child: Iklan2Null());
                    }
                  } else {
                    return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Tutor(foto: 'images/5.jpg');
                              });
                        },
                        child: Iklan2Null());
                  }
                }),

            //terbaru
            NamaJudul(text1: 'Terbaru', text2: 'Ter'),
            FutureBuilder(
                future: getNotSold(currentUrl),
                builder: (context, snapshot4) {
                  if (snapshot4.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 8 / 9),
                          itemCount: snapshot4.data['data'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailProduct(
                                            id: widget.id,
                                            product: snapshot4.data['data']
                                                [index])));
                              },
                              child: Product(
                                namaProduk: snapshot4.data['data'][index]
                                    ['nama_produk'],
                                harga: snapshot4.data['data'][index]['harga']
                                    .toString(),
                                kota: snapshot4.data['data'][index]['kota'],
                                fotoProduk: snapshot4.data['data'][index]
                                    ['foto_produk'],
                                warna3: Warna.warna3,
                                warna4: Warna.warna4,
                              ),
                            );
                          }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Load(),
                    );
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
      ),
    );
  }
}

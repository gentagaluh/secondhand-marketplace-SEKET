import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/addproduct.dart';
import 'package:app_seket/screen/product/detailpruser.dart';
import 'package:app_seket/screen/product/usrrated.dart';
import 'package:app_seket/screen/product/usrsold.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Business extends StatefulWidget {
  final String id;
  Business({required this.id});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  Future getPic(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/user/pic/id/' + widget.id));
    return json.decode(response.body);
  }

  Future getSkin(String url) async {
    var response = await http.get(
        Uri.parse(url+'api/skin/id/' + widget.id));
    return json.decode(response.body);
  }

  Future getRate(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/rate/avg/id/' + widget.id));
    return json.decode(response.body);
  }

  Future getNotSold(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/notsold/id/' + widget.id));
    return json.decode(response.body);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.yellow,
              heroTag: 'rated',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UsrRated(
                              id: widget.id,
                            )));
              },
              label: Icon(
                Icons.star,
                color: Colors.orange,
              )),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
              backgroundColor: Colors.black,
              heroTag: 'sold',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UsrSold(
                              id: widget.id,
                            )));
              },
              label: Icon(
                Icons.star,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            FutureBuilder(
                future: getSkin(currentUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int skin = snapshot.data['data'][0]['total'];
                    backcolor() {
                      if (skin >= 0 && skin <= 200) {
                        return Warna.warnabrown;
                      } else if (skin >= 201 && skin <= 400) {
                        return Warna.warnasilver;
                      } else if (skin >= 401 && skin <= 600) {
                        return Warna.warnagold;
                      } else {
                        return Warna.warnadiamond;
                      }
                    }

                    String backtext() {
                      if (skin >= 0 && skin <= 200) {
                        return 'Brown';
                      } else if (skin >= 201 && skin <= 400) {
                        return 'Silver';
                      } else if (skin >= 401 && skin <= 600) {
                        return 'Gold';
                      } else {
                        return 'Diamond';
                      }
                    }

                    ImageProvider backimg() {
                      if (skin >= 0 && skin <= 200) {
                        return AssetImage('images/brown.png');
                      } else if (skin >= 201 && skin <= 400) {
                        return AssetImage('images/silver.png');
                      } else if (skin >= 401 && skin <= 600) {
                        return AssetImage('images/gold.png');
                      } else {
                        return AssetImage('images/diamond.png');
                      }
                    }

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShowDialogBack(
                                  nama: 'Kamu',
                                  backtext: backtext(),
                                  backcolor: backcolor(),
                                  totalSkin: snapshot.data['data'][0]['total']
                                      .toString());
                            });
                      },
                      child: Background(
                          backcolor: backcolor(), backimage: backimg()),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: MediaQuery.of(context).size.width / 1.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Warna.warnaload),
                      ),
                    );
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ShowDialogRate(nama: 'kamu');
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                  future: getRate(currentUrl),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.hasData) {
                                      return Text(
                                        snapshot2.data['data'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      );
                                    } else {
                                      return Text(
                                        '...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      );
                                    }
                                  }),
                              Text(
                                '/5',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        color: Colors.white, child: Text('Rating Pembeli'))
                  ],
                ),
                FutureBuilder(
                    future: getSkin(currentUrl),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int skin = snapshot.data['data'][0]['pelanggaran'];
                        backcolor() {
                          if (skin >= 0 && skin <= 200) {
                            return Colors.green;
                          } else if (skin >= 201 && skin <= 400) {
                            return Colors.orange;
                          } else if (skin >= 401 && skin <= 600) {
                            return Colors.red;
                          }
                        }

                        String backtext() {
                          if (skin >= 0 && skin <= 200) {
                            return 'A';
                          } else if (skin >= 201 && skin <= 400) {
                            return 'B';
                          } else if (skin >= 401 && skin <= 600) {
                            return 'C';
                          } else {
                            return '-';
                          }
                        }

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shadowColor: Colors.transparent,
                                        contentPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                              color: Warna.warna3,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ListView(
                                              children: [
                                                Text(
                                                    'Urutan tingkat pelanggaran penjual :'),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.green),
                                                      child: Center(
                                                        child: Text(
                                                          'A',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      ' : Bagus',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.orange),
                                                      child: Center(
                                                        child: Text(
                                                          'B',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      ' : Sedang',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                          'C',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      ' : Buruk',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    'Peringatan! semakin buruk indeks pelanggaran user maka user dianggap sering melakukan pelanggaran dan berpotensi di ban')
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 47,
                                width: 47,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: backcolor()),
                                child: Center(
                                  child: Text(
                                    backtext(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                color: Colors.white, child: Text('Pelanggaran'))
                          ],
                        );
                      } else {
                        return Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Warna.warnaload),
                        );
                      }
                    })
              ],
            ),
            NamaJudul(text1: 'Skin & Jual', text2: 'Skin '),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              content: Container(
                                decoration: BoxDecoration(
                                    color: Warna.warna3,
                                    borderRadius: BorderRadius.circular(10)),
                                child: UnconstrainedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Skinmu : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        FutureBuilder(
                                            future: getSkin(currentUrl),
                                            builder: (context, sp) {
                                              if (sp.hasData) {
                                                return Text(
                                                  sp.data['data'][0]['skin']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Warna.warna1,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else {
                                                return Text('...');
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: Warna.warna1.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 6,
                            width: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 4,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: FutureBuilder(
                                  future: getSkin(currentUrl),
                                  builder: (context, sp) {
                                    if (sp.hasData) {
                                      return Text(
                                        sp.data['data'][0]['skin'].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10),
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    } else {
                                      return Text(
                                        '...',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 6,
                            width: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.width / 4,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddProduct(id: widget.id)));
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Warna.warna1,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.money,
                                          color: Colors.white,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'klik untuk berjualan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            NamaJudul(text1: 'Produkmu', text2: 'Pro'),
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
                                        builder: (context) => DetailPrUser(
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

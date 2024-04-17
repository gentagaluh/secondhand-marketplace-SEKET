import 'dart:convert';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/rate.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Sold extends StatefulWidget {
  final String id;
  Sold({required this.id});

  @override
  State<Sold> createState() => _SoldState();
}

class _SoldState extends State<Sold> {
  Future sold(String url) async {
    var response = await http
        .get(Uri.parse(url+'api/product/sold'));
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
      backgroundColor: Warna.warna4,
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 35,
                  color: Warna.warna3,
                ),
                NamaJudul(text1: 'Penilaian', text2: 'Peni')
              ],
            ),
            FutureBuilder(
                future: sold(currentUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rate(
                                              id: widget.id,
                                              product: snapshot.data['data']
                                                  [index],
                                            )));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Product(
                                      namaProduk: snapshot.data['data'][index]
                                          ['nama_produk'],
                                      harga: snapshot.data['data'][index]
                                              ['harga']
                                          .toString(),
                                      kota: snapshot.data['data'][index]
                                          ['kota'],
                                      fotoProduk: snapshot.data['data'][index]
                                          ['foto_produk'],
                                      warna3: Warna.warna3,
                                      warna4: Warna.warna4),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Beri',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Penilaian',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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

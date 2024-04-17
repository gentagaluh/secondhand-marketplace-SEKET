import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../model/palette.dart';

class UsrRated extends StatefulWidget {
  final String id;
  UsrRated({required this.id});

  @override
  State<UsrRated> createState() => _UsrRatedState();
}

class _UsrRatedState extends State<UsrRated> {
  Future getRated(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/rated/' + widget.id));
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
      appBar: AppBar(
        backgroundColor: Warna.warna3,
        automaticallyImplyLeading: false,
        title: Text(
          'D i n i l a i',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Warna.warna1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            NamaJudul(text1: 'Sudah Dinilai', text2: 'Sudah '),
            FutureBuilder(
                future: getRated(currentUrl),
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
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Product(
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
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Penilaian',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 30,
                                        ),
                                        Text(
                                            snapshot4.data['data'][index]
                                                    ['total_rating']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
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

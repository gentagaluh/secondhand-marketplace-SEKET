import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/rate.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccSold extends StatefulWidget {
  final String id;
  final String idd;
  AccSold({required this.id, required this.idd});

  @override
  State<AccSold> createState() => _AccSoldState();
}

class _AccSoldState extends State<AccSold> {
  Future getSold(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/sold/id/' + widget.idd));
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
          'T e r j u a l',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Warna.warna1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            NamaJudul(text1: 'Produk Terjual', text2: 'Produk'),
            FutureBuilder(
                future: getSold(currentUrl),
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
                                        builder: (context) => Rate(
                                            product: snapshot4.data['data']
                                                [index],
                                            id: widget.id)));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Product(
                                    namaProduk: snapshot4.data['data'][index]
                                        ['nama_produk'],
                                    harga: snapshot4.data['data'][index]
                                            ['harga']
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
                                      Text('Beri',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text('Penilaian',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
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

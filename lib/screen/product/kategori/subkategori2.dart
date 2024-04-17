import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/detailproduct.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../model/palette.dart';

class SubKategori2 extends StatefulWidget {
  final String sub;
  SubKategori2({required this.sub});

  @override
  State<SubKategori2> createState() => _SubKategori2State();
}

class _SubKategori2State extends State<SubKategori2> {
  Future getProdukSub(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/subkategori/' + widget.sub));
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
                NamaJudul(text1: 'Sub Kategori', text2: 'Sub K')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Warna.warna3,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.9),
                      child: Text(
                        widget.sub,
                        style: TextStyle(
                            color: Warna.warna1,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getProdukSub(currentUrl),
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
                                            id: snapshot4.data['data'][index]
                                                    ['id']
                                                .toString(),
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

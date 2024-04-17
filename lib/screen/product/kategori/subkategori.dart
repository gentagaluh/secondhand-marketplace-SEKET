import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/detailproduct.dart';
import 'package:app_seket/screen/product/kategori/subkategori2.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class SubKategoriScreen extends StatefulWidget {
  final Map kategori;
  SubKategoriScreen({required this.kategori});

  @override
  State<SubKategoriScreen> createState() => _SubKategoriScreenState();
}

class _SubKategoriScreenState extends State<SubKategoriScreen> {
  Future getSub(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/subkategori/kategori/' +
            widget.kategori['nama_kategori']));
    return json.decode(response.body);
  }

  

  Future getProdukKat(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/product/kategori/' +
            widget.kategori['nama_kategori']));
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
                NamaJudul(text1: 'Kategori', text2: 'Kat')
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Warna.warna4,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Warna.warna2.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(50))),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundColor: Warna.warna3,
                            backgroundImage: NetworkImage(
                                currentUrl+'image/kategori/' +
                                    widget.kategori['foto']),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Warna.warna4),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(60)),
                              color: Warna.warna2.withOpacity(0.3)),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(
                              widget.kategori['nama_kategori'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Warna.warna1),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: FutureBuilder(
                    future: getSub(currentUrl),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SubKategori2(
                                                  sub: snapshot.data['data']
                                                          [index]
                                                      ['nama_subkategori'],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Warna.warna3,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        snapshot.data['data'][index]
                                            ['nama_subkategori'],
                                        style: TextStyle(
                                            color: Warna.warna1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            );
                          },
                          itemCount: snapshot.data['data'].length,
                        );
                      } else {
                        return Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Warna.warnaload,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ),
            NamaJudul(text1: 'Produk', text2: 'Pr'),
            FutureBuilder(
                future: getProdukKat(currentUrl),
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

import 'package:app_seket/model/product.dart';
import 'package:app_seket/screen/product/detailproduct.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../model/palette.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  final String id;
  Search({required this.id});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _search = TextEditingController();

  Future search(String url) async {
    var response = await http.post(
        Uri.parse(url+'api/product/search'),
        body: {"search": _search.text});
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: RefreshIndicator(
          onRefresh: refresh,
          color: Warna.warna1,
          child: ListView(
            children: [
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
                  ? Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: MediaQuery.of(context).size.width / 4,
                        ),
                        Text(
                          'Belum ada kata kunci...',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          childAspectRatio: 8 / 9),
                                  itemCount: sp.data['data'].length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProduct(
                                                        id: widget.id,
                                                        product: sp.data['data']
                                                            [index])));
                                      },
                                      child: Product(
                                        namaProduk: sp.data['data'][index]
                                            ['nama_produk'],
                                        harga: sp.data['data'][index]['harga']
                                            .toString(),
                                        kota: sp.data['data'][index]['kota'],
                                        fotoProduk: sp.data['data'][index]
                                            ['foto_produk'],
                                        warna3: Warna.warna3,
                                        warna4: Warna.warna4,
                                      ),
                                    );
                                  }),
                            );
                          }
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Load(),
                          );
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }
}

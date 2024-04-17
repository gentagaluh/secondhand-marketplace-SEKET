import 'dart:convert';

import 'package:app_seket/model/others.dart';
import 'package:app_seket/model/palette.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../acc/accuser.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetailProduct extends StatefulWidget {
  final String id;
  final Map product;
  DetailProduct({required this.id, required this.product});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  Future fav(String url) async {
    
    var response = await http.post(Uri.parse(url+'api/favorit/add'), body: {
      'id_buyer': widget.id,
      "id_produk": widget.product['id_produk'].toString(),
    });
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
    String nomor = '+62' + widget.product['nomor_hp'];
    String barang = widget.product['nama_produk'];
    String pesan =
        'Permisi, saya melihat $barang di aplikasi SeKet, apakah masih tersedia?';
    final Uri url = Uri.parse('https://wa.me/$nomor?text=$pesan');
    Future whatsapp() async {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }

    return Scaffold(
      backgroundColor: Warna.warna4,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Toast(msg: 'Berhasil ditambahkan');
                    });
                fav(currentUrl);
              },
              label: Icon(
                Icons.favorite,
                color: Colors.red,
              )),
          FloatingActionButton.extended(
              backgroundColor: Colors.green,
              heroTag: 'buy',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        content: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Warna.warna3,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          'OKE, BELI SEKARANG',
                                          style: TextStyle(color: Colors.white),
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
              label: Row(
                children: [Icon(Icons.phone), Text('Beli Sekarang')],
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            Container(
              color: Warna.warna3,
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  currentUrl+'image/product/' +
                      widget.product['foto_produk']),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: Warna.warna3,
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Warna.warna2,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CircleAvatar(
                                  backgroundColor: Warna.warna1,
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      currentUrl+'image/userPartner/' +
                                          widget.product['foto_profil']),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Warna.warna4.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.product['nama'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                        Text(
                                          widget.product['kota'],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccUser(
                                          id: widget.id,
                                          product: widget.product,
                                        )));
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    'Kunjungi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                  ),
                                  Text(
                                    'Penjual',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Warna.warna1,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            NamaJudul(text1: 'Kategori', text2: 'Kat'),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Warna.warna3,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.9),
                      child: Text(
                        widget.product['kategori'],
                        style: TextStyle(
                            color: Warna.warna1,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Warna.warna3,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.9),
                      child: Text(
                        widget.product['sub_kategori'],
                        style: TextStyle(
                            color: Warna.warna1,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.product['nama_produk'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.1),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Rp' + widget.product['harga'].toString(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.075),
                )),
            NamaJudul(text1: 'Deskripsi', text2: 'Desk'),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product['deskripsi'],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                )),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

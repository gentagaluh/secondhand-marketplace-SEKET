import 'package:app_seket/model/palette.dart';
import 'package:app_seket/screen/product/detailproduct.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product extends StatelessWidget {
  final String namaProduk;
  final String harga;
  final String kota;
  final String fotoProduk;
  final Color warna3;
  final Color warna4;
  Product({
    required this.namaProduk,
    required this.harga,
    required this.kota,
    required this.fotoProduk,
    required this.warna3,
    required this.warna4,
  });

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: warna4),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Warna.warna2,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                    currentUrl+'image/product/' +
                        fotoProduk),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: warna3, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 1,
                      offset: Offset(0, 3))
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Warna.warna3),
                  ),
                ),
              ),
              LayoutBuilder(builder: (context, constraint) {
                return Container(
                  width: constraint.maxWidth * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
              }),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    namaProduk,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 6, right: 5, left: 5, bottom: 2.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harga ',
                  style: TextStyle(fontSize: 9, color: Colors.red),
                ),
                Expanded(
                  child: Text(
                    'Rp' + harga,
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.red,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 2.5, right: 5, left: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 11,
                    color: Colors.green,
                  ),
                  Flexible(
                    child: Text(
                      kota,
                      style: TextStyle(
                          fontSize: 11, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class FavModel extends StatelessWidget {
  final String namaProduk;
  final String fotoProduk;
  final String idProduk;
  final double tujuh;
  final Map product;
  final Widget buttonDelete;
  final Widget buy;
  FavModel({
    required this.namaProduk,
    required this.fotoProduk,
    required this.idProduk,
    required this.product,
    required this.buttonDelete,
    required this.tujuh,
    required this.buy,
  });

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailProduct(id: idProduk, product: product)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Warna.warna4),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Warna.warna2,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                      currentUrl+'image/product/' +
                          fotoProduk),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Warna.warna3, boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 3))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Warna.warna3),
                    ),
                  ),
                ),
                Container(
                  width: tujuh,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      namaProduk,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, right: 5, left: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [buttonDelete, buy],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Iklan1Model extends StatelessWidget {
  final String fotoProduk;
  final String kategori;
  final String namaProduk;
  final String kota;
  final String harga;
  Iklan1Model({
    required this.fotoProduk,
    required this.kategori,
    required this.namaProduk,
    required this.kota,
    required this.harga,
  });
  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              color: Warna.warna1,
            ),
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.5623,
                  color: Warna.warnak2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: MediaQuery.of(context).size.width * 0.35),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.25)),
                        color: Colors.orange.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.25)),
                      color: Colors.orange.withOpacity(0.2)),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.width * 0.35)),
                      color: Colors.orange.withOpacity(0.2)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.4773,
                  color: Warna.warna2.withOpacity(0),
                  child: Image.network(currentUrl+
                      'image/product/' +
                          fotoProduk),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.5623,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.17,
                        height: MediaQuery.of(context).size.width * 0.085,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                            color: Colors.orange),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.5623,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.3)),
                    color: Warna.warna2.withOpacity(0.1)),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.2)),
                    color: Warna.warna2.withOpacity(0.05)),
              )
            ],
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Warna.warna2.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        offset: Offset(0, 3))
                  ]),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(kategori,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Warna.warna4,
                          fontSize: 25)),
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  namaProduk,
                  style: TextStyle(
                      color: Warna.warna3,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 10, left: 10, bottom: 2.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 11,
                      color: Colors.green,
                    ),
                    Flexible(
                      child: Text(
                        kota,
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 11,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Harga ',
                              style:
                                  TextStyle(color: Colors.yellow, fontSize: 9),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            'Rp' + harga,
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        )
      ],
    );
  }
}

class KategoriModel extends StatelessWidget {
  final String namaKategori;
  final String foto;
  KategoriModel({
    required this.namaKategori,
    required this.foto,
  });
  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 65,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Warna.warna3,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Warna.warna3,
                  backgroundImage: NetworkImage(
                      currentUrl+'image/kategori/' + foto),
                ),
              )),
          Text(
            namaKategori,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}

class Iklan1Null extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Row(
          children: [
            Container(
              color: Warna.warna1,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.5623,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                      ),
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        color: Warna.warna1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5623 / 9,
                  ),
                  Stack(
                    children: [
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                      ),
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        color: Warna.warna1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5623 / 9,
                  ),
                  Stack(
                    children: [
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 10))
                        ]),
                      ),
                      Container(
                        height:
                            MediaQuery.of(context).size.width * 0.5623 / 4.5,
                        color: Warna.warna1,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Warna.warnak2,
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.5623,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.25)),
                                color: Colors.orange.withOpacity(0.2)),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.15)),
                                color: Colors.orange.withOpacity(0.2)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.25)),
                                color: Colors.orange.withOpacity(0.2)),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.15)),
                                color: Colors.orange.withOpacity(0.2)),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tampilkan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.09),
                ),
                Text(
                  'Produkmu',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.08),
                ),
                Text(
                  'di Sini.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.07),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Iklan2Null extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Warna.warnak2,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                                MediaQuery.of(context).size.width * 0.15)),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    MediaQuery.of(context).size.width * 0.25)),
                            color: Colors.orange.withOpacity(0.2)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    MediaQuery.of(context).size.width * 0.15)),
                            color: Colors.orange.withOpacity(0.2)),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.width * 0.25)),
                            color: Colors.orange.withOpacity(0.2)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.width * 0.15)),
                            color: Colors.orange.withOpacity(0.2)),
                      )
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.15)),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                ],
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tampilkan Juga',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.09),
            ),
            Text(
              'Produkmu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.08),
            ),
            Text(
              'di Sini.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.07),
            ),
          ],
        )
      ],
    );
  }
}

class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 8 / 9),
      children: [
        Container(
          decoration: BoxDecoration(
              color: Warna.warnaload, borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Warna.warnaload, borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Warna.warnaload, borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Warna.warnaload, borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }
}

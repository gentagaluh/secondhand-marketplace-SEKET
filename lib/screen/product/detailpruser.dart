import 'package:app_seket/model/others.dart';
import 'package:app_seket/screen/iklan/iklan1.dart';
import 'package:app_seket/screen/iklan/iklan2.dart';
import 'package:app_seket/screen/product/editproduct.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/palette.dart';

class DetailPrUser extends StatefulWidget {
  final Map product;
  final String id;
  DetailPrUser({
    required this.product,
    required this.id,
  });

  @override
  State<DetailPrUser> createState() => _DetailPrUserState();
}

class _DetailPrUserState extends State<DetailPrUser> {
  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future delete(String id, String url) async {
    var response = await http.delete(
        Uri.parse(url+'api/product/delete/' + id));
    return json.decode(response.body);
  }

  

  Future sold(String id, String url) async {
    var response = await http.put(
        Uri.parse(url+'api/product/edit/' + id),
        body: {"sold": "yes"});
    return json.decode(response.body);
  }

  Future addFoto(String id, String url) async {
    var request = http.MultipartRequest('POST',
        Uri.parse(url+'api/product/addfoto/' + id));
    request.files
        .add(await http.MultipartFile.fromPath("foto_produk", image!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    return json.decode(responsed.body);
  }

  File? image;

  Future getCam() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      image = File(photo.path);
    }
    setState(() {});
  }

  Future getGal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.gallery);
    if (foto != null) {
      image = File(foto.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var urlProvider = Provider.of<UrlProvider>(context);
var currentUrl = urlProvider.url;
    String nomor = '+6282314355261';
    String pesan = 'Halo min!';
    final Uri url = Uri.parse('https://wa.me/$nomor?text=$pesan');
    Future whatsapp() async {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
              heroTag: 'delete',
              backgroundColor: Warna.warna1,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        content: Container(
                          decoration: BoxDecoration(
                              color: Warna.warna3,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: UnconstrainedBox(
                              child: Column(
                                children: [
                                  Text(
                                    'Hapus?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          sold(widget.product['id_produk']
                                              .toString(), currentUrl);

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Iya,',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      Text(' produk sudah terjual')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          delete(widget.product['id_produk']
                                              .toString(), currentUrl);

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Iya,',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      Text(' hanya ingin hapus')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Batal'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              label: Icon(Icons.delete)),
          FloatingActionButton.extended(
            heroTag: 'iklan',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Iklan1(
                                          id: widget.id,
                                          product: widget.product)));
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 40,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 40,
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Iklan 1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Iklan2(
                                          id: widget.id,
                                          product: widget.product)));
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  Text(
                                    'Iklan 2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            label: Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            backgroundColor: Colors.orange,
          ),
          FloatingActionButton.extended(
            heroTag: 'edit',
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProduct(product: widget.product)));
            },
            label: Icon(Icons.edit),
            backgroundColor: Warna.warna1,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            image == null
                ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                              color: Warna.warna3,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                  currentUrl+'image/product/' +
                                      widget.product['foto_produk'])),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListView(
                                        children: [
                                          Text(
                                            'Fitur ini sedang di perbaiki, jika ingin tetap menggunakan fitur ini silahkan hubungi admin untuk bantuan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                whatsapp();
                                              },
                                              child: Text('Hubungi Admin'))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Warna.warna1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              children: [
                                Text(
                                  'Ubah',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'Foto',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                              color: Warna.warna3,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(image!)),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          addFoto(widget.product['id_produk'].toString(), currentUrl);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Warna.warna1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: Text(
                              'Lanjutkan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
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

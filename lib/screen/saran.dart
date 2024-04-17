import 'package:app_seket/model/others.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../model/palette.dart';

// ignore: must_be_immutable
class Saran extends StatefulWidget {
  @override
  State<Saran> createState() => _SaranState();
}

class _SaranState extends State<Saran> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namaController = TextEditingController();

  TextEditingController _saranController = TextEditingController();

  Future add(String nama, String url) async {
    var response = await http.post(
        Uri.parse(url+'api/saran/add'),
        body: {"nama": nama, "saran": _saranController.text});
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Warna.warna4.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.width))),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 1.5,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                color: Warna.warna4,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            1.5))),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                color: Warna.warna3,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            3))),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'SEKET',
                      ),
                      Text(
                        'Secondhand Marketplace',
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              offset: Offset(2, 2)),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              offset: Offset(-2, 2))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Kritik & Saran',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Warna.warna1),
                              ),
                              Text(
                                'sampaikan secara terbuka',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Warna.warna2),
                              ),
                            ],
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: _namaController,
                            decoration: InputDecoration(
                                label: Text('Nama (Opsional)'),
                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.5))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          TextFormField(
                              controller: _saranController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  label: Text('Kritik & Saran'),
                                  labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'isi kritik & saran!';
                                }
                                return null;
                              }),
                          GestureDetector(
                            onTap: () {
                              add(_namaController.text == ''
                                      ? "null"
                                      : _namaController.text, currentUrl)
                                  .then((value) {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Toast(msg: 'Berhasil');
                                    });
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Warna.warna1),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: Text(
                                    'KIRIM',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

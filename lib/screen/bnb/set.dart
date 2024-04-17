import 'dart:io';

import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/screen/saran.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../model/others.dart';
import '../../model/palette.dart';

class Set extends StatefulWidget {
  final String id;
  Set({required this.id});

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  Future getInfo(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/user/info/id/' + widget.id));
    return json.decode(response.body);
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future addFoto(String id, String url) async {
    var request = http.MultipartRequest('POST',
        Uri.parse(url+'api/user/addfoto/' + id));
    request.files
        .add(await http.MultipartFile.fromPath("foto_profil", image!.path));
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

    Future web() async {
      await launchUrl(Uri.parse('https://genta.dcproject.my.id'),
          mode: LaunchMode.externalApplication);
    }

    Future logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('id');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Warna.warna1,
        child: ListView(
          children: [
            Container(
              color: Warna.warna3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'P e n g a t u r a n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Warna.warna1),
                    ),
                    CircleAvatar(
                      backgroundColor: Warna.warna3,
                      radius: 20,
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: getInfo(currentUrl),
                builder: (context, sp) {
                  if (sp.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Warna.warnaload,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  image == null
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: CircleAvatar(
                                            backgroundColor: Warna.warna1,
                                            backgroundImage: NetworkImage(
                                                currentUrl+'image/userPartner/' +
                                                    sp.data['data'][0]
                                                        ['foto_profil']),
                                          ),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: CircleAvatar(
                                            backgroundColor: Warna.warna1,
                                            backgroundImage: FileImage(image!),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Toast(
                                                          msg:
                                                              'Tunggu sebentar...');
                                                    });
                                                addFoto(widget.id, currentUrl).then(
                                                    (value) =>
                                                        Navigator.pop(context));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                    'Lanjutkan',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shadowColor: Colors.transparent,
                                              backgroundColor:
                                                  Colors.transparent,
                                              contentPadding: EdgeInsets.zero,
                                              content: Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.red),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ListView(
                                                    children: [
                                                      Text(
                                                        'Fitur ini sedang di perbaiki, jika ingin tetap menggunakan fitur ini silahkan hubungi admin untuk bantuan',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green),
                                                          onPressed: () {
                                                            whatsapp();
                                                          },
                                                          child: Text(
                                                              'Hubungi Admin'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius:
                                          MediaQuery.of(context).size.width /
                                              17,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Warna.warna1,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sp.data['data'][0]['nama'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(sp.data['data'][0]['kota']),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Warna.warnaload),
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      web();
                    },
                    child: Icon(Icons.open_in_browser),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Website SEKET',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      whatsapp();
                    },
                    child: Icon(Icons.call),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Hubungi admin',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Saran()));
                    },
                    child: Icon(Icons.message),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Kritik & Saran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
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
                                          'Keluar?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: logout,
                                              child: Text(
                                                'Iya',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Batal'))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Icon(Icons.logout),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      'Keluar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 6 * 3.709375,
                  height: MediaQuery.of(context).size.width / 6,
                  child: Image.asset('images/logo2.png'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:app_seket/model/others.dart';
import 'package:app_seket/screen/acc/login.dart';
import 'package:app_seket/screen/product/usrrated.dart';
import 'package:app_seket/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;

import '../../model/palette.dart';

class Notif extends StatefulWidget {
  final String id;
  Notif({required this.id});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Future getPic(String url) async {
    var response = await http.get(Uri.parse(
        url+'api/user/pic/id/' + widget.id));
    return json.decode(response.body);
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  Future getNotif(String url) async {
    var response = await http.get(
        Uri.parse(url+'api/notif/id/' + widget.id));
    return json.decode(response.body);
  }

  Future delete(String idNotif, String url) async {
    var response = await http.delete(
        Uri.parse(url+'api/notif/delete/' + idNotif));
    return json.decode(response.body);
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
            Container(
              color: Warna.warna3,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'N o t i f i k a s i',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Warna.warna1),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Warna.warna1,
                      child: FutureBuilder(
                          future: getPic(currentUrl),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
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
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: UnconstrainedBox(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Keluar?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('Batal'))
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
                                child: CircleAvatar(
                                  backgroundColor: Warna.warna1,
                                  radius: 17,
                                  backgroundImage: NetworkImage(
                                      currentUrl+'image/userPartner/' +
                                          snapshot.data['data'][0]
                                              ['foto_profil']),
                                ),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.grey,
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: getNotif(currentUrl),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot2.data['data'].length,
                        itemBuilder: (context, index) {
                          bool cekIndex = index % 2 == 0;
                          color() {
                            if (cekIndex) {
                              return Colors.grey.withOpacity(0.35);
                            } else {
                              return Warna.warna4;
                            }
                          }

                          String time =
                              snapshot2.data['data'][index]['created_at'];
                          DateTime datetime = DateTime.parse(time);
                          String timeAgo = timeago.format(datetime);

                          return Container(
                            color: color(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  snapshot2.data['data'][index]['foto'] ==
                                          'rate.png'
                                      ? CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.yellow,
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Warna.warna1,
                                          backgroundImage:
                                              AssetImage('images/logo.png'),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      snapshot2.data['data'][index]['foto'] ==
                                              'rate.png'
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UsrRated(id: widget.id)))
                                          : showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Toast(
                                                    msg: 'pesan dari sistem');
                                              });
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot2.data['data'][index]
                                              ['notif']),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            timeAgo,
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              content: Container(
                                                decoration: BoxDecoration(
                                                    color: Warna.warna3,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: UnconstrainedBox(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Hapus?',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);

                                                                delete(snapshot2
                                                                    .data[
                                                                        'data']
                                                                        [index]
                                                                        ['id']
                                                                    .toString(), currentUrl);

                                                                setState(() {});
                                                              },
                                                              child: Text(
                                                                'Iya',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Batal'))
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
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Icon(Icons.delete),
                                    )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Warna.warnaload),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Warna.warnaload),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Warna.warnaload),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Warna.warnaload),
                          ),
                        ],
                      ),
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

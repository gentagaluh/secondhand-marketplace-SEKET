import 'package:app_seket/model/palette.dart';
import 'package:flutter/material.dart';

class NamaJudul extends StatelessWidget {
  final String text1;
  final String text2;
  NamaJudul({
    required this.text1,
    required this.text2,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Warna.warna1,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                text1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Warna.warna1),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Warna.warna2.withOpacity(0.1),
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                text2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Warna.warna2.withOpacity(0.1)),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                text1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Warna.warna4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Color backcolor;
  final ImageProvider backimage;
  Background({
    required this.backcolor,
    required this.backimage,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 1.9,
              color: backcolor,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.1,
              color: Colors.white.withOpacity(0.1),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.3,
              color: Colors.white.withOpacity(0.1),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.5,
              color: Colors.white.withOpacity(0.1),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.7,
              color: Colors.white.withOpacity(0.1),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 2.9,
              color: Colors.white.withOpacity(0.1),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 1.6,
            ),
            CircleAvatar(
                radius: MediaQuery.of(context).size.width / 5,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Warna.warna1,
                  radius: MediaQuery.of(context).size.width / 5.5,
                  backgroundImage: backimage,
                ))
          ],
        )
      ],
    );
  }
}

class ShowDialogBack extends StatelessWidget {
  final String backtext;
  final Color backcolor;
  final String totalSkin;
  final String nama;
  ShowDialogBack({
    required this.backtext,
    required this.backcolor,
    required this.totalSkin,
    required this.nama,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Warna.warna3,
          ),
          height: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Column(
                  children: [
                    Text(
                      nama + ' adalah user',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      backtext + ' (' + totalSkin + ')',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: backcolor),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Peringkat ini didapatkan dari banyaknya skin yang pernah kamu peroleh. Dan ini adalah rincian peringkat yang ada :'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage('images/brown.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Brown, ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Warna.warnabrown)),
                      SizedBox(
                        width: 5,
                      ),
                      Text('0 Skin')
                    ],
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('images/silver.png'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Silver, ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Warna.warnasilver)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('200 Skin')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage('images/gold.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Gold, ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Warna.warnagold)),
                      SizedBox(
                        width: 5,
                      ),
                      Text('400 Skin')
                    ],
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage('images/diamond.png'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Diamond, ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Warna.warnadiamond)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('600 Skin')
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class ShowDialogRate extends StatelessWidget {
  final String nama;
  ShowDialogRate({required this.nama});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Warna.warna3),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                  'Rate ini didapatkan dari beberapa pengguna yang telah membeli barang ' +
                      nama),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('0/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Belum ada rating',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('5/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Sangat Bagus',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('4/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Bagus', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('3/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Sedang',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('2/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Buruk', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 15,
                  ),
                  Text('1/5 ',
                      style: TextStyle(
                          color: Warna.warna1, fontWeight: FontWeight.bold)),
                  Text(': Sangat Buruk',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Tutor extends StatelessWidget {
  final String foto;
  Tutor({required this.foto});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
            color: Warna.warna3, borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                'Cara mengiklankan produkmu :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text('1. Pergi ke halaman bisnis'),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Image.asset('images/1.jpg')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('2. Klik produk yang ingin kamu iklankan'),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Image.asset('images/2.jpg')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('3. Klik tombol bintang dan pilih iklan 1 atau iklan 2'),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Image.asset('images/3.jpg')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('4. Klik iklankan'),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      child: Image.asset(foto)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Toast extends StatelessWidget {
  final String msg;
  Toast({required this.msg});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              msg,
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

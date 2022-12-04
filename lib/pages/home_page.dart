import 'package:blog_app/pages/details_page.dart';
import 'package:blog_app/pages/gallery_page.dart';
import 'package:blog_app/pages/popular_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myPage = [DetailsPage(), GalleryPage(), PopularPage()];
  int _indexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFADBD8),
      body: myPage[_indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffFADBD8),
        color: Color(0xff2C3E50),
        items: <Widget>[
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.photo,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (value) {
          setState(() {
            _indexPage = value;
          });
        },
      ),
    );
  }
}

myStyle(double fs, Color clr, [FontWeight? fw]) {
  return TextStyle(fontSize: fs, color: clr, fontWeight: fw);
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFADBD8),
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text("Popular Travel Blog"),
        centerTitle: true,
      ),
    );
  }
}

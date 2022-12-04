import 'package:blog_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("blog_details").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFADBD8),
        appBar: AppBar(
          backgroundColor: Color(0xff2C3E50),
          title: Text("Gallery"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something is Error!");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: snapshot.data!.docs
                    .map((DocumentSnapshot documentSnapshot) {
                  Map<String, dynamic> data =
                      documentSnapshot.data() as Map<String, dynamic>;
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        height: 180.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        data["image"],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(3.r)),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }));
  }
}

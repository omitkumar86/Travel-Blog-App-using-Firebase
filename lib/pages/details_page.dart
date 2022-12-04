import 'package:blog_app/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("blog_details").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFADBD8),
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text("Details Travel Blog"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something is Error!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children:
                snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
              Map<String, dynamic> data =
                  documentSnapshot.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
                child: Card(
                  elevation: 8,
                  child: Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(3.r)),
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 10.h),
                            child: Column(
                              children: [
                                Text(
                                  data["title"],
                                  style: myStyle(
                                      20.sp, Colors.black, FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  data["description"],
                                  style: myStyle(
                                      14.sp, Colors.black, FontWeight.w400),
                                  maxLines: 5,
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    customDialogBox(
                                        data["image"],
                                        data["title"],
                                        data["description"],
                                        context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 35.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius:
                                            BorderRadius.circular(40.r)),
                                    child: Text(
                                      "View Details",
                                      style: myStyle(
                                          18.sp, Colors.white, FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
        },
      ),
    );
  }

  customDialogBox(
      String image, String title, String description, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 360.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 180.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                image,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.r)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        title,
                        style: myStyle(20.sp, Colors.black, FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        description,
                        style: myStyle(14.sp, Colors.black, FontWeight.w400),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

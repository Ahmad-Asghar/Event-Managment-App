import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Views/nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Localization/code/local_keys.g.dart';
import '../Widgets/Event_data_textfield.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

  TextEditingController searched=TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[500],
        title: Text(LocaleKeys.feeds).tr(),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(

          children: [
            Event_Textfield(
                text: searched,
                icon: Icons.search,
                hintext: "Search User",
                onpressed: () {

                }),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){

                if(snapshot.hasError){
                  return Center(child: Text("Something wrong!"),);
                }
               if(snapshot.connectionState==ConnectionState.waiting){
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,

                      itemBuilder: (BuildContext context,int index){

                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 2.4.w,vertical: 0.7.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(

                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data!.docs[index]['profilepic'].toString()),
                              ),
                              title: Text(snapshot.data!.docs[index]['fullName'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
subtitle: Text(snapshot.data!.docs[index]['email'].toString(),),
                              trailing: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            ),
          ],
        ),
      ),

    );
  }
}
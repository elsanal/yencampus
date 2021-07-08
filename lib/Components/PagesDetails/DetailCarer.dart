import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yencampus/Components/Details.dart';
import 'package:yencampus/Components/DetailsComp.dart';
import 'package:yencampus/Decoration/Fonts.dart';
import 'package:yencampus/Function/HtmlParser.dart';
import 'package:yencampus/Function/sharePost.dart';
import 'package:yencampus/Models/CarerClass.dart';
import 'package:yencampus/Models/JobClass.dart';
import 'package:yencampus/Models/ScholarshipClass.dart';
import 'package:yencampus/Models/SharePostClass.dart';

import '../ShareArticle.dart';

Widget detailCarer(BuildContext context, CarerClass doc){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return SliverToBoxAdapter(
    child: Container(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [

            new Container(child: Image.network(
              doc.images[0]['src']['src'], fit: BoxFit.fill,),),
            new SizedBox(height: 10,),

            body(doc.description_fr),
            new SizedBox(height: 20,),
            title2("Advantages"),
            body(doc.advantage_fr),
            new SizedBox(height: 20,),

            new Container(child: Image.network(
              doc.images[1]['src']['src'], fit: BoxFit.fill,),),
            new SizedBox(height: 10,),

            title2("Desadvantages"),
            body(doc.desadvantage_fr),
            new SizedBox(height: 20,),

            new Container(child: Image.network(
              doc.images[2]['src']['src'], fit: BoxFit.fill,),),
            new SizedBox(height: 10,),

            new Container(
              width: width,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  actionButton("Apply",Icons.web_rounded,Colors.green,doc),
                  actionButton("Save",Icons.save_rounded,Colors.blue,doc),
                  actionButton("Share",Icons.share_rounded,Colors.red,doc)
                ],
              ),
            ),
            // new SizedBox(height: 10,),
          ],
        )
    ),
  );
}
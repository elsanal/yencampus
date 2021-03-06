import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yencampus/Components/PagesDetails/Details.dart';
import 'package:yencampus/Components/Loading.dart';
import 'package:yencampus/Database/sqflite.dart';
import 'package:yencampus/Decoration/Fonts.dart';
import 'package:yencampus/Function/HtmlParser.dart';
import 'package:yencampus/Function/Locale.dart';
import 'package:yencampus/Function/getCareerData.dart';
import 'package:yencampus/Function/getJobData.dart';
import 'package:yencampus/Function/getScholarshipData.dart';
import 'package:yencampus/Function/getUniversityData.dart';
import 'package:yencampus/Function/sharePost.dart';
import 'package:yencampus/Function/translation.dart';
import 'package:yencampus/Models/CarerClass.dart';
import 'package:yencampus/Models/JobClass.dart';
import 'package:yencampus/Models/SavedClass.dart';
import 'package:yencampus/Models/ScholarshipClass.dart';
import 'package:yencampus/Models/UniversityClass.dart';
import 'package:yencampus/Pages/Scholarship.dart';

/// Widget to show the posts of each category
Widget pageBody(BuildContext context, String type){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  var lang = getLocale(context);
  return SliverToBoxAdapter(
    child: new Container(
      padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(50),
          top: ScreenUtil().setHeight(50)
      ),
      child: _category(lang,type, width, height,false,'null')
    ),
  );
}


/// widget to show the filter posts
 Widget filterBody(BuildContext context,String type,String target, final value, bool isArrayTarget){
   var height = MediaQuery.of(context).size.height;
   var width = MediaQuery.of(context).size.width;
   var lang = getLocale(context);
   return SliverToBoxAdapter(
     child: new Container(
         // height:height*(length.value*0.4),
         // width: width,
         padding: EdgeInsets.only(
             bottom: ScreenUtil().setHeight(50),
             top: ScreenUtil().setHeight(50)
         ),
         child: _filterCategory(lang,type, width, height,target,value,isArrayTarget)
     ),
   );
}

/// Identify the type of post and retrieve it data from firebase
_category(String lang,String type,double width, double height,bool isLocal,String id){
  switch(type){
    case "scholar":
      return FutureBuilder<List<ScholarshipGnClass>>(
          future: getScholarship(lang),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type,isLocal);
            }
          }
      );
    case "univ":
      return FutureBuilder<List<UniversityClass>>(
          future: getUniversity(lang),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type,isLocal);
            }
          }
      );
    case "job":
      return FutureBuilder<List<JobClass>>(
          future: getJob(lang),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error")),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type, isLocal);
            }
          }
      );
    case "carer":
      return FutureBuilder<List<CarerClass>>(
          future: getCarer(lang),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type, isLocal);
            }
          }
      );
  }
}

_filterCategory(String lang, String type,double width, double height,String target, final value, bool isArrayTarget){
  switch(type){
    case "scholar":
      return FutureBuilder<List<ScholarshipGnClass>>(
          future: isArrayTarget?getArrayTargetScholarship(lang, target, value)
              :getTargetScholarship(lang,target,value),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              // return Container(child: Text("scholar"),);
              return _listBuilder(snapshot, width, height, type, false);
            }
          }
      );
    case "univ":
      return FutureBuilder<List<UniversityClass>>(
          future: getTargetUniversity(lang,target,value),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type, false);
            }
          }
      );
    case "job":
      return FutureBuilder<List<JobClass>>(
          future: isArrayTarget?getArrayTargetJob(lang, target, value)
              :getTargetJob(lang,target,value),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type, false);
            }
          }
      );
    case "carer":
      return FutureBuilder<List<CarerClass>>(
          future: getTargetCarer(lang,target,value),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                alignment: Alignment.topCenter,
                child: Loading());
            }
            else if(snapshot.hasError){
              return Container(
                alignment: Alignment.topCenter,
                child: Center(child: Text(translate(context, "error"),style: titleStyle2,),),);
            }
            else{
              return _listBuilder(snapshot, width, height, type, false);
            }
          }
      );
  }
}

Widget _listBuilder(AsyncSnapshot snapshot, double width, double height, String type,bool isLocal){
  return Container(
    width: width,
    height: snapshot.data!.length<=1?height*(0.5)*(snapshot.data!.length):
            height*(0.24)*(snapshot.data!.length),
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: snapshot.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1
      ),
      itemBuilder: (context,index){
        final item = snapshot.data![index];
        return Card(
          child: Container(
            child: GestureDetector(
              onTap: ()=>Navigator.push(context,
                  new MaterialPageRoute(builder: (context)=>Details(doc: item,type: type,isLocal:isLocal))),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                      height: ScreenUtil().setHeight(310),
                      width: width,
                      alignment: Alignment.bottomCenter,
                      decoration:BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("${item.images[0]['src']['src']}"),
                              fit: BoxFit.contain
                          )
                      ),
                      child: type!="carer"?Text(translate(context, "country")+": ${item.country}\n"
                          ' ${item.deadline} \n',
                        textAlign: TextAlign.center,
                        style: titleStyle.copyWith(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          fontSize: ScreenUtil().setSp(40)
                        ),):Container(),),
                  Text(item.name,
                    textAlign: TextAlign.left,
                    style: titleStyle2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(35)
                    )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(parseHtmlString(item.description),style: textStyle,
                        maxLines: 4,overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                    new Container(
                      width: width,
                      height: 40,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Colors.grey.shade500,width: 1,style: BorderStyle.solid),
                          bottom: BorderSide(
                              color: Colors.white,width: 1,style: BorderStyle.solid),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap:()=>Navigator.push(context,
                                  new MaterialPageRoute(builder: (context)=>Details(doc: item,type: type,isLocal:isLocal))),
                              child: _actionButton(translate(context, "read_more"))),
                          new Container(height: 40,width: 1,color: Colors.grey[400],),
                          InkWell(
                            onTap: (){
                              localDB(tableName: "YENCAMPUS").saveOndB(SavePost(type:type, id:(item.id).toString()));
                              final snackBar = SnackBar(
                                content: Text(translate(context, "saved")),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                              child: isLocal?_actionButton(translate(context, "delete")):_actionButton(translate(context, "save"))),
                          new Container(height: 40,width: 1,color: Colors.grey,),
                          InkWell(
                            onTap: (){
                              sharePost(context,item, type);
                            },
                              child: _actionButton(translate(context, "share"))),
                        ],
                      ),
                    ),
                    // new Container(height: 5,color: Colors.grey[500],)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}


Widget _actionButton(String action,){
  return Text(action,style: titleStyle.copyWith(
    fontSize: ScreenUtil().setSp(30),
    color: Colors.grey[800],
  ),);
}

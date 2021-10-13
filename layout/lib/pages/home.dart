import 'dart:convert';
//import 'package:async/async.dart' as http ;
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับคอมพิวเตอร์"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          builder: (context,AsyncSnapshot snapshot){
            //var data = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context,int index){
                return  Mybox(snapshot.data[index]['title'],snapshot.data[index]['subtitle'] ,snapshot.data[index]['picture'],snapshot.data[index]['detail']);       
                    
                    
                                
                
              },
              itemCount: snapshot.data.length,);

          },   
          //future:DefaultAssetBundle.of(context).loadString('assets/data.json'),
          //),
          future: getData(),
        )
      ));
  }

      
    
    

Widget Mybox(String title,String subtitle,String picture,String detail){
    var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = picture;
    v4 = detail;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          //color: Colors.blue[50],
          height: 150,
          decoration: BoxDecoration(
            //color: Color.blue[50],
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: 
            NetworkImage(picture),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken)
            )
          ),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style:TextStyle(fontSize: 25,color:Colors.blue,fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Text(subtitle,
              style:TextStyle(fontSize: 15,color: Colors.yellow,)),
              TextButton (onPressed: (){
                print("Next page>>>");
                Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(v1,v2,v3,v4)));

              }, child:Text("อ่านต่อ"))
            ],
          ),
        ),
      ],
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/thararatlee1234/BasicAPI/main/data.json
    var url = Uri.https('raw.githubusercontent.com','/thararatlee1234/BasicAPI/main/data.json' );
    var response = await http.get(url);
    var result = json.decode (response.body);
    return result;
  }

}

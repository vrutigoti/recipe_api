import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_api/recipe.dart';

class second extends StatefulWidget {
  //const second({super.key});
  dynamic photourl,title,cookTime,tags,calories;
  second([this.photourl,this.title,this.cookTime,this.tags,this.calories]);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {


  @override
  Widget build(BuildContext context) {
    recipe r=ModalRoute.of(context)!.settings.arguments as recipe ;
    Future getdata()
    async {
      // print("object");
      var url = Uri.https('api.sampleapis.com', 'recipes/recipes/${r.id}');
      var response = await http.get(url);
      List m=jsonDecode(response.body);
      log("${m}");
      return m;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${r.title}"),
        backgroundColor: Colors.orange,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("${r.photoUrl}"),
                    fit: BoxFit.fill,),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black,width: 2)),

                  //Text("${r.cookTime} hrs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                ),
              ),


            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("${r.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.orange),
                  child: ElevatedButton(onPressed: () {

                  }, child: Icon(Icons.favorite_outline,color: Colors.red,)),
                  // height: 30,
                  // width: 30,
                  // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("myasset/bookmark.jpg"))),
                ),

              ],
            ),
            Container(
              child:  Text("${r.cookTime} hrs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            SizedBox(height: 2,),


            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.redAccent),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.favorite,color: Colors.white,)),
                ),
                Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.amber),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.soup_kitchen_outlined,color: Colors.white,)),
                ),
                Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.lightGreen),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.share,color: Colors.white,)),
                ),
                Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.indigoAccent),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.add_chart,color: Colors.white,)),
                ),
                Container(

                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.purple),
                  child: IconButton(onPressed: () {

                  }, icon: Icon(Icons.print,color: Colors.white,)),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Container(
                 child: Text("${r.calories}\n calories",style: TextStyle(fontWeight: FontWeight.bold),),
               ),
                Container(
                  child:    Text("${r.servings}\nservings",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  child:  Text(" Share\nRecipe",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  child: Text("Unic\nChart",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  child:Text("Print\nRecipe",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              height: 45,
              width: double.infinity,
              color: Colors.orange,
              child: Row(
                children: [
                  Icon(Icons.drag_handle_outlined,color: Colors.white,),
                  Text("Ingredients Required",style: TextStyle(color: Colors.white),),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
                  //   height: 45,
                  //   width: 70,
                  //   color: Colors.grey,
                  // )
                ],
              ),
            ),
            Container(
              child: Text("${r.ingredients}"),
            )

          ],
        ),
      ),




    );
  }
}

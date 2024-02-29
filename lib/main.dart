
import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_api/recipe.dart';
import 'package:recipe_api/second.dart';

void main()
{
  runApp(MaterialApp(
    routes: {
      "recipe":(context) => second(),
      "first":(context) => first(),

    },
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}
class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  // final dio = Dio();

  /*Future getHttp() async {
    final response = await dio.get('https://dart.dev');
    print(response);
  }*/
  Future getdata()
  async {
    // print("object");
    var url = Uri.https('api.sampleapis.com', 'recipes/recipes');
    var response = await http.get(url);
    List m=jsonDecode(response.body);
    log("${m}");
    return m;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Recipes Cookbook"),
            backgroundColor: Colors.orange,
        ),
        body:
        FutureBuilder(future: getdata(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done)
            {
              if(snapshot.hasData)
              {
                List m=snapshot.data as List;

                log("${m}");
                return ListView.builder(
                  itemCount: m.length,
                  itemBuilder: (context, index) {
                    print("${jsonEncode(m[index])})");
                    recipe r=  recipe.fromJson(m[index]);
                    print(r);
                    // return InkWell(onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //     return second(r.photoUrl,r.title,r.cookTime,r.tags,r.calories);
                    //   },));
                    // },
                    return InkWell(onTap: () {
                      Navigator.pushNamed(context, "recipe",arguments: r);
                    },
                      child: Container(
                        height: 300,
                        width: 400,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.80,fit: BoxFit.fill,
                              image: NetworkImage("${r.photoUrl}"),)),
                        child: Wrap(
                          children: [
                            Center(child: Text("${r.title}",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),

                          ],
                        ),
                      ),
                    );

                  },);
              }
            }
            return Center(child: CircularProgressIndicator());
          },),

        );
    }
}

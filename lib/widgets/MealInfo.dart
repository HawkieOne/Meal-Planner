import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


class MealInfo extends StatefulWidget {
  final String title;
  final IconData icon;

  MealInfo({Key? key, this.title: "Undefined", this.icon: Icons.help_outline}) : super(key: key);

  @override
  _MealInfoState createState() => _MealInfoState();
}

Widget ingredientField() {
  return Row(
    children: [
      Expanded(flex: 7, child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter ingredient',
          contentPadding: EdgeInsets.all(5.0),
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      )),
      Padding(padding: const EdgeInsets.all(20)),
      Expanded(flex: 3, child: TextField(
        decoration: InputDecoration(
          hintText: '1',
          contentPadding: EdgeInsets.all(5.0),
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      )),
    ],
  );
}

class _MealInfoState extends State<MealInfo> {
  List<Widget> _ingredients = <Widget>[ingredientField()];
  String _test = "Testing";
  String urlImg = "";

  void setUrlImg(String url) {
    setState(() {
      print(url);
      urlImg = url;
    });
  }

  Future<void> getImageURL() async {
    http.Response response = await http.get(Uri.parse('https://www.ica.se/recept/busenkel-broccolisoppa-712859/'));
    if(response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      var imgList = document.getElementsByClassName('recipe-header__image');
      setUrlImg(imgList[0].attributes['src'].toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getImageURL();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments["title"];
    IconData icon = arguments["icon"];

    void addIngredientWidget() {
      setState(() {
        _ingredients.add(ingredientField());
      });
    }



    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Meal",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter meal here",
                            contentPadding: EdgeInsets.all(5.0),
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: FutureBuilder(
                    future: http.get(Uri.parse('https://www.ica.se/recept/busenkel-broccolisoppa-712859/')),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          dom.Document document = parser.parse(snapshot.data.body);
                          var imgList = document.getElementsByClassName('recipe-header__image');
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.network(imgList[0].attributes['src'].toString(),
                                fit: BoxFit.cover
                            ),
                          );
                        }
                        else{
                          return Container(
                              width: 50,
                              height: 50,
                              color: Colors.red
                          );
                        }
                      } else{
                        return Container(
                          width: 50,
                          height: 50,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              )
                          ),
                        );
                      }
                    },

                  ),

                  // Image.network(urlImg,
                  //         fit: BoxFit.cover
                  // ),

                ),
                // Icon(
                //   icon,
                //   size: 100,
                // )
              ],
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Container (
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  children: [
                    Expanded(flex: 7,child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Ingredients"))
                    ),
                    Expanded(flex: 3,child: Center(child: Text("Amount"))),
                  ],
                ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: _ingredients.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index){
                  return _ingredients[index];
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // shape: BeveledRectangleBorder(),
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width / 3)
              ),
              child: const Icon(Icons.add),
              onPressed: () { addIngredientWidget(); },
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Notes"),
            ),
            Padding(padding: const EdgeInsets.all(5)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  hintText: "Enter your notes here",

                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(5)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width / 2),
              ),
              child: const Text("Save"),
              onPressed: () {
                Navigator.pop(context);
                },
            ),
          ],
        ),
      )
    );
  }
}
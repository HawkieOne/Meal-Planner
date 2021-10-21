import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_planner/widgets/Widgets.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


class MealInfo extends StatefulWidget {
  final String title;

  MealInfo({Key? key, this.title: "Undefined"}) : super(key: key);

  @override
  _MealInfoState createState() => _MealInfoState();
}

Widget ingredientField(String ingr, String qty) {
  return Row(
    children: [
      Expanded(flex: 3, child: Text(qty)),
      Padding(padding: const EdgeInsets.all(20)),
      Expanded(flex: 7, child: Text(ingr)),
    ],
  );
}

class _MealInfoState extends State<MealInfo> {
  List<Widget> _ingredients = <Widget>[];
  TextEditingController _controller = TextEditingController();

  String url = "";
  bool hasUrl = false;
  var qtis = [];
  var ingredients = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments["title"];
    IconData icon = Icons.help_outline;

    void addIngredientWidget(String ingr, String qty) {
      _ingredients.add(ingredientField(ingr, qty));
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: hasUrl == true ? FutureBuilder(
          future: http.get(Uri.parse(url)),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              dom.Document document = parser.parse(snapshot.data.body);
              var img = document.getElementsByClassName('recipe-header__image')[0];

              var ingrList = document.getElementById('ingredients')?.getElementsByClassName('ingredients-list-group')[0].
              getElementsByClassName('ingredients-list-group__card');

              for (var i = 0; i < ingrList!.length ; i++) {
                var qty = ingrList[i].getElementsByTagName('span')[0].innerHtml.replaceAll(RegExp('\\s'), "").replaceAll(RegExp("(?<=\\d)(?=\\D)")," ").replaceAll(RegExp("(?<=\\D)(?=\\d)")," ");
                var ingredient = toBeginningOfSentenceCase(ingrList[i].getElementsByTagName('span')[1].innerHtml.replaceAll(RegExp(r'\n'), "").replaceAll(RegExp(r'  '), ''));
                qtis.add(qty);
                ingredients.add(ingredient);
                addIngredientWidget(ingredient.toString(), qty);
              }
              print(qtis);
              print(ingredients);

              return SingleChildScrollView(
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCaptionLeft(context, "Meal", Theme.of(context).textTheme.headline3),
                            Padding(padding: EdgeInsets.all(5)),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextInput(context, "Enter meal here"),
                            ),
                          ],
                        ),
                        Container(
                            width: 100,
                            height: 100,
                            child: Image.network(img.attributes['src'].toString(),
                                fit: BoxFit.cover
                            )
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Container (
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          Expanded(flex: 2,child: TextCaptionLeft(context, "Amount", DefaultTextStyle.of(context).style)),
                          Expanded(flex: 8,child: TextCaptionCenter(context, "Ingredients", DefaultTextStyle.of(context).style)
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
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
                    Padding(padding: const EdgeInsets.all(10)),
                    TextCaptionLeft(context, "Notes", DefaultTextStyle.of(context).style),
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
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                )
              );
            }
          },
        ) : Center(
            child: Column(
              children: [
                TextCaptionCenter(context, "Enter meal", Theme.of(context).textTheme.headline3),
                TextFormField(controller: _controller),
                Padding(padding: EdgeInsets.all(5)),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      url = _controller.text;
                      hasUrl = true;
                    });
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
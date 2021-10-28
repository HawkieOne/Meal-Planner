import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_planner/widgets/Widgets.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import 'package:meal_planner/models/Database.dart';


class MealInfo extends StatefulWidget {
  final String title;

  MealInfo({Key? key, this.title: "Undefined"}) : super(key: key);

  @override
  _MealInfoState createState() => _MealInfoState();
}

Widget ingredientField(String ingredient, String qty) {
  return Row(
    children: [
      Expanded(flex: 2, child: Text(qty)),
      Padding(padding: const EdgeInsets.all(10)),
      Expanded(flex: 8, child: Text(ingredient)),
    ],
  );
}

Widget cookingStepField(BuildContext context, String step, int index) {
  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Text((index + 1).toString() + '. ')),
          // Expanded(flex: 1, child: Text((index + 1).toString() + ". ")),
          Flexible(flex: 9,child: Text(step)),
        ],
      ),
  );
}

class _MealInfoState extends State<MealInfo> {
  List<Widget> _ingredientsView = <Widget>[];
  TextEditingController _controller = TextEditingController();

  String url = "";
  String urlMatchIca = "https://www.ica.se";
  String urlMatchCoop = "https://www.coop.se";
  bool hasUrl = false;
  var quantites = [];
  var ingredients = [];
  var cookingSteps = [];
  Database dbConnection = Database();

  Future<bool> _onWIllPop() async {
    if(dbConnection.db.isConnected) {
      dbConnection.close();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    dbConnection.connect();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments["title"];
    IconData icon = Icons.help_outline;

    void addIngredientWidget(String ingr, String qty) {
      _ingredientsView.add(ingredientField(ingr, qty));
    }

    return WillPopScope(
        onWillPop: _onWIllPop,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: BackButton(
              onPressed: () {
                if(dbConnection.db.isConnected) {
                  dbConnection.close();
                }
                Navigator.pop(context);
              },
            ),
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
                  dom.Document doc = parser.parse(snapshot.data.body);
                  var recipeImage = doc.getElementsByClassName('recipe-header__image')[0];
                  var ingredientsList = doc.getElementById('ingredients')?.getElementsByClassName('ingredients-list-group')[0].getElementsByClassName('ingredients-list-group__card');
                  var cookingStepsList = doc.getElementsByClassName('cooking-steps-main__text');
                  var recipeTitle = doc.getElementsByClassName('recipe-header__title')[0];

                  // Must have ingrList.length - 1.
                  // if there exist any ingredient without any given amount the program crashes
                  // the ingredient without any given amount is always at the end of the list

                  for (var i = 0; i < ingredientsList!.length - 1; i++) {
                    var qty = ingredientsList[i].getElementsByTagName('span')[0].innerHtml.replaceAll(RegExp('\\s'), "").replaceAll(RegExp("(?<=\\d)(?=\\D)")," ").replaceAll(RegExp("(?<=\\D)(?=\\d)")," ");
                    var ingredient = toBeginningOfSentenceCase(ingredientsList[i].getElementsByTagName('span')[1].innerHtml.replaceAll(RegExp(r'\n'), "").replaceAll(RegExp(r'  '), ''));
                    quantites.add(qty);
                    ingredients.add(ingredient);
                    addIngredientWidget(ingredient.toString(), qty);
                  }
                  for(var i = 0; i < cookingStepsList.length; i++) {
                    var step = cookingStepsList[i].innerHtml;
                    cookingSteps.add(step.toString());
                  }
                  // print(recipeTitle.text);
                  // print(quantites);
                  // print(ingredients);
                  // print(cookingSteps);

                  dbConnection.printMeals();

                  return SingleChildScrollView(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                                flex: 1,
                                child: TextCaptionLeft(context, recipeTitle.text, Theme.of(context).textTheme.headline3)
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Image.network(recipeImage.attributes['src'].toString(),
                                    fit: BoxFit.cover
                                )
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.all(10)),
                        TextCaptionLeft(context, "Ingredients", Theme.of(context).textTheme.headline4),
                        Padding(padding: const EdgeInsets.all(3)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListView.builder(
                            itemCount: _ingredientsView.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return _ingredientsView[index];
                            },
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(10)),
                        TextCaptionLeft(context, "Cooking steps", Theme.of(context).textTheme.headline4),
                        Padding(padding: const EdgeInsets.all(3)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListView.builder(
                              itemCount: cookingSteps.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return cookingStepField(context, cookingSteps[index], index);
                              }
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
                            if(dbConnection.db.isConnected) {
                              print(dbConnection.db.isConnected);
                              dbConnection.close();
                            }
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
                  Text("(must be a url)", style: TextStyle(fontSize: 12)),
                  TextFormField(controller: _controller),
                  Padding(padding: EdgeInsets.all(5)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        url = _controller.text;
                        if(url.contains(urlMatchIca)) {
                          hasUrl = true;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Theme.of(context).errorColor,
                                content: Text("Invalid url", style: TextStyle(color: Colors.white)),
                              ));
                        }
                      });
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
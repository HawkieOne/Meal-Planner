import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealInfo extends StatefulWidget {
  final String title;

  MealInfo({Key? key, this.title: "Undefined"}) : super(key: key);

  @override
  _MealInfoState createState() => _MealInfoState();
}

Widget ingredientField() {
  return Row(
    children: [
      Expanded(flex: 7, child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter ingredient',
        ),
      )),
      Padding(padding: const EdgeInsets.all(20)),
      Expanded(flex: 3, child: TextField(
        decoration: InputDecoration(
            hintText: '1'),
      )),
    ],
  );
}

class _MealInfoState extends State<MealInfo> {
  List<Widget> _ingredients = <Widget>[ingredientField()];
  String _test = "Testing";

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments["title"];

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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Meal",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter meal here"
                          )
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.dinner_dining,
                  size: 100,
                )
              ],
            ),
            Container (
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Expanded(flex: 7,child: Text("Ingredients")),
                    Expanded(flex: 3,child: Text("Amount")),
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
                shape: BeveledRectangleBorder(),
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width * 0.9)
              ),
              child: const Icon(Icons.add),
              onPressed: () { addIngredientWidget(); },
            ),
            Padding(padding: const EdgeInsets.all(10)),
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
                shape: BeveledRectangleBorder(),
                primary: Colors.green,
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width / 2),
              ),
              child: const Text("Save"),
              onPressed: () { Navigator.pop(context); },
            ),
          ],
        ),
      )
    );
  }
}
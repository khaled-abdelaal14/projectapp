import 'package:flutter/material.dart';
import 'package:iti/models/recipe.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.name,style:TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrangeAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Image.network(recipe.images),
                SizedBox(height: 16),
                Text(
                  recipe.name,
                  style: TextStyle(fontSize: 23, color: Colors.deepOrangeAccent),
                ),
                SizedBox(height: 8),
                Text(
                  'Rating: ${recipe.rating}',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Time: ${recipe.totalTime}',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(height: 16),
                Text(
                  'Ingredients:',
                  style: TextStyle(fontSize: 23, color: Colors.deepOrangeAccent),
                ),
                SizedBox(height: 8),
                Text(
                  '''
- 4 boneless + skinless chicken breasts
- 1/2 cup milk
- 3/4 cup Greek yogurt (or mayo or sour cream)
- 3/4 cup grated parmesan cheese (divided)
- 1 tsp salt
- 3/4 tsp each: garlic powder, onion powder + paprika
- black pepper to taste
- Optional Garnish: parsley + chilipepperflakes

                  ''',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
           ),
       );
    }
}

import 'dart:convert';
import 'package:iti/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      'x-rapidapi-key': 'b62cda1f3bmsh4a6861cc4d8ab06p18f056jsn765ec6ad6539',
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
      'useQueryString':"true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
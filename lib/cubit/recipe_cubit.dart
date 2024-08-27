import 'package:bloc/bloc.dart';
import 'package:iti/models/recipe.dart';
import 'package:iti/models/recipe_api.dart';
import 'package:iti/cubit/recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());

  Future<void> fetchRecipes() async {
    emit(RecipeLoading());
    try {
      final recipes = await RecipeApi.getRecipe();
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError("Failed to fetch recipes"));
    }
  }

  void searchRecipes(String query) {
    if (state is RecipeLoaded) {
      final recipes = (state as RecipeLoaded).recipes;
      final filteredRecipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(RecipeLoaded(filteredRecipes));
    }
    }
}

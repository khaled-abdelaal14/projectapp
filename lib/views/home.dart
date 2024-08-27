import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti/cubit/recipe_cubit.dart';
import 'package:iti/cubit/recipe_state.dart';
import 'package:iti/views/widgets/recipe_card.dart';
import 'package:iti/views/recipe_detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                text: 'Food Recipe',
                icon: Icon(Icons.restaurant_menu, color: Colors.white),
              ),
              Tab(
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              color: Colors.white,
              height: 2.0,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            RecipeList(),
            BlocProvider(
              create: (context) => RecipeCubit()..fetchRecipes(),
              child: SearchTab(),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit()..fetchRecipes(),
      child: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecipeLoaded) {
            final recipes = state.recipes;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard(
                  title: recipe.name,
                  cookTime: recipe.totalTime,
                  rating: recipe.rating.toString(),
                  thumbnailUrl: recipe.images,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsPage(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is RecipeError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchRecipes(String query) {
    BlocProvider.of<RecipeCubit>(context).searchRecipes(query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecipeLoaded) {
            final recipes = state.recipes;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Search for recipes...',
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                      ),
                      onChanged: (query) {
                        _searchRecipes(query);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return RecipeCard(
                        title: recipe.name,
                        cookTime: recipe.totalTime,
                        rating: recipe.rating.toString(),
                        thumbnailUrl: recipe.images,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailsPage(recipe: recipe),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is RecipeError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
          },
       );
    }
}

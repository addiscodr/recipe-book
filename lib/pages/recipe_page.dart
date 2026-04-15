import 'package:flutter/material.dart';
import '/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.6),
        title: Row(
          children: [
            Text(
              "Recipe",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300),
            ),
            Text(
              "Book",
              style: TextStyle(
                fontSize: 36,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetail(context),
          _ingredientsList(context),
          _recipeInstructions(context),
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(recipe.image),
        ),
      ),
    );
  }

  Widget _recipeDetail(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${recipe.cuisine}, ${recipe.difficulty}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(
            recipe.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "Prep Time: ${recipe.prepTimeMinutes} Minutes | Cook Time: ${recipe.cookTimeMinutes} Minutes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          Text(
            "Avg. Rating: ${recipe.rating} ⭐ | Reviews: ${recipe.reviewCount}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _ingredientsList(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: recipe.ingredients.map((i) {
          return Row(children: [Icon(Icons.check_box), Text(" $i")]);
        }).toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions.map((i) {
          return Text(
            "${recipe.instructions.indexOf(i) + 1}. $i",
            maxLines: 3,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15),
          );
        }).toList(),
      ),
    );
  }
}

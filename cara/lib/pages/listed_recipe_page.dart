import 'package:cara/constants/constants.dart';
import 'package:cara/pages/create_recipe_page.dart';
import 'package:cara/pages/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:cara/model/recipe_model.dart';
import 'package:cara/services/recipe_service.dart';

class ListedRecipePage extends StatefulWidget {
  const ListedRecipePage({super.key});

  @override
  State<ListedRecipePage> createState() => _ListedRecipePageState();
}

class _ListedRecipePageState extends State<ListedRecipePage> {
  final _recipeService = RecipeService();
  
  List<Recipe>? _recipeList;

  @override
  void initState() {
    super.initState();
    _fetchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          leading: Constants.mainIcon,
          title: const Text(Constants.appTitle, style: TextStyle(color: Constants.foregroundColor)),
          actions: [
            IconButton(
              icon: Constants.addRecipeIcon,
              tooltip: Constants.createRecipeTooltip,
              onPressed: () async {
                final bool? shouldRefresh = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRecipePage()),
                );
                if (shouldRefresh ?? false) {
                  await _fetchAllRecipes();
                }
              },
            ),
            IconButton(
              icon: Constants.randomRecipeIcon,
              tooltip: Constants.randomRecipeTooltip,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipePage(null)),
                );
              },
            ),
          ],
        ),
        body: _recipeList == null
            ? const Center(child: CircularProgressIndicator())
            : _buildRecipeList(),
      ),
    );
  }

  Widget _buildRecipeList() {
    return ListView.separated(
      padding: Constants.padding,
      itemCount: _recipeList!.length,
      itemBuilder: (context, index) {
        final recipe = _recipeList![index];

        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipePage(recipe.id)),
            );
            await _fetchAllRecipes();
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(Constants.imageBorderRadiusSmall),
                child: Image.network(
                  '${Constants.baseUrl}/${recipe.filePath}',
                  width: Constants.imageSizeSmall,
                  height: Constants.imageSizeSmall,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      width: Constants.imageSizeSmall,
                      height: Constants.imageSizeSmall,
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: Constants.imageSizeSmall,
                      height: Constants.imageSizeSmall,
                      child: Constants.defaultImageIcon,
                    );
                  },
                ),
              ),
              title: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: Constants.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Constants.openRecipeIcon,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }

  Future _fetchAllRecipes() async {
    try {
      final recipeList = await _recipeService.getAllRecipes();
      setState(() {
        _recipeList = recipeList;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${Constants.loadListErrorMessage} $e')));
    }
  }
}

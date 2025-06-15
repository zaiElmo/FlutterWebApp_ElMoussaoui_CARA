import 'package:cara/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cara/model/recipe_model.dart';
import 'package:cara/pages/update_recipe_page.dart';
import 'package:cara/services/recipe_service.dart';

class RecipePage extends StatefulWidget {
  const RecipePage(this.id, {super.key});
  final int? id;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final _recipeService = RecipeService();

  Recipe? _recipe;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _fetchRecipe();
    } else {
      _fetchRandomRecipe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        iconTheme: IconThemeData(color: Constants.foregroundColor),
        title: const Text(
          Constants.appTitle,
          style: TextStyle(color: Constants.foregroundColor),
        ),

        actions: [
          IconButton(
            icon: Constants.deleteRecipeIcon,
            tooltip: Constants.deleteRecipeTooltip,
            onPressed: () => _showDeleteDialog(context),
          ),
          IconButton(
            icon: Constants.updateRecipeIcon,
            tooltip: Constants.updateRecipeTooltip,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateRecipePage(_recipe!),
                ),
              );
              await _fetchRecipe();
            },
          ),
        ],
      ),
      body: _recipe == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: Constants.padding,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.foregroundColor,
                      borderRadius: BorderRadius.circular(
                        Constants.borderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Bild
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Constants.borderRadius),
                            topRight: Radius.circular(Constants.borderRadius),
                          ),
                          child: Image.network(
                            '${Constants.baseUrl}/${_recipe!.filePath}',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const SizedBox(
                                height: Constants.imageHeight,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                height: Constants.imageHeight,
                                child: Center(
                                  child: Constants.defaultImageIcon,
                                ),
                              );
                            },
                          ),
                        ),

                        // Inhalt
                        Padding(
                          padding: Constants.padding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _recipe!.title,
                                style: const TextStyle(
                                  fontSize: Constants.mainHeaderFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.accentColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Constants.durationIcon,
                                  const SizedBox(width: 8),
                                  Text(
                                    '${_recipe!.durationInMinutes} ${Constants.minutesLabel}',
                                    style: const TextStyle(
                                      fontSize: Constants.fontSize,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Constants.emptyBoxSizeHeight,
                              ),
                              Text(
                                Constants.descriptionLabel,
                                style: TextStyle(
                                  fontSize: Constants.subHeaderFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.accentColor,
                                ),
                              ),
                              Text(
                                _recipe!.description,
                                style: const TextStyle(
                                  fontSize: Constants.fontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future _fetchRecipe() async {
    try {
      final recipe = await _recipeService.getOneRecipe(widget.id);
      setState(() {
        _recipe = recipe;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${Constants.loadRecipeErrorMessage} $e')),
      );
    }
  }

  Future _fetchRandomRecipe() async {
    try {
      final recipe = await _recipeService.getRandomRecipe();
      setState(() {
        _recipe = recipe;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${Constants.loadRandomErrorMessage} $e')),
      );
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.deleteRecipeTitle),
        content: const Text(Constants.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(Constants.cancelText),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _recipeService.deleteRecipe(widget.id);
                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${Constants.deleteRecipeErrorMessage} $e'),
                  ),
                );
              }
            },
            child: const Text(Constants.deleteButton),
          ),
        ],
      ),
    );
  }
}

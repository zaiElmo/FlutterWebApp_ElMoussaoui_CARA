import 'dart:convert';

import 'package:cara/model/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart'; // für den Content-Type
import 'package:mime/mime.dart';

class RecipeService {
  static const BASE_URL = 'http://localhost:5000/recipes';

  Future<List<Recipe>> getAllRecipes() async {
    final response = await http.get(Uri.parse(BASE_URL));

    if (response.statusCode == 200) {
      // [{"id":1,"title":"Junaberry"},{"id":2,"title":"grüne Nudeln"}]
      final List<dynamic> dataList = jsonDecode(response.body);
      // dataList[0] = {"id":1,"title":"Junaberry"}
      // dataList[1] = {"id":2,"title":"grüne Nudeln"}

      List<Recipe> recipeList = [];
      for (int i = 0; i < dataList.length; i++) {
        recipeList.add(Recipe.fromJson(dataList[i]));
      }
      return recipeList;
    } else {
      throw Exception('Failed to load the recipes');
    }
  }

  Future<Recipe> postRecipe(
    String title,
    String description,
    String duration,
    XFile? imageFile,
  ) async {
    final uri = Uri.parse('$BASE_URL?title=$title&description=$description&durationInMinutes=$duration');
    var request = http.MultipartRequest('POST', uri);

    // Felder hinzufügen

    // Bild hinzufügen (optional)
    if (imageFile != null) {
      final mimeType = lookupMimeType(imageFile.name) ?? 'image/jpeg';
      final bytes = await imageFile.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // <-- Feldname im Backend
          bytes,
          filename: imageFile.name,
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    // Anfrage senden
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the recipes');
    }
  }

  Future<Recipe> getOneRecipe(id) async {
    final response = await http.get(Uri.parse('$BASE_URL/$id'));

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the recipes');
    }
  }

  Future<Recipe> putRecipe(
    int id,
    String title,
    String description,
    String durationInMinutes,
    XFile? imageFile,

  ) async {
    final uri = Uri.parse(
        '$BASE_URL/$id?title=$title&description=$description&durationInMinutes=$durationInMinutes',
      );
    var request = http.MultipartRequest('PUT', uri);

    if (imageFile != null) {
      final mimeType = lookupMimeType(imageFile.name) ?? 'image/jpeg';
      final bytes = await imageFile.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // <-- Feldname im Backend
          bytes,
          filename: imageFile.name,
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the recipes');
    }
  }

  Future<Recipe> getRandomRecipe() async {
    final response = await http.get(Uri.parse('$BASE_URL/random'));

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the recipes');
    }
  }

  Future deleteRecipe(id) async {
    final response = await http.delete(Uri.parse('$BASE_URL/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load the recipes');
    }
  }
}

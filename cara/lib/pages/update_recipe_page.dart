import 'package:cara/constants/constants.dart';
import 'package:cara/model/recipe_model.dart';
import 'package:cara/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateRecipePage extends StatefulWidget {
  const UpdateRecipePage(this.recipe, {super.key});
  final Recipe recipe;

  @override
  State<UpdateRecipePage> createState() => _UpdateRecipePageState();
}

class _UpdateRecipePageState extends State<UpdateRecipePage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _recipeService = RecipeService();

  String _title = '';
  String _description = '';
  String _duration = '';
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _title = widget.recipe.title;
    _description = widget.recipe.description;
    _duration = widget.recipe.durationInMinutes.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
        backgroundColor: Constants.mainColor,
        foregroundColor: Constants.foregroundColor,
      ),
      body: SingleChildScrollView(
        padding: Constants.padding,
        child: Center(
          child: Form(
            key: _formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.updateRecipeTitle,
                  style: TextStyle(
                    fontSize: Constants.mainHeaderFontSize,
                    fontWeight: FontWeight.bold,
                    color: Constants.mainColor,
                  ),
                ),
                const SizedBox(height: Constants.emptyBoxSizeHeight),

                // Titel
                TextFormField(
                  maxLength: Constants.titleMaxLength,
                  initialValue: _title,
                  decoration: InputDecoration(
                    labelText: Constants.labelRecipeName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Constants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.errorRecipeNameRequired;
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),

                // Beschreibung
                TextFormField(
                  maxLength: Constants.descriptionMaxLength,
                  maxLines: Constants.descriptionMaxLines,
                  minLines: Constants.descriptionMinLines,
                  keyboardType: TextInputType.multiline,
                  initialValue: _description,
                  decoration: InputDecoration(
                    labelText: Constants.labelRecipeDescription,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Constants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return Constants.errorRecipeDescriptionShort;
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),

                // Dauer
                TextFormField(
                  maxLength: Constants.durationMaxLength,
                  keyboardType: TextInputType.number,
                  initialValue: _duration,
                  decoration: InputDecoration(
                    labelText: Constants.labelDuration,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Constants.borderRadius),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.errorDurationEmpty;
                    }
                    if (int.tryParse(value) == null) {
                      return Constants.errorDurationNotANumber;
                    }
                    return null;
                  },
                  onSaved: (value) => _duration = value!,
                ),
                // Bild
                Text(
                  Constants.selectImageTitle,
                  style: TextStyle(
                    fontSize: Constants.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: _selectedImage == null
                      ? Container(
                          width: double.infinity,
                          height: Constants.imagePickerHeight,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(
                              Constants.borderRadius,
                            ),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Text(Constants.noImageSelectedText),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Constants.borderRadius,
                          ),
                          child: Image.network(
                            _selectedImage!.path,
                            width: double.infinity,
                            height: Constants.imagePickerHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(height: Constants.emptyBoxSizeHeight),

                // Speichern Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (_formGlobalKey.currentState!.validate()) {
                        _formGlobalKey.currentState!.save();
                        await _putRecipe();
                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Constants.mainColor,
                      foregroundColor: Constants.foregroundColor,
                      padding: Constants.padding,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Constants.borderRadius,
                        ),
                      ),
                    ),
                    child: const Text(
                      Constants.saveButtonText,
                      style: TextStyle(fontSize: Constants.fontSize),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  Future _putRecipe() async {
    try {
      await _recipeService.putRecipe(
        widget.recipe.id,
        _title,
        _description,
        _duration,
        _selectedImage,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${Constants.updateErrorMessage} $e')));
    }
  }
}

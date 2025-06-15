import 'package:flutter/material.dart';

class Constants {
  // URL
  static const String baseUrl = 'http://localhost:5000';

  // text
  static const String appTitle = 'CARA';
  static const String createRecipeTitle = 'Rezept erstellen';
  static const String createRecipeTooltip = 'Rezept hinzufügen?';
  static const String updateRecipeTitle = 'Rezept bearbeiten';
  static const String updateRecipeTooltip = 'Rezept bearbeiten?';
  static const String deleteRecipeTitle = 'Rezept löschen';
  static const String deleteRecipeTooltip = 'Rezept löschen?';
  static const String randomRecipeTooltip = 'Zufallsrezept erhalten?';
  static const String labelRecipeName = 'Name des Rezepts';
  static const String errorRecipeNameRequired = 'Trage den Rezeptnamen ein!';
  static const String labelRecipeDescription = 'Beschreibung des Rezepts';
  static const String errorRecipeDescriptionShort = 'Trage eine Rezeptbeschreibung mit mind. 5 Zeichen ein!';
  static const String labelDuration = 'Dauer in Minuten';
  static const String errorDurationEmpty = 'Trage die Rezeptdauer ein!';
  static const String errorDurationNotANumber = 'Trage eine Zahl ein!';
  static const String selectImageTitle = 'Bild auswählen';
  static const String noImageSelectedText = 'Kein Bild ausgewählt';
  static const String saveButtonText = 'Speichern';
  
  static const String updateErrorMessage = 'Fehler beim Aktualisieren:';
  static const String createErrorMessage = 'Fehler beim Erstellen:';
  static const String loadListErrorMessage = 'Fehler beim Laden der Rezepte:';
  static const String loadRecipeErrorMessage = 'Fehler beim Laden des Rezepts:';
  static const String loadRandomErrorMessage = 'Fehler beim Laden eines zufälligen Rezepts:';
  static const String deleteRecipeErrorMessage = 'Fehler beim Löschen des Rezepts:';

  static const String deleteConfirmation = 'Willst du das Rezept wirklich löschen?';
  static const String cancelText = 'Abbrechen';
  static const String deleteButton = 'Löschen';

  static const String minutesLabel = 'Minuten';
  static const String descriptionLabel = 'Beschreibung';

  // color
  static const Color mainColor = Color.fromARGB(255, 160, 67, 67);
  static const Color foregroundColor =  Colors.white;
  static const Color accentColor = Colors.redAccent;

  // size
  static const EdgeInsets padding = EdgeInsets.all(20);
  static const double mainHeaderFontSize = 24;
  static const double subHeaderFontSize = 20;
  static const double fontSize = 16;
  static const double emptyBoxSizeHeight = 16;

  static const int titleMaxLength = 30;
  static const double borderRadius = 12; 

  static const double imageBorderRadiusSmall = 40;
  static const double imageSizeSmall = 50;
  static const double imageHeight = 220;

  static const int descriptionMaxLength = 2000;
  static const int descriptionMaxLines = 6;
  static const int descriptionMinLines = 3;

  static const int durationMaxLength = 4;
  static const double imagePickerHeight = 200;

  // icons
  static const Icon mainIcon = Icon(Icons.menu_book, color: foregroundColor);
  static const Icon addRecipeIcon = Icon(Icons.add_circle_outline, color: foregroundColor);
  static const Icon randomRecipeIcon = Icon(Icons.casino, color: foregroundColor);
  static const Icon defaultImageIcon = Icon(Icons.local_dining);
  static const Icon openRecipeIcon = Icon(Icons.arrow_forward_ios_rounded, size: 18);
  static const Icon deleteRecipeIcon = Icon(Icons.delete, color: foregroundColor);
  static const Icon updateRecipeIcon = Icon(Icons.edit, color: foregroundColor);
  static const Icon durationIcon = Icon(Icons.timer, color: accentColor);

}
class Recipe {
  int id;
  String title;
  String description;
  int durationInMinutes;
  String filePath;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.durationInMinutes,
    required this.filePath
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      durationInMinutes: json['durationInMinutes'] ?? 0,
      filePath: json['imagePath'] ?? ''
    );
  }
}

class MovieProject {
  final String id;
  final String title;
  final String genre;
  final String logline;
  final DateTime createdAt;

  MovieProject({
    required this.id,
    required this.title,
    required this.genre,
    required this.logline,
    required this.createdAt,
  });
}

class Scene {
  final String id;
  final String title;
  final String description;

  Scene({required this.id, required this.title, required this.description});
}

class Character {
  final String id;
  final String name;
  final String role;

  Character({required this.id, required this.name, required this.role});
}

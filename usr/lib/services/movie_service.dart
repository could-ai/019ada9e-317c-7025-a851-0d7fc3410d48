import 'package:flutter/material.dart';
import '../models/movie_project.dart';

class MovieService extends ChangeNotifier {
  static final MovieService _instance = MovieService._internal();
  factory MovieService() => _instance;
  MovieService._internal();

  final List<MovieProject> _projects = [
    MovieProject(
      id: '1',
      title: 'The Last Starship',
      genre: 'Sci-Fi',
      logline: 'A lone pilot must save humanity from an alien blockade.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MovieProject(
      id: '2',
      title: 'Midnight in Paris',
      genre: 'Romance',
      logline: 'Two lovers meet in the city of lights under mysterious circumstances.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<MovieProject> get projects => List.unmodifiable(_projects);

  void addProject(MovieProject project) {
    _projects.add(project);
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/movie_project.dart';
import '../services/movie_service.dart';

class CreateMovieScreen extends StatefulWidget {
  const CreateMovieScreen({super.key});

  @override
  State<CreateMovieScreen> createState() => _CreateMovieScreenState();
}

class _CreateMovieScreenState extends State<CreateMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _loglineController = TextEditingController();
  
  final _genres = ['Action', 'Comedy', 'Drama', 'Sci-Fi', 'Horror', 'Romance', 'Documentary', 'Thriller'];
  String? _selectedGenre;

  @override
  void dispose() {
    _titleController.dispose();
    _genreController.dispose();
    _loglineController.dispose();
    super.dispose();
  }

  void _createProject() {
    if (_formKey.currentState!.validate()) {
      final newProject = MovieProject(
        id: const Uuid().v4(),
        title: _titleController.text,
        genre: _selectedGenre ?? 'Unknown',
        logline: _loglineController.text,
        createdAt: DateTime.now(),
      );

      MovieService().addProject(newProject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Movie Project'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Working Title',
                  hintText: 'e.g. The Matrix 5',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                value: _selectedGenre,
                items: _genres.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenre = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a genre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _loglineController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Logline / Premise',
                  hintText: 'A brief summary of the movie plot...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a logline';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _createProject,
                  child: const Text('Create Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

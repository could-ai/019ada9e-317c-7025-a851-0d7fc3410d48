import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import '../models/movie_project.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();

  @override
  void initState() {
    super.initState();
    _movieService.addListener(_update);
  }

  @override
  void dispose() {
    _movieService.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final projects = _movieService.projects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Studio'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: projects.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_creation_outlined, size: 64, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text(
                    'No movies yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  const Text('Start your first masterpiece today!'),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildProjectCard(context, project);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        icon: const Icon(Icons.add),
        label: const Text('New Project'),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, MovieProject project) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/dashboard', arguments: project);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[800],
                width: double.infinity,
                child: Center(
                  child: Icon(Icons.movie, size: 48, color: Colors.white54),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.genre,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.logline,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

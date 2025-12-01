import 'package:flutter/material.dart';
import '../models/movie_project.dart';

class MovieDashboardScreen extends StatefulWidget {
  const MovieDashboardScreen({super.key});

  @override
  State<MovieDashboardScreen> createState() => _MovieDashboardScreenState();
}

class _MovieDashboardScreenState extends State<MovieDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MovieProject _project;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is MovieProject) {
        _project = args;
      } else {
        // Fallback or error handling
        _project = MovieProject(
          id: '0',
          title: 'Error',
          genre: 'Error',
          logline: 'Project not found',
          createdAt: DateTime.now(),
        );
      }
      _tabController = TabController(length: 3, vsync: this);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_project.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.description), text: 'Script'),
            Tab(icon: Icon(Icons.people), text: 'Characters'),
            Tab(icon: Icon(Icons.grid_view), text: 'Storyboard'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScriptTab(),
          _buildCharactersTab(),
          _buildStoryboardTab(),
        ],
      ),
    );
  }

  Widget _buildScriptTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Text('1')),
            title: const Text('EXT. SPACE - NIGHT'),
            subtitle: const Text('The starship floats silently in the void...'),
            trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          ),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Text('2')),
            title: const Text('INT. COCKPIT - CONTINUOUS'),
            subtitle: const Text('The pilot wakes up from cryo-sleep...'),
            trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: FilledButton.tonalIcon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Scene'),
          ),
        ),
      ],
    );
  }

  Widget _buildCharactersTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.people_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('No characters added yet'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {},
            child: const Text('Add Character'),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryboardTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.dashboard_customize_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Storyboard empty'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {},
            child: const Text('Create Board'),
          ),
        ],
      ),
    );
  }
}

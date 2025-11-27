import 'package:flutter/material.dart';
import 'dart:math';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> _potentialMatches = [];
  User? _currentMatch;

  @override
  void initState() {
    super.initState();
    _loadPotentialMatches();
  }

  void _loadPotentialMatches() {
    // Mock data for potential matches
    _potentialMatches = [
      User(id: '1', name: 'Alice', age: 25, bio: 'Love hiking and photography'),
      User(id: '2', name: 'Bob', age: 28, bio: 'Music enthusiast and chef'),
      User(id: '3', name: 'Charlie', age: 30, bio: 'Travel lover and adventurer'),
      User(id: '4', name: 'Diana', age: 26, bio: 'Bookworm and yoga practitioner'),
    ];
  }

  void _randomMatch() {
    if (_potentialMatches.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(_potentialMatches.length);
      setState(() {
        _currentMatch = _potentialMatches[randomIndex];
      });
    }
  }

  void _likeMatch() {
    if (_currentMatch != null) {
      // Navigate to chat
      Navigator.pushNamed(context, '/chat', arguments: _currentMatch);
    }
  }

  void _startVideoCall() {
    if (_currentMatch != null) {
      Navigator.pushNamed(context, '/video_call', arguments: _currentMatch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Matches'),
      ),
      body: _currentMatch == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No current match. Find someone!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _randomMatch,
                    child: const Text('Random Match'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${_currentMatch!.name}, ${_currentMatch!.age}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(_currentMatch!.bio),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _randomMatch,
                        icon: const Icon(Icons.shuffle),
                        label: const Text('Random'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _likeMatch,
                        icon: const Icon(Icons.chat),
                        label: const Text('Chat'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _startVideoCall,
                        icon: const Icon(Icons.video_call),
                        label: const Text('Video Call'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

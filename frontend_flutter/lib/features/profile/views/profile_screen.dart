import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.workspace_premium, color: Color(0xFFE4FF00)),
                onPressed: () => context.push('/subscription'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('JALEN GREEN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=1200&auto=format&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black, // fallback
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withValues(alpha: 0.1), Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatBlock(title: 'Height', value: '6\'5"'),
                    _StatBlock(title: 'Position', value: 'SG'),
                    _StatBlock(title: 'Views', value: '14.2K'),
                  ],
                ),
              ),
              const Divider(color: Colors.white24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Highlight Reels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Open Camera/Gallery...')),
                        );
                      },
                      icon: const Icon(Icons.add, size: 18, color: Color(0xFFE4FF00)),
                      label: const Text('New', style: TextStyle(color: Color(0xFFE4FF00))),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE4FF00)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              // Fake grid of reels
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white54),
                  );
                },
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ],
      ), // <-- Added parenthesis and comma here to close CustomScrollView
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0), // Raise above custom navigation bar
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Upload Reel flow triggered...')),
            );
          },
          backgroundColor: const Color(0xFFE4FF00),
          foregroundColor: Colors.black,
          icon: const Icon(Icons.cloud_upload_rounded),
          label: const Text('UPLOAD REEL', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String title;
  final String value;
  const _StatBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}

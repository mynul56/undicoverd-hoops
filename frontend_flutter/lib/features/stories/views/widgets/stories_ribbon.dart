import 'package:flutter/material.dart';

class StoriesRibbon extends StatelessWidget {
  const StoriesRibbon({super.key});

  final List<Map<String, String>> mockStories = const [
    {
      'name': 'Jalen Green',
      'image': 'https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=200&auto=format&fit=crop',
      'hasUnseen': 'true',
    },
    {
      'name': 'Scoot H.',
      'image': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=200&auto=format&fit=crop',
      'hasUnseen': 'true',
    },
    {
      'name': 'Coach Cal',
      'image': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=200&auto=format&fit=crop',
      'hasUnseen': 'false',
    },
    {
      'name': 'Cooper F.',
      'image': 'https://images.unsplash.com/photo-1504450758481-7338eba7524a?q=80&w=200&auto=format&fit=crop',
      'hasUnseen': 'false',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: mockStories.length + 1, // +1 for "Your Story"
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _AddStoryItem();
          }
          final story = mockStories[index - 1];
          return _StoryItem(
            name: story['name']!,
            imageUrl: story['image']!,
            hasUnseen: story['hasUnseen'] == 'true',
          );
        },
      ),
    );
  }
}

class _AddStoryItem extends StatelessWidget {
  const _AddStoryItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade900,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white54, size: 32),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4FF00),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.black, size: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Story',
            style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool hasUnseen;

  const _StoryItem({
    required this.name,
    required this.imageUrl,
    required this.hasUnseen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasUnseen
                  ? const LinearGradient(
                      colors: [Color(0xFFE4FF00), Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: hasUnseen ? null : Border.all(color: Colors.white24, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 2),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: hasUnseen ? Colors.white : Colors.white54,
              fontSize: 12,
              fontWeight: hasUnseen ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

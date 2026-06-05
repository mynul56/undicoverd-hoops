import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  final List<Map<String, String>> mockEvents = const [
    {
      'title': 'Pangos All-American Camp',
      'date': 'JUL 15 - 18, 2026',
      'location': 'Las Vegas, NV',
      'host': 'Pangos Elite',
      'image': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=600&auto=format&fit=crop',
    },
    {
      'title': 'Nike EYBL Session 4',
      'date': 'JUL 22 - 25, 2026',
      'location': 'Augusta, GA',
      'host': 'Nike Basketball',
      'image': 'https://images.unsplash.com/photo-1504450758481-7338eba7524a?q=80&w=600&auto=format&fit=crop',
    },
    {
      'title': 'Undiscovered Regional Showcase',
      'date': 'AUG 10, 2026',
      'location': 'Dallas, TX',
      'host': 'Coach Cal',
      'image': 'https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=600&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        itemCount: mockEvents.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final event = mockEvents[index];
          return _EventCard(event: event);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create Event (Coach Only)')),
          );
        },
        backgroundColor: const Color(0xFFE4FF00),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('CREATE EVENT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, String> event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: NetworkImage(event['image']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['date']!,
                  style: const TextStyle(color: Color(0xFFE4FF00), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                const SizedBox(height: 4),
                Text(
                  event['title']!,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white54, size: 16),
                    const SizedBox(width: 4),
                    Text(event['location']!, style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.white54, size: 16),
                    const SizedBox(width: 4),
                    Text('Hosted by ${event['host']}', style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Application Submitted Successfully!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('APPLY NOW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

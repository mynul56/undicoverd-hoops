import 'package:flutter/material.dart';

class PipelineScreen extends StatefulWidget {
  const PipelineScreen({super.key});

  @override
  State<PipelineScreen> createState() => _PipelineScreenState();
}

class _PipelineScreenState extends State<PipelineScreen> {
  // Define the columns
  final List<String> columns = ['Watchlist', 'Evaluating', 'Contacted', 'Offered'];

  // Define the mock athletes and their current column
  final List<Map<String, dynamic>> athletes = [
    {'id': '1', 'name': 'Chet Holmgren', 'position': 'Center', 'status': 'Watchlist', 'image': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=200&auto=format&fit=crop'},
    {'id': '2', 'name': 'Jalen Green', 'position': 'Shooting Guard', 'status': 'Evaluating', 'image': 'https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=200&auto=format&fit=crop'},
    {'id': '3', 'name': 'Scoot Henderson', 'position': 'Point Guard', 'status': 'Contacted', 'image': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=200&auto=format&fit=crop'},
    {'id': '4', 'name': 'Cooper Flagg', 'position': 'Small Forward', 'status': 'Watchlist', 'image': 'https://images.unsplash.com/photo-1504450758481-7338eba7524a?q=80&w=200&auto=format&fit=crop'},
  ];

  void _moveAthlete(String athleteId, String newStatus) {
    setState(() {
      final index = athletes.indexWhere((a) => a['id'] == athleteId);
      if (index != -1) {
        athletes[index]['status'] = newStatus;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: columns.length,
        itemBuilder: (context, index) {
          final column = columns[index];
          final columnAthletes = athletes.where((a) => a['status'] == column).toList();

          return _buildKanbanColumn(column, columnAthletes);
        },
      ),
    );
  }

  Widget _buildKanbanColumn(String title, List<Map<String, dynamic>> columnAthletes) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(left: 16, top: 16, bottom: 80, right: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE4FF00), borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    '${columnAthletes.length}',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: DragTarget<String>(
              onAcceptWithDetails: (details) {
                _moveAthlete(details.data, title);
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  color: candidateData.isNotEmpty ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: columnAthletes.length,
                    itemBuilder: (context, index) {
                      final athlete = columnAthletes[index];
                      return _buildDraggableCard(athlete);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCard(Map<String, dynamic> athlete) {
    return LongPressDraggable<String>(
      data: athlete['id'] as String,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.8,
          child: _buildAthleteCard(athlete, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildAthleteCard(athlete),
      ),
      child: _buildAthleteCard(athlete),
    );
  }

  Widget _buildAthleteCard(Map<String, dynamic> athlete, {bool isDragging = false}) {
    return Container(
      width: 256, // Match the width of the column roughly
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: isDragging
            ? [BoxShadow(color: const Color(0xFFE4FF00).withValues(alpha: 0.3), blurRadius: 15)]
            : [],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(athlete['image'] as String),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  athlete['name'] as String,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  athlete['position'] as String,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.drag_indicator, color: Colors.white24, size: 20),
        ],
      ),
    );
  }
}

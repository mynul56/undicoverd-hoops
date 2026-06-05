import 'dart:math';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<Map<String, String>> _profiles = [
    {
      'name': 'Jalen Green',
      'position': 'Shooting Guard',
      'height': '6\'5"',
      'image': 'https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'Scoot Henderson',
      'position': 'Point Guard',
      'height': '6\'2"',
      'image': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'Chet Holmgren',
      'position': 'Center',
      'height': '7\'1"',
      'image': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=1200&auto=format&fit=crop'
    },
  ];

  Offset _dragOffset = Offset.zero;
  double _dragAngle = 0;
  bool _isDragging = false;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _dragAngle = 45 * (_dragOffset.dx / MediaQuery.of(context).size.width);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    if (_dragOffset.dx > 150) {
      _swipeCard(true); // Right swipe
    } else if (_dragOffset.dx < -150) {
      _swipeCard(false); // Left swipe
    } else {
      // Snap back
      setState(() {
        _dragOffset = Offset.zero;
        _dragAngle = 0;
      });
    }
  }

  void _swipeCard(bool isRight) {
    setState(() {
      _dragAngle = isRight ? 45 : -45;
      _dragOffset = Offset(isRight ? 1000 : -1000, 0);
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        if (_profiles.isNotEmpty) {
          _profiles.removeAt(0);
        }
        _dragOffset = Offset.zero;
        _dragAngle = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DISCOVER', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_profiles.isEmpty)
                    const Center(
                      child: Text('No more players to discover.', style: TextStyle(color: Colors.white54, fontSize: 18)),
                    ),
                  // Background cards
                  ..._profiles.asMap().entries.toList().reversed.map((entry) {
                    int index = entry.key;
                    var profile = entry.value;

                    if (index == 0) return const SizedBox.shrink(); // Front card rendered separately

                    double scale = 1.0 - (index * 0.05);
                    double topOffset = index * 10.0;
                    double bottomOffset = index * 20.0;

                    return Positioned(
                      top: topOffset,
                      bottom: bottomOffset,
                      left: 10.0 * index,
                      right: 10.0 * index,
                      child: _buildCard(profile, scale: scale, opacity: 1.0 - (index * 0.2)),
                    );
                  }),

                  // Front Card (Draggable)
                  if (_profiles.isNotEmpty)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onPanStart: _onPanStart,
                        onPanUpdate: _onPanUpdate,
                        onPanEnd: _onPanEnd,
                        child: AnimatedContainer(
                          duration: _isDragging ? Duration.zero : const Duration(milliseconds: 200),
                          transform: Matrix4.translationValues(_dragOffset.dx, _dragOffset.dy, 0)
                            ..rotateZ(_dragAngle * (pi / 180)),
                          transformAlignment: Alignment.center,
                          child: _buildCard(_profiles.first, scale: 1.0, opacity: 1.0, isFront: true),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.close, Colors.redAccent, () => _swipeCard(false)),
                _buildActionButton(Icons.star, Colors.blueAccent, () {}, size: 50),
                _buildActionButton(Icons.favorite, const Color(0xFFE4FF00), () => _swipeCard(true)),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, String> profile, {required double scale, required double opacity, bool isFront = false}) {
    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: NetworkImage(profile['image']!),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 1.0],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile['name']!,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.sports_basketball, color: Color(0xFFE4FF00), size: 20),
                    const SizedBox(width: 8),
                    Text(profile['position']!, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(width: 16),
                    const Icon(Icons.height, color: Color(0xFFE4FF00), size: 20),
                    const SizedBox(width: 8),
                    Text(profile['height']!, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                if (isFront)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('Top Prospect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap, {double size = 60}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade900,
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}

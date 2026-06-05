import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedPosition = 'All';
  String _selectedClass = 'All';
  double _minGpa = 2.0;
  RangeValues _heightRange = const RangeValues(60, 84); // 5'0" to 7'0"

  final List<String> _positions = ['All', 'PG', 'SG', 'SF', 'PF', 'C'];
  final List<String> _classes = ['All', '2024', '2025', '2026', '2027'];

  final List<Map<String, String>> _mockResults = [
    {
      'name': 'Jalen Green',
      'position': 'SG',
      'height': '6\'5"',
      'class': '2025',
      'gpa': '3.4',
      'image': 'https://images.unsplash.com/photo-1518063319789-7217e6706b04?q=80&w=600&auto=format&fit=crop'
    },
    {
      'name': 'Scoot Henderson',
      'position': 'PG',
      'height': '6\'2"',
      'class': '2024',
      'gpa': '3.1',
      'image': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=600&auto=format&fit=crop'
    },
    {
      'name': 'Chet Holmgren',
      'position': 'C',
      'height': '7\'1"',
      'class': '2024',
      'gpa': '3.8',
      'image': 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=600&auto=format&fit=crop'
    },
    {
      'name': 'Cooper Flagg',
      'position': 'SF',
      'height': '6\'9"',
      'class': '2025',
      'gpa': '3.9',
      'image': 'https://images.unsplash.com/photo-1504450758481-7338eba7524a?q=80&w=600&auto=format&fit=crop'
    },
  ];

  String _formatHeight(double inches) {
    int ft = inches ~/ 12;
    int ins = (inches % 12).toInt();
    return "$ft'$ins\"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('DATABASE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTopSearchBar(),
          _buildFilterMatrix(),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: _buildResultsGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search athletes by name...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterMatrix() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildDropdownFilter('Position', _positions, _selectedPosition, (v) => setState(() => _selectedPosition = v!)),
          const SizedBox(width: 16),
          _buildDropdownFilter('Class Year', _classes, _selectedClass, (v) => setState(() => _selectedClass = v!)),
          const SizedBox(width: 16),
          _buildHeightFilter(),
          const SizedBox(width: 16),
          _buildGpaFilter(),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(String title, List<String> items, String value, ValueChanged<String?> onChanged) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: value,
            isExpanded: true,
            dropdownColor: Colors.grey.shade900,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE4FF00)),
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildHeightFilter() {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Height Range', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${_formatHeight(_heightRange.start)}  -  ${_formatHeight(_heightRange.end)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          RangeSlider(
            values: _heightRange,
            min: 60,
            max: 90,
            divisions: 30,
            activeColor: const Color(0xFFE4FF00),
            inactiveColor: Colors.white24,
            onChanged: (values) {
              setState(() {
                _heightRange = values;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGpaFilter() {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Minimum GPA', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_minGpa.toStringAsFixed(1), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: _minGpa,
            min: 2.0,
            max: 4.0,
            divisions: 20,
            activeColor: const Color(0xFFE4FF00),
            inactiveColor: Colors.white24,
            onChanged: (value) {
              setState(() {
                _minGpa = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid() {
    // Filter logic mockup
    final results = _mockResults.where((athlete) {
      if (_selectedPosition != 'All' && athlete['position'] != _selectedPosition) return false;
      if (_selectedClass != 'All' && athlete['class'] != _selectedClass) return false;
      return true; // Simplified for demo
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final athlete = results[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(athlete['image']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 1.0],
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  athlete['name']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${athlete['position']} | ${athlete['height']}',
                      style: const TextStyle(color: Color(0xFFE4FF00), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'GPA: ${athlete['gpa']}',
                      style: const TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

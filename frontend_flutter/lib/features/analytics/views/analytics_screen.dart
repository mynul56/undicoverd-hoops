import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANALYTICS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _KpiBlock(title: 'Profile Views', value: '1.2K', trend: '+12%'),
                _KpiBlock(title: 'Reel Views', value: '14.5K', trend: '+45%'),
                _KpiBlock(title: 'Saves', value: '84', trend: '+5%'),
              ],
            ),
            const SizedBox(height: 32),

            // Engagement Graph
            const Text('Weekly Engagement', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(color: Colors.white54, fontSize: 10);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Mon'; break;
                            case 1: text = 'Tue'; break;
                            case 2: text = 'Wed'; break;
                            case 3: text = 'Thu'; break;
                            case 4: text = 'Fri'; break;
                            case 5: text = 'Sat'; break;
                            case 6: text = 'Sun'; break;
                            default: text = ''; break;
                          }
                          return SideTitleWidget(meta: meta, space: 4, child: Text(text, style: style));
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBar(0, 40),
                    _buildBar(1, 60),
                    _buildBar(2, 30),
                    _buildBar(3, 80),
                    _buildBar(4, 50),
                    _buildBar(5, 90),
                    _buildBar(6, 70),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Who Viewed Me Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Who Viewed Me', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                TextButton(
                  onPressed: () => context.push('/subscription'),
                  child: const Text('Unlock All', style: TextStyle(color: Color(0xFFE4FF00), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of Viewers (with blur)
            _ViewerTile(name: 'Coach Calipari', school: 'Kentucky Wildcats', time: '2h ago', isBlurred: false),
            _ViewerTile(name: 'Scout Smith', school: 'Overtime Elite', time: '5h ago', isBlurred: false),
            _ViewerTile(name: 'Hidden Coach', school: 'Division 1 Program', time: '1d ago', isBlurred: true, context: context),
            _ViewerTile(name: 'Hidden Scout', school: 'NBA Academy', time: '2d ago', isBlurred: true, context: context),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFE4FF00),
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.white10,
          ),
        ),
      ],
    );
  }
}

class _KpiBlock extends StatelessWidget {
  final String title;
  final String value;
  final String trend;

  const _KpiBlock({required this.title, required this.value, required this.trend});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.white54)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
          child: Text(trend, style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _ViewerTile extends StatelessWidget {
  final String name;
  final String school;
  final String time;
  final bool isBlurred;
  final BuildContext? context;

  const _ViewerTile({
    required this.name,
    required this.school,
    required this.time,
    required this.isBlurred,
    this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final tile = ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(school, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      trailing: Text(time, style: const TextStyle(color: Colors.white30, fontSize: 12)),
    );

    if (!isBlurred) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: tile,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: tile,
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (context != null) {
                  GoRouter.of(context!).push('/subscription');
                }
              },
              child: Container(
                color: Colors.transparent,
                child: const Center(
                  child: Icon(Icons.lock, color: Color(0xFFE4FF00), size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

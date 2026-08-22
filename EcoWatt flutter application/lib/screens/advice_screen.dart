import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/ecowatt_widgets.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final Set<int> appliedTips = {};
  List<Map<String, String>> tips = [];

  @override
  void initState() {
    super.initState();
    loadAdvice();
  }

  Future<void> loadAdvice() async {
    final csvData = await rootBundle.loadString('assets/data/advice.csv');

    final lines = csvData
        .split('\n')
        .skip(1)
        .where((line) => line.trim().isNotEmpty)
        .toList();

    final allTips = lines.map((line) {
      final parts = line.split(',');
      return {
        'type': parts[0].trim(),
        'title': parts[1].trim(),
        'advice': parts.sublist(2).join(',').trim(),
      };
    }).toList();

    allTips.shuffle();

    final Map<String, Map<String, String>> uniqueByType = {};

    for (var tip in allTips) {
      final type = tip['type']!;
      if (!uniqueByType.containsKey(type)) {
        uniqueByType[type] = tip;
      }
    }

    setState(() {
      tips = uniqueByType.values.take(10).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appliedCount = appliedTips.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 70),
            color: ecowattGreen,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Advice',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'AI-powered advice for you',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
  child: Stack(
    clipBehavior: Clip.none,
    children: [

      Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
          children: [
                      Transform.translate(
            offset: const Offset(0, -35),
            child: _GreatJobCard(appliedCount: appliedCount),
          ),

          const SizedBox(height:0),
            _ProgressCard(appliedCount: appliedCount),

            const SizedBox(height: 24),

            const Text(
              'Advice',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ecowattDark,
              ),
            ),

            const SizedBox(height: 6),

            const Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: ecowattGray),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Click on any advice to mark it as applied',
                    style: TextStyle(
                      fontSize: 12,
                      color: ecowattGray,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (tips.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              for (int i = 0; i < tips.length; i++) ...[
                _AdviceItem(
                  type: tips[i]['type']!,
                  title: tips[i]['title']!,
                  advice: tips[i]['advice']!,
                  applied: appliedTips.contains(i),
                  onTap: () {
                    setState(() {
                      if (appliedTips.contains(i)) {
                        appliedTips.remove(i);
                      } else {
                        appliedTips.add(i);
                      }
                    });
                  },
                ),

                const SizedBox(height: 14),
              ],
          ],
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

class _GreatJobCard extends StatelessWidget {
  final int appliedCount;

  const _GreatJobCard({required this.appliedCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF06C755),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              appliedCount == 0
                  ? 'Start applying advice to track your progress.'
                  : 'Great Job!\nYou’ve applied $appliedCount energy-saving advice.',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final int appliedCount;

  const _ProgressCard({required this.appliedCount});

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: ecowattGreen),
              SizedBox(width: 8),
              Text(
                'Your Progress',
                style: TextStyle(
                  color: ecowattDark,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            height: 92,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEFFDF4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$appliedCount\nAdvice Applied',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ecowattGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdviceItem extends StatelessWidget {
  final String type;
  final String advice;
  final String title;
  final bool applied;
  final VoidCallback onTap;

  const _AdviceItem({
    required this.type,
    required this.advice,
    required this.title,
    required this.applied,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: applied ? const Color(0xFFEFFDF4) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: applied ? const Color(0xFF86EFAC) : ecowattLightGray,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: applied,
              activeColor: ecowattGreen,
              onChanged: (_) => onTap(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: ecowattGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: ecowattDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    advice,
                    style: const TextStyle(
                      color: ecowattText,
                      fontSize: 14,
                      height: 1.45,
                    ),
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

class _WhiteCard extends StatelessWidget {
  final Widget child;

  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
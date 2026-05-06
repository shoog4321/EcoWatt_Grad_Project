import 'package:flutter/material.dart';
import '../widgets/ecowatt_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
   
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 92),
                decoration: const BoxDecoration(color: ecowattGreen),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back!', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Text("Let's track your energy usage", style: TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -72),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _BillCard(),
                      const SizedBox(height: 20),
                      _TrendCard(),
                      const SizedBox(height: 20),
                      _CompareCard(),
                      const SizedBox(height: 20),
                      _AdviceCard(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BillCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Current Month Bill', style: TextStyle(color: ecowattGray, fontSize: 14)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(50)),
                child: const Row(
                  children: [
                    Icon(Icons.trending_down, size: 14, color: ecowattGreen),
                    SizedBox(width: 4),
                    Text('9.7%', style: TextStyle(color: ecowattGreen, fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('650', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.black)),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('SAR', style: TextStyle(fontSize: 16, color: ecowattText)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text('vs last month:  -70 SAR', style: TextStyle(fontSize: 13, color: ecowattText)),
        ],
      ),
    );
  }
}

class _TrendCard extends StatefulWidget {
  @override
  State<_TrendCard> createState() => _TrendCardState();
}

class _TrendCardState extends State<_TrendCard> {
  int? selectedIndex;

  final months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final consumption = [850, 920, 780, 690, 720, 650];
  final withAdvice = [850, 900, 740, 660, 670, 610];

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '6-Month Consumption Trend',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),

          const Row(
            children: [
              Icon(Icons.circle, size: 10, color: ecowattGreen),
              SizedBox(width: 4),
              Text(
                'Actual Consumption',
                style: TextStyle(fontSize: 12, color: ecowattText),
              ),
              SizedBox(width: 14),
              Icon(Icons.circle, size: 10, color: Color(0xFF86EFAC)),
              SizedBox(width: 4),
              Text(
                'Potential Saving',
                style: TextStyle(fontSize: 12, color: ecowattText),
              ),
            ],
          ),

          const SizedBox(height: 16),

         GestureDetector(
  onTapDown: (details) {
    final width = context.size?.width ?? 300;
    final dx = details.localPosition.dx;
    final chartWidth = width - 60;

    final tappedIndex =
        ((dx - 35) / (chartWidth / 5)).round().clamp(0, 5);

    setState(() {
      if (selectedIndex == tappedIndex) {
        selectedIndex = null;
      } else {
        selectedIndex = tappedIndex;
      }
    });
  },
  child: Stack(
    children: [
      SizedBox(
        height: 230,
        child: CustomPaint(
          painter: _LineChartPainter(
            selectedIndex: selectedIndex,
            consumption: consumption,
            withAdvice: withAdvice,
            months: months,
          ),
          child: Container(),
        ),
      ),

      if (selectedIndex != null)
        Positioned(
          left: (selectedIndex! * 38.0 + 78).clamp(40, 170),
          top: 55,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '${months[selectedIndex!]}\n'
              'consumption : ${consumption[selectedIndex!]}\n'
              'Potential Saving : ${withAdvice[selectedIndex!]}',
              style: const TextStyle(
                fontSize: 14,
                color: ecowattGreen,
                height: 1.7,
              ),
            ),
          ),
        ),
    ],
  ),
),

const SizedBox(height: 12),

const Text.rich(
  TextSpan(
    text: 'Reduce your next bill by: ',
    style: TextStyle(fontSize: 13, color: ecowattText),
    children: [
      TextSpan(
        text: '44 SAR/month ',
        style: TextStyle(
          color: ecowattGreen,
          fontWeight: FontWeight.w700,
        ),
      ),
      TextSpan(text: 'with our personalized advice'),
    ],
  ),
),
        ],
      ),
    );
  }
}
class _CompareCard extends StatefulWidget {
  @override
  State<_CompareCard> createState() => _CompareCardState();
}

class _CompareCardState extends State<_CompareCard> {
  String? selectedBar;

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How You Compare',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 22),

          GestureDetector(
            onTapDown: (details) {
  final dx = details.localPosition.dx;

  String tappedBar;

  if (dx < 170) {
    tappedBar = 'home';
  } else {
    tappedBar = 'similar';
  }

  setState(() {
    if (selectedBar == tappedBar) {
      selectedBar = null; 
    } else {
      selectedBar = tappedBar; 
    }
  });
},
            child: Stack(
              children: [
                SizedBox(
                  height: 190,
                  child: CustomPaint(
                    painter: _BarChartPainter(),
                    child: Container(),
                  ),
                ),

                if (selectedBar == 'home')
                  Positioned(
                    left: 105,
                    top: 35,
                    child: _ChartTooltip(
                      title: 'Your Home',
                      value: 'consumption : 650',
                    ),
                  ),

                if (selectedBar == 'similar')
                  Positioned(
                    left: 135,
                    top: 35,
                    child: _ChartTooltip(
                      title: 'Similar Homes',
                      value: 'consumption : 720',
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          const Text.rich(
            TextSpan(
              text: "You're using ",
              style: TextStyle(fontSize: 13, color: ecowattText),
              children: [
                TextSpan(
                  text: '9.7% less',
                  style: TextStyle(
                    color: ecowattGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(text: ' than similar homes'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartTooltip extends StatelessWidget {
  final String title;
  final String value;

  const _ChartTooltip({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text.rich(
        TextSpan(
          text: '$title\n',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            height: 1.7,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: ecowattGreen,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: ecowattGreen,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.white, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Get Personalized Energy\nAdvice', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.25)),
                SizedBox(height: 10),
                Text(
                  'Visit the Advice page to receive AI-powered recommendations tailored to your household energy consumption patterns.',
                  style: TextStyle(color: Colors.white, fontSize: 13, height: 1.35),
                ),
              ],
            ),
          ),
        ],
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
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final int? selectedIndex;
  final List<int> consumption;
  final List<int> withAdvice;
  final List<String> months;

  _LineChartPainter({
    required this.selectedIndex,
    required this.consumption,
    required this.withAdvice,
    required this.months,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const left = 38.0;
    const top = 10.0;
    const bottom = 36.0;
    final chartWidth = size.width - left - 8;
    final chartHeight = size.height - top - bottom;

    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2;

    final line1Paint = Paint()
      ..color = ecowattGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final line2Paint = Paint()
      ..color = const Color(0xFF86EFAC)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    double yValue(int value) {
      return top + chartHeight - (value / 1000) * chartHeight;
    }

    double xValue(int index) {
      return left + (chartWidth / 5) * index;
    }

    final tp = TextPainter(textDirection: TextDirection.ltr);

    final yLabels = [1000, 750, 500, 250, 0];

    for (final label in yLabels) {
      final y = yValue(label);
      canvas.drawLine(Offset(left, y), Offset(size.width - 8, y), gridPaint);

      tp.text = TextSpan(
        text: '$label',
        style: const TextStyle(fontSize: 10, color: ecowattGray),
      );
      tp.layout();
      tp.paint(canvas, Offset(0, y - 7));
    }

    canvas.drawLine(Offset(left, top), Offset(left, top + chartHeight), axisPaint);
    canvas.drawLine(
      Offset(left, top + chartHeight),
      Offset(size.width - 8, top + chartHeight),
      axisPaint,
    );

    Path buildPath(List<int> data) {
      final path = Path();
      for (int i = 0; i < data.length; i++) {
        final point = Offset(xValue(i), yValue(data[i]));
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      return path;
    }

    canvas.drawPath(buildPath(consumption), line1Paint);
    canvas.drawPath(buildPath(withAdvice), line2Paint);

    for (int i = 0; i < months.length; i++) {
      final p1 = Offset(xValue(i), yValue(consumption[i]));
      final p2 = Offset(xValue(i), yValue(withAdvice[i]));

      canvas.drawCircle(p1, 5, Paint()..color = ecowattGreen);
      canvas.drawCircle(p2, 5, Paint()..color = const Color(0xFF86EFAC));

      tp.text = TextSpan(
        text: months[i],
        style: const TextStyle(fontSize: 11, color: ecowattGray),
      );
      tp.layout();
      tp.paint(canvas, Offset(xValue(i) - 10, size.height - 22));
    }

    if (selectedIndex != null) {
      final x = xValue(selectedIndex!);
      canvas.drawLine(
        Offset(x, top),
        Offset(x, top + chartHeight),
        Paint()
          ..color = const Color(0xFFCBD5E1)
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const left = 38.0;
    const top = 10.0;
    const bottom = 32.0;
    final chartWidth = size.width - left - 8;
    final chartHeight = size.height - top - bottom;

    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2;

    final barPaint = Paint()..color = ecowattGreen;

    final tp = TextPainter(textDirection: TextDirection.ltr);

    double yValue(int value) {
      return top + chartHeight - (value / 800) * chartHeight;
    }

    final labels = [800, 600, 400, 200, 0];

    for (final label in labels) {
      final y = yValue(label);
      canvas.drawLine(Offset(left, y), Offset(size.width - 8, y), gridPaint);

      tp.text = TextSpan(
        text: '$label',
        style: const TextStyle(fontSize: 10, color: ecowattGray),
      );
      tp.layout();
      tp.paint(canvas, Offset(0, y - 7));
    }

    canvas.drawLine(Offset(left, top), Offset(left, top + chartHeight), axisPaint);
    canvas.drawLine(
      Offset(left, top + chartHeight),
      Offset(size.width - 8, top + chartHeight),
      axisPaint,
    );

    final barWidth = 60.0;

    final homeValue = 650;
    final similarValue = 720;

    final homeX = left + chartWidth * 0.22;
    final similarX = left + chartWidth * 0.62;

    final homeY = yValue(homeValue);
    final similarY = yValue(similarValue);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(homeX, homeY, barWidth, top + chartHeight - homeY),
        const Radius.circular(8),
      ),
      barPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(similarX, similarY, barWidth, top + chartHeight - similarY),
        const Radius.circular(8),
      ),
      barPaint,
    );

    tp.text = const TextSpan(
      text: 'Your Home',
      style: TextStyle(fontSize: 10, color: ecowattGray),
    );
    tp.layout();
    tp.paint(canvas, Offset(homeX + 3, size.height - 18));

    tp.text = const TextSpan(
      text: 'Similar Homes',
      style: TextStyle(fontSize: 10, color: ecowattGray),
    );
    tp.layout();
    tp.paint(canvas, Offset(similarX - 2, size.height - 18));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
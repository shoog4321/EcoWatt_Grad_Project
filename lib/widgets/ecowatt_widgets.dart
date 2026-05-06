import 'package:flutter/material.dart';

const Color ecowattGreen = Color(0xFF08A045);
const Color ecowattDark = Color(0xFF101828);
const Color ecowattText = Color(0xFF4A5565);
const Color ecowattGray = Color(0xFF717182);
const Color ecowattLight = Color(0xFFF0FDF4);
const Color ecowattLightGray = Color(0xFFE5E7EB);
class EcowattScaffold extends StatelessWidget {
  final Widget child;
  final bool showBack;
  final String? stepText;
  final double? progress;

  const EcowattScaffold({
    super.key,
    required this.child,
    this.showBack = false,
    this.stepText,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (showBack || stepText != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
  if (showBack)
    GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Row(
        children: [
          Icon(Icons.chevron_left, size: 22, color: ecowattText),
          SizedBox(width: 4),
          Text(
            'Back',
            style: TextStyle(
              color: ecowattText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),

  if (stepText != null)
    Text(
      stepText!,
      style: const TextStyle(
        color: ecowattGray,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
],
                ),
              ),
            if (progress != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LinearProgressIndicator(
                  value: progress,
                  color: ecowattGreen,
                  backgroundColor: Color(0xFFE5E7EB),
                  minHeight: 8,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class EcowattButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  const EcowattButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: outlined ? Colors.white : ecowattGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: outlined
                ? const BorderSide(color: ecowattGreen)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: outlined ? ecowattGreen : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class EcowattTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const EcowattTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  State<EcowattTextField> createState() => _EcowattTextFieldState();
}

class _EcowattTextFieldState extends State<EcowattTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Color(0xFF0A0A0A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: ecowattGray, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF3F3F5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: ecowattGray,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
class OptionTile extends StatelessWidget {
  final String text;
  final bool checkbox;
  final bool selected;
  final VoidCallback? onTap;

  const OptionTile({
    super.key,
    required this.text,
    this.checkbox = false,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? ecowattGreen : ecowattLightGray,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: selected ? ecowattGreen : Colors.white,
                shape: checkbox ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: checkbox ? BorderRadius.circular(4) : null,
                border: Border.all(
                  color: selected ? ecowattGreen : ecowattLightGray,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
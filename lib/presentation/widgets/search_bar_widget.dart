import 'package:flutter/material.dart';
import '../../core/utils/debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  final String query;
  final ValueChanged<String> onChanged;

  const SearchBarWidget({
    super.key,
    required this.query,
    required this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withAlpha(50) : Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            _debouncer.run(() {
              widget.onChanged(value);
            });
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search products by name...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? const Color(0xFF94A3B8) : Colors.grey.shade500,
            ),
            prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF635BFF)),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 20),
                    onPressed: () {
                      _controller.clear();
                      widget.onChanged('');
                      setState(() {});
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}

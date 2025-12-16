import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final bool isLoading;

  const SearchBarWidget({
    Key? key,
    required this.onSearch,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSearch(_controller.text.trim());
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: AppTheme.softShadow,
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: !widget.isLoading,
                decoration: InputDecoration(
                  hintText: 'Rechercher une ville...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(
                    FontAwesomeIcons.locationDot,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: widget.isLoading ? null : _handleSearch,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: widget.isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          )
              .animate(target: widget.isLoading ? 0 : 1)
              .scale(duration: 200.ms),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(
      begin: -0.2,
      duration: 400.ms,
      curve: Curves.easeOut,
    );
  }
}
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final VoidCallback? onTapSearch;
  final VoidCallback? unfocusAction;
  final VoidCallback? onTapClearButton;
  final Function(String)? onChanged;

  final TextEditingController controller;
  final bool isVisibleSuffixIcon;
  final double? width;
  final FocusNode? focusNode;
  const Search({
    super.key,
    this.onEditingComplete,
    this.onChanged,
    this.focusNode,
    this.onTap,
    this.onTapSearch,
    this.onTapClearButton,
    required this.controller,
    this.width,
    this.isVisibleSuffixIcon = true,
    this.unfocusAction,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _focusNode.unfocus();

        widget.unfocusAction?.call();
      }
    });
  }

  @override
  dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Theme.of(context).colorScheme.surfaceBright,
        ),
        // width: width ?? MediaQuery.of(context).size.width * 0.6,
        child: Center(
          child: TextField(
            onTap: widget.onTap,
            controller: widget.controller,
            focusNode: _focusNode,
            autofocus: false,
            onChanged: widget.onChanged,
            // style: AppTextTheme.title_16,
            onEditingComplete: () {
              _focusNode.unfocus();
              widget.onEditingComplete;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 14),
              fillColor: Colors.transparent,
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              hintText: 'Search',
              hintStyle: const TextStyle(fontFamily: 'Inter', fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
